package com.merck.catalog.admin.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.merck.catalog.admin.controller.BoardCommonController;
import com.merck.catalog.admin.vo.TbCab001m;
import com.merck.catalog.admin.vo.TbCab002d;
import com.merck.catalog.admin.vo.TbCab004d;
import com.merck.catalog.admin.vo.TbCac001d;
import com.merck.catalog.admin.vo.TbSaf002d;
import com.merck.catalog.admin.vo.TbSaf003d;
import com.merck.catalog.common.SoftLabHumUtils;

@Repository
public class BoardCommonDAO<T> extends CommonDaoImpl<TbCab001m>{
	
	private static final Logger logger = LoggerFactory.getLogger(BoardCommonController.class);
	
	private final String NAMESPACE = "com.merck.catalog.admin.dao.BoardCommon.";
	private final String TB_CAB001M_NAMESPACE = "com.merck.catalog.admin.dao.TbCab001mMapper."; // 게시판 기본
	private final String TB_CAB002D_NAMESPACE = "com.merck.catalog.admin.dao.TbCab002dMapper."; // 게시판 상세
	private final String TB_CAB004D_NAMESPACE = "com.merck.catalog.admin.dao.TbCab004dMapper."; // 문의담당자 상세
	private final String TB_CAC001D_NAMESPACE = "com.merck.catalog.admin.dao.TbCac001dMapper."; // 푸시상세
	private final String TB_SAF001D_NAMESPACE = "com.merck.catalog.admin.dao.TbSaf001dMapper."; // 첨부파일
	private final String TB_SAF002D_NAMESPACE = "com.merck.catalog.admin.dao.TbSaf002dMapper."; // 이미지파일
	private final String TB_SAF003D_NAMESPACE = "com.merck.catalog.admin.dao.TbSaf003dMapper."; // 카달로그 파일
	
	
	public List<Map<String, Object>> selectBoardCommonList(HashMap<String,Object> map) {
		String taskSe = (String)map.get("taskSe");
		String mapperId = NAMESPACE+"selectTaskBoardList";
		
		if("QNAM".contains(taskSe)) {
			mapperId = NAMESPACE+"selectQnamBoardList";
		}
	    return sqlSession.selectList(mapperId, map);
	}
	
	/**
	 * 문의담당자 조회
	 * @param map
	 * @return
	 */
	public List<Map<String, Object>> selectQnamList(HashMap<String,Object> map) {
		String taskSe = (String)map.get("taskSe");
		String mapperId = NAMESPACE+"selectQnamList";
	    return sqlSession.selectList(mapperId, map);
	}
	/**
	 * 이미지첨부 조회
	 * @param map
	 * @return
	 */
	public List<Map<String, Object>> selectImgGrpList(HashMap<String,Object> map) {
		String taskSe = (String)map.get("taskSe");
		String mapperId = NAMESPACE+"selectImgGrpListForCatlg";
		
		if("NOTC_HELP".contains(taskSe)) {
			mapperId = NAMESPACE+"selectImgGrpListForCommBoard";
		}
		
		return sqlSession.selectList(mapperId, map);
	}
	/**
	 * 카달로그 첨부 조회
	 * @param map
	 * @return
	 */
	public List<Map<String, Object>> selectCatalogGrpList(HashMap<String,Object> map) {
		String taskSe = (String)map.get("taskSe");
		String mapperId = NAMESPACE+"selectCatalogGrpList";
		return sqlSession.selectList(mapperId, map);
	}
	    
	public String insertBoardCommon(HashMap<String,Object> map) {
		String taskSe = (String)map.get("taskSe");
		
		map.put("boardDtlTableNm", "TB_CAB002D");
		Map newPostIdMap = sqlSession.selectOne(NAMESPACE+"selectNewPostId", map);
		String newPostId = (String)newPostIdMap.get("newId");
		map.put("postId",newPostId);
	
		sqlSession.insert(TB_CAB002D_NAMESPACE+"insert", SoftLabHumUtils.convertMapToVo(map,TbCab002d.class));
		
		callAfterBoardUpdate(map, taskSe,"insert");
		 
		return newPostId;
	}
	
