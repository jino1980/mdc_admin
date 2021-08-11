package com.merck.catalog.admin.controller;

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
@RequestMapping("/admin/catalog/*")
public class CatalogController {

	private static final Logger logger = LoggerFactory.getLogger(CatalogController.class);
	
	
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
	public ModelAndView viewCatalog(@PathVariable String catlgId) {
	    logger.info("viewCatalog catlgId=>>"+catlgId);
	    
	    HashMap paramMap = new HashMap();
	    paramMap.put("catlgId", catlgId);
	    paramMap.put("cmmnCdId", "CATE01");
	    
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
	    
	    ModelAndView mav = new ModelAndView();
	    mav.setViewName("/admin/catalog/catalog_write");
	    //String rtnStr = "";
	    //if(list.size() > 0) rtnStr = SoftLabHumUtils.converMapToJson(list.get(0));
		mav.addObject("catalogList", list);
		mav.addObject("categoryCmmnCdList", categoryCmmnCdList);
		mav.addObject("qnaManagerList", qnaManagerList);
		mav.addObject("imgGrpList", imgGrpList);
		mav.addObject("catalogGrpList", catalogGrpList);
		
		return mav;
		//return new ModelAndView("/admin/catalog/catalog_write", "catalogList", null );
	}
	
	@RequestMapping(value = "saveCatalog", method = {RequestMethod.GET, RequestMethod.POST})
	public @ResponseBody String saveCatalog(@RequestBody HashMap<String, Object> paramMap) {
	    logger.info("saveCatalog =>>"+paramMap);
	    String catlgId = (String)paramMap.get("catlgId");
	    
	    int saveCnt = 0;
	    String newCatalogId = "";
	    
	    paramMap.put("registUsrId", "SOFTLAB");
	    paramMap.put("updtUsrId", "SOFTLAB");
	    
	    if( !"".equals(catlgId)) {
	    	saveCnt = service.updateCatalog(paramMap);
	    	newCatalogId = catlgId;
	    }else {
	    	newCatalogId = service.insertCatalog(paramMap);
	    }
		return newCatalogId;
	}
	
	@RequestMapping(value = "deleteCatalog", method = {RequestMethod.GET, RequestMethod.POST})
	public @ResponseBody int deleteCatalog(@RequestBody HashMap<String, Object> paramMap) {
	    logger.info("deleteCatalog =>>"+paramMap);
	    
	    int delCnt = service.deleteCatalog(paramMap);
		return delCnt;
	}
	
	@RequestMapping(value = "catalog_list", method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView listPage() {
		logger.info("catalog_list page");
		
		HashMap paramMap = new HashMap();
	    paramMap.put("cmmnCdId", "CATE01");
	    
		// 카테고리 목록
	    List<Map<String, Object>> categoryCmmnCdList = cmmnCdSerivce.selectCmmnCdList(paramMap);
	    
	    ModelAndView mav = new ModelAndView();
	    mav.setViewName("/admin/catalog/catalog_list");
	    //String rtnStr = "";
	    //if(list.size() > 0) rtnStr = SoftLabHumUtils.converMapToJson(list.get(0));
		mav.addObject("categoryCmmnCdList", categoryCmmnCdList);
		
		return mav;
	}
	
	@RequestMapping(value = "catalog_write", method = {RequestMethod.GET, RequestMethod.POST})
	public String writePage() {
		logger.info("catalog_write page");
		return "/admin/catalog/catalog_write";
	}
	
}
