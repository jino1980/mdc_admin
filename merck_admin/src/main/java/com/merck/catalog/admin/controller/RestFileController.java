package com.merck.catalog.admin.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.merck.catalog.admin.service.BoardCommonService;
import com.merck.catalog.admin.service.CatalogService;
import com.merck.catalog.common.SoftLabHumUtils;


@Controller
public class RestFileController {

    private final Logger logger = LoggerFactory.getLogger(RestFileController.class);
    
    @Autowired
	private ServletContext svCtx;
    
    @Autowired
    private CatalogService cataSvc;
    
    @Autowired
    private BoardCommonService fileSvc;
    
      
    @ResponseBody
	@RequestMapping(value = "/file/upload/multi",  headers = "Content-Type= multipart/form-data", method = RequestMethod.POST)
	public String fileUpload( @RequestParam("uploadFiles") List<MultipartFile> multipartFile, HttpServletRequest request) throws Exception {
    	
    	logger.debug("#### fileUpload request=>>{}",request);
    	logger.debug("#### fileUpload request.getAttributeNames =>>{}",request.getAttributeNames());
    	logger.debug("#### fileUpload request=>>{}",request);
    	logger.debug("#### fileUpload multipartFile.size() =>>{}",multipartFile.size());
    	
    	HashMap map = new HashMap();
    	Enumeration em = request.getParameterNames();
		while ( em.hasMoreElements() ){
			String name = (String) em.nextElement();
			String[] values = request.getParameterValues(name);		
			for (String value : values) {
				logger.debug("\n#### FileUpload... @name=" + name + ",@value=" + value);
				map.put(name, value);
			}   
		}
    	
		/**
		 * todo : 로그인세션 정보로 사용자 아이디 변경
		 */
		map.put("registUsrId", "SOFTLAB");
		map.put("updtUsrId", "SOFTLAB");
		
		// 파일 delete
		deleteUploadFiles(map);
		
		// 파일 insert / update
		saveUploadedFiles(multipartFile, map);
		
		
		// 파입업로드 후처리 업무에 맞게 그룹아이디를 업무 테이블에 update 
		String taskSe = (String)map.get("taskSe");
		String attchType = (String)map.get("attchType");
			
		if("CATA".equals(taskSe) ) {
			
			if( "IMG".equals(attchType)) cataSvc.updateForImgGrp(map);
			if( "PDF".equals(attchType)) cataSvc.updateForCtalgGrp(map);
			
		}else if("NOTC_HELP".contains(taskSe)) {
			
			if( "IMG".equals(attchType)) fileSvc.updateForImgGrp(map);
		}
			
    	return multipartFile.size()+"";
    }

    
    // delete file
	private int deleteUploadFiles(HashMap map) throws Exception {
		
		int rtnCnt = 0;
		String deleteFiles = (String)map.get("delFileIds"); 
		String delFileArr[] = deleteFiles.split(",");
		
		logger.debug("\n\n ### deleteUploadFiles length=> _{}_ / delFileArr=> _{}_",delFileArr.length,delFileArr);
		
		for (int i = 0; i <= delFileArr.length-1; i++) {
					
			logger.debug("\n\n ### delFileArr[{}] => _{}_",i,delFileArr[i]);
			
			String fileId = delFileArr[i];
			String fileGrpId = (fileId.length()==10?fileId.substring(0,8):"");
			
			if( SoftLabHumUtils.isNull(fileId) ) continue;
			
			map.put("fileGrpId", fileGrpId);
			map.put("fileId", fileId);
			
			Map<String, Object> delFile = fileSvc.selectAttchFile(map);
			rtnCnt += fileSvc.deleteAttchFile(map);
			
			if( !SoftLabHumUtils.isNull(delFile) ){
				String filePath = (String)delFile.get("filePath");
				String fileNm = (String)delFile.get("fileNm");
				String fileExt = (String)delFile.get("fileExt");
				
				logger.debug("\n\n ### FILE DELETE .. FILE => _{}_",svCtx.getRealPath(filePath) + fileNm + "."+fileExt);
				
	            File file = new File( svCtx.getRealPath(filePath) + fileNm +"."+ fileExt);
	            
	            if(file.exists()){
	            	if(file.delete()) {
	            		logger.debug("### FILE DELETE COMPLETE!!!");
	            	}else {
	            		logger.debug("### FILE DELETE FAIL...");
	            	}
	            }else {
	            	logger.debug("### FILE NOT FOUND...");
	            }
            }
		}
		
		return rtnCnt;
	}
    