	public int updateBoardCommon(HashMap<String,Object> map) {
		
		String taskSe = (String)map.get("taskSe");
		map.put("boardDtlTableNm", "TB_CAB002D");
		int rsCnt = sqlSession.update(TB_CAB002D_NAMESPACE+"updateByPrimaryKey", map);

		callAfterBoardUpdate(map, taskSe,"updateByPrimaryKey");
		
		return rsCnt;
		
	}
	public int updateForImgGrp(HashMap<String,Object> map) {
		
		String taskSe = (String)map.get("taskSe");
		map.put("boardDtlTableNm", "TB_CAB002D");
		int rsCnt = sqlSession.update(TB_CAB002D_NAMESPACE+"updateForImgGrp", map);
		return rsCnt;
		
	}
	
	public int deleteBoardCommon(HashMap<String,Object> map) {
		
		String taskSe = (String)map.get("taskSe");
		map.put("boardDtlTableNm", "TB_CAB002D");
		int rsCnt = sqlSession.delete(TB_CAB002D_NAMESPACE+"deleteByPrimaryKey", map);
		
		callAfterBoardUpdate(map, taskSe,"deleteByPrimaryKey");
		
		return rsCnt;
	}

	
	
    
	public String insertAttchFile(HashMap<String,Object> map) {
		String taskSe = (String)map.get("taskSe");
		String attchType = (String)map.get("attchType");
		
		String fileGrpId = "";
		String fileGrpIdQueryId = "";
		String fileIdQueryId = "";
		String boardCRUDQueryId = "";
		
		Class<T> clazz = null;
		
		if(attchType.equals("IMG")) {
			fileGrpId = SoftLabHumUtils.nvl((String)map.get("fileGrpId"));
			fileGrpIdQueryId = NAMESPACE+"selectNewImgFileGrpId";
			fileIdQueryId = NAMESPACE+"selectNewImgFileId";
			clazz = (Class<T>) TbSaf002d.class;
			boardCRUDQueryId =  TB_SAF002D_NAMESPACE+"insert";
			map.put("AttchFileTableNm",  "TB_SAF002D");
		}
		else if(attchType.equals("PDF")) {
			fileGrpId = SoftLabHumUtils.nvl((String)map.get("fileGrpId"));
			fileGrpIdQueryId = NAMESPACE+"selectNewCatlgFileGrpId";
			fileIdQueryId = NAMESPACE+"selectNewCatlgFileId";
			clazz = (Class<T>) TbSaf003d.class;
			boardCRUDQueryId =  TB_SAF003D_NAMESPACE+"insert";	
			map.put("AttchFileTableNm",  "TB_SAF003D");
		}
		
		if("".equals(fileGrpId)) {
			Map newFileGrpIdMap = sqlSession.selectOne(fileGrpIdQueryId, map);
			fileGrpId = (String)newFileGrpIdMap.get("newId");
			map.put("fileGrpId",fileGrpId);
			if(attchType.equals("IMG")) map.put("imgFileGrpId",fileGrpId);
			if(attchType.equals("PDF")) map.put("catlgFileGrpId",fileGrpId);
		}
		
		Map newFileIdMap = sqlSession.selectOne(fileIdQueryId, map);
		String newFileId = (String)newFileIdMap.get("newId");
		map.put("fileId",newFileId);
		if(attchType.equals("IMG")) map.put("imgFileId",newFileId);
		if(attchType.equals("PDF")) map.put("catlgFileId",newFileId);
				
		
		System.out.println("----------------------------------------------------------------------------");
		System.out.println("----------------------------------------------------------------------------");
		
		System.out.println("-- boardCRUDQueryId => "+ boardCRUDQueryId);
		System.out.println("-- clazz => "+ clazz.getName());
		System.out.println("-- map => "+ map);
		
		System.out.println("----------------------------------------------------------------------------");
		System.out.println("----------------------------------------------------------------------------");
		
		
		sqlSession.insert(boardCRUDQueryId, SoftLabHumUtils.convertMapToVo(map,clazz));
		
		return newFileId;
	}
	
