package com.merck.catalog.client.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.merck.catalog.admin.service.BoardCommonService;
import com.merck.catalog.admin.service.CatalogService;
import com.merck.catalog.admin.service.CmmnCdService;

@Controller
@RequestMapping("/client/catalog/*")
public class CatalogClientController {

	private static final Logger logger = LoggerFactory.getLogger(CatalogClientController.class);
	
	
	@Autowired
    private CatalogService service;
	
	@Autowired
	private CmmnCdService cmmnCdSerivce;
	@Autowired
	private BoardCommonService boardCommService;
	
	@RequestMapping(value = "selectCatalogList", method = {RequestMethod.GET, RequestMethod.POST})
	public @ResponseBody List<Map<String, Object>> list(@RequestBody HashMap<String, Object> paramMap) {
	    logger.info("selectCatalogList =>>"+paramMap);
	    
	    String catgrIdGrp = (String)paramMap.get("catgrIdGrp");
	    if(!"".contentEquals(catgrIdGrp)) {
	    	catgrIdGrp = catgrIdGrp.substring(1);
	    	String[] catgrIdGrpArr = catgrIdGrp.split(",");	    	
	    	paramMap.put("catgrIdGrpArr", catgrIdGrpArr);
	    }   
	    
	    List<Map<String, Object>> list = service.selectCatalogList(paramMap);
		return list;
	}
	
	@RequestMapping (value = "viewCatalog/{catlgId}", method = {RequestMethod.GET})
	public @ResponseBody Map<String, Object>  viewCatalog(@PathVariable String catlgId) {
	    logger.info("client viewCatalog catlgId=>>"+catlgId);
	    
	    HashMap paramMap = new HashMap();
	    paramMap.put("catlgId", catlgId);
	    paramMap.put("cmmnCdId", "CATE01");
	    
	    // 카달로그 내용
	    List<Map<String, Object>> list = service.selectCatalogList(paramMap);
	    
	    // 카테고리 목록
	    List<Map<String, Object>> categoryCmmnCdList = cmmnCdSerivce.selectCmmnCdList(paramMap);
	    // 이미지 목록
	    paramMap.put("taskSe","CATA");
	    List<Map<String, Object>> imgGrpList = boardCommService.selectImgGrpList(paramMap);
	    // 카달로그 목록
	    List<Map<String, Object>> catalogGrpList = boardCommService.selectCatalogGrpList(paramMap);
	    // 문의담당자 목록
	    List<Map<String, Object>> qnaManagerList = boardCommService.selectQnamList(paramMap);
	    
	    paramMap.put("catalogData", list);
	    paramMap.put("categoryData", qnaManagerList);
	    paramMap.put("imgFilesData", imgGrpList);
	    paramMap.put("pdfFilesData", catalogGrpList);
	    
		return paramMap;
	}
	
	
}