    //save file
    private void saveUploadedFiles(List<MultipartFile> files,HashMap<String, Object> paramMap) throws Exception {
    	
    	String taskSe = SoftLabHumUtils.nvl((String)paramMap.get("taskSe"));
    	String attchType = SoftLabHumUtils.nvl((String)paramMap.get("attchType"));
    	String fileGrpId = SoftLabHumUtils.nvl((String)paramMap.get("fileGrpId"));
    	
    	DateFormat dfFormat = new SimpleDateFormat("yyyyMMdd");
        Date nowDate = new Date();
        String toDate = dfFormat.format(nowDate);
        String filePath = "/resources/attchFile/"+toDate+"/"+attchType+"/"+taskSe+"/";

    	
        int idx = 1;
        for (MultipartFile file : files) {

            if (file.isEmpty()) {
                continue; //next pls
            }
            
            logger.debug("### saveUploadedFiles=>> file.getContentType {}",file.getContentType());
            logger.debug("### saveUploadedFiles=>> file.getName {}",file.getName());
            logger.debug("### saveUploadedFiles=>> file.getOriginalFilename {}",file.getOriginalFilename());
            logger.debug("### saveUploadedFiles=>> file.getSize {}",file.getSize());
            
            String fNm = (file.getOriginalFilename()).substring(0,file.getOriginalFilename().indexOf("."));
            String fExt = (file.getOriginalFilename()).substring(file.getOriginalFilename().indexOf(".")+1,file.getOriginalFilename().length());
            logger.debug("### saveUploadedFiles=>> fNm {}",fNm);
            logger.debug("### saveUploadedFiles=>> fExt {}",fExt);
            
            paramMap.put("fileNm",fNm);
            paramMap.put("fileExt",fExt);
            paramMap.put("fileLenth",file.getSize());
            paramMap.put("filePath",filePath);
            paramMap.put("fileUrl","/file/download/");
            paramMap.put("thmnlImgYn","Y");
            paramMap.put("sortSn",idx);
            
            byte[] bytes = file.getBytes();
            Path path = Paths.get( svCtx.getRealPath(filePath) + file.getOriginalFilename());
            File folder = new File( svCtx.getRealPath(filePath) );
            
            
            if(!folder.exists()){ 
            	folder.mkdirs();
            }
            Files.write(path, bytes);
            
            // 파일그룹아이디 생성
            String newFileId = "";
            if(idx==1 && SoftLabHumUtils.isNull(fileGrpId)) {
            	newFileId = fileSvc.insertAttchFile(paramMap);
            }else {
            	// 파일그룹별 파일아이디 생성
            	newFileId =  fileSvc.insertAttchFile(paramMap);        
            }
            
            
            logger.debug("\n\n\n---------------------------------------------------------");
            logger.debug("### insertAttchFile =>> newFileId => {}",newFileId);
            logger.debug("---------------------------------------------------------");
            
            ++idx;
        }
    }
    
    
    @RequestMapping(value = "/file/download/{attchType}/{taskUid}/{fileGrpId}", method = {RequestMethod.GET})
	public void download(HttpServletRequest request  , HttpServletResponse response , @PathVariable String attchType ,@PathVariable String taskUid, @PathVariable String fileGrpId) throws Exception {
    	
    	logger.debug("### file downlad.. attchType=>{} , fileGrpId=>>{}",attchType,fileGrpId);
    	
    	HashMap<String,Object> paramMap = new HashMap();
    	List<Map<String, Object>> rtnList = new ArrayList();
    	
    	if("IMG".equals(attchType) ) {
    		//paramMap.put("taskSe", "");
    		paramMap.put("imgFileGrpId", fileGrpId.substring(0,8));
    		if(fileGrpId.length()==10) paramMap.put("imgFileId", fileGrpId);
    		rtnList = fileSvc.selectImgGrpList(paramMap);
    		
    	}else if("CAA".equals(attchType)) {
    		paramMap.put("catlgId", taskUid);
    		paramMap.put("catlgFileGrpId", fileGrpId.substring(0,8));
    		if(fileGrpId.length()==10) paramMap.put("catlgFileId", fileGrpId);
    		rtnList = fileSvc.selectCatalogGrpList(paramMap);
    	}
    	
    	
    	for (Map<String, Object> map : rtnList) {
			
    		String fileName = SoftLabHumUtils.nvl((String)map.get("fileNm"));
    		//String fileName = "abcd efg\t한글제목\t`~!@#$%^&*()-_=+[{]}\\|;:'\",<.>/?.txt";
    		//String fileContent = "abcd efg\t한글내용\t`~!@#$%^&*()-_=+[{]}\\|;:'\",<.>/?";
    		
    		String fileExt = SoftLabHumUtils.nvl((String)map.get("fileExt"));
    		String fileSize = SoftLabHumUtils.nvl(String.valueOf(map.get("fileLenth")));
    		String filePath = SoftLabHumUtils.nvl((String)map.get("filePath"));
    		String fileUrl = SoftLabHumUtils.nvl((String)map.get("fileUrl"));
    		
    		String saveFileName = svCtx.getRealPath(filePath)+fileName+"."+fileExt; 
    		String contentType = (attchType.equals("IMG")?"image/png":"application/octet-stream; charset=utf-8");
    	    		
 
    		// 브라우저 별 한글 인코딩
    		String header = request.getHeader("User-Agent");
    		if (header.contains("Edge")){
    			fileName = URLEncoder.encode(fileName, "UTF-8").replaceAll("\\+", "%20");
    		    response.setHeader("Content-Disposition", "attachment;filename=\"" + fileName + "\"."+fileExt+";");
    		} else if (header.contains("MSIE") || header.contains("Trident")) { // IE 11버전부터 Trident로 변경되었기때문에 추가해준다.
    			fileName = URLEncoder.encode(fileName, "UTF-8").replaceAll("\\+", "%20");
    		    response.setHeader("Content-Disposition", "attachment;filename=" + fileName + "."+fileExt+";");
    		} else if (header.contains("Chrome")) {
    			fileName = new String(fileName.getBytes("UTF-8"), "ISO-8859-1");
    		    response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"."+fileExt+"");
    		} else if (header.contains("Opera")) {
    			fileName = new String(fileName.getBytes("UTF-8"), "ISO-8859-1");
    		    response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"."+fileExt+"");
    		} else if (header.contains("Firefox")) {
    			fileName = new String(fileName.getBytes("UTF-8"), "ISO-8859-1");
    		    response.setHeader("Content-Disposition", "attachment; filename=" + fileName + "."+fileExt+"");
    		}

    		
    		response.setHeader("Content-Transfer-Encoding", "binary");
    		response.setHeader("Content-Type", contentType);
    		response.setHeader("Content-Length", "" + fileSize);
    		response.setHeader("Pragma", "no-cache;");
    		response.setHeader("Expires", "-1;");
    		
    		try(
    				FileInputStream fis = new FileInputStream(saveFileName);
    				OutputStream out = response.getOutputStream();
    				){
    			int readCount = 0;
    			byte[] buffer = new byte[1024];
    			while((readCount = fis.read(buffer)) != -1){
    				out.write(buffer,0,readCount);
    			}
    		}catch(Exception ex){
    			throw new RuntimeException("########### file Save Error");
    		}
    		
		}
	}
}