	public Map<String, Object> selectAttchFile(HashMap<String,Object> map) {
		String attchType = (String)map.get("attchType");
		String boardCRUDQueryId = "";
		
		if(attchType.equals("IMG")) {
			map.put("imgFileGrpId", SoftLabHumUtils.nvl(map.get("fileGrpId")));
			map.put("imgFileId", SoftLabHumUtils.nvl(map.get("fileId")) );
			boardCRUDQueryId =  TB_SAF002D_NAMESPACE+"selectByPrimaryKey";
			map.put("AttchFileTableNm",  "TB_SAF002D");
		}
		else if(attchType.equals("PDF")) {
			map.put("catlgFileGrpId", SoftLabHumUtils.nvl(map.get("fileGrpId")));
			map.put("catlgFileId", SoftLabHumUtils.nvl(map.get("fileId")) );
			boardCRUDQueryId =  TB_SAF003D_NAMESPACE+"selectByPrimaryKey";	
			map.put("AttchFileTableNm",  "TB_SAF003D");
		}
		   
		return  SoftLabHumUtils.converVoToMap( sqlSession.selectOne(boardCRUDQueryId, map) );
	}
	
	public int deleteAttchFile(HashMap<String,Object> map) {
		String attchType = (String)map.get("attchType");
		
		String boardCRUDQueryId = "";
		Class<T> clazz = null;
		
		if(attchType.equals("IMG")) {
			map.put("imgFileGrpId", SoftLabHumUtils.nvl(map.get("fileGrpId")));
			map.put("imgFileId", SoftLabHumUtils.nvl(map.get("fileId")) );
			clazz = (Class<T>) TbSaf002d.class;
			boardCRUDQueryId =  TB_SAF002D_NAMESPACE+"deleteByPrimaryKey";
			map.put("AttchFileTableNm",  "TB_SAF002D");
		}
		else if(attchType.equals("PDF")) {
			map.put("catlgFileGrpId", SoftLabHumUtils.nvl(map.get("fileGrpId")));
			map.put("catlgFileId", SoftLabHumUtils.nvl(map.get("fileId")) );
			clazz = (Class<T>) TbSaf003d.class;
			boardCRUDQueryId =  TB_SAF003D_NAMESPACE+"deleteByPrimaryKey";	
			map.put("AttchFileTableNm",  "TB_SAF003D");
		}
		
		int rsCnt = sqlSession.delete(boardCRUDQueryId, SoftLabHumUtils.convertMapToVo(map,clazz));
		
		return rsCnt;
	}
	
	
	
	/**
	 * 게시판 저장 후 연계 테이블 처리
	 * @param map
	 * @param taskSe
	 * @param mapperId
	 */
	private void callAfterBoardUpdate(HashMap<String, Object> map, String taskSe,String mapperId) {
		
		if("NOTC_PUSH_POPP".contains(taskSe)) { 
			
			if("insert".equals(mapperId)) {
				Map newPushIdMap = sqlSession.selectOne(NAMESPACE+"selectNewPushRegNo", map);
				String newPushId = (String)newPushIdMap.get("newId");
				map.put("pushRegNo",newPushId);
			}
			TbCac001d tbCac001dVo = SoftLabHumUtils.convertMapToVo(map, TbCac001d.class);
		  	sqlSession.update(TB_CAC001D_NAMESPACE+mapperId, tbCac001dVo); // 공지푸시 등록
		 
		}else if("QNAM".contains(taskSe)) { 
			
			if("insert".equals(mapperId)) {
				Map newQnamIdMap = sqlSession.selectOne(NAMESPACE+"selectNewMangRegNo", map);
				String newMangRegNo = (String)newQnamIdMap.get("newId");
				map.put("mangRegNo",newMangRegNo);
			}
			TbCab004d tbCab004dVo = SoftLabHumUtils.convertMapToVo(map, TbCab004d.class);
		  	sqlSession.update(TB_CAB004D_NAMESPACE+mapperId, tbCab004dVo); // 문의담당자 상세
		
		}
	}
		
}
