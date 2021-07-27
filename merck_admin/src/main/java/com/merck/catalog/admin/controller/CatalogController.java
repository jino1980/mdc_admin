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

import com.merck.catalog.admin.service.CatalogService;
import com.merck.catalog.common.SoftLabHumUtils;

@Controller
@RequestMapping("/admin/catalog/*")
public class CatalogController {

	private static final Logger logger = LoggerFactory.getLogger(CatalogController.class);
	
	
	@Autowired
    private CatalogService service;
	
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
	public String viewCatalog(@PathVariable String catlgId) {
	    logger.info("viewCatalog catlgId=>>"+catlgId);
	    
	    HashMap paramMap = new HashMap();
	    paramMap.put("catlgId", catlgId);
	    
	    List<Map<String, Object>> list = service.selectCatalogList(paramMap);
	    
	    ModelAndView mav = new ModelAndView();
	    //mav.setViewName("/admin/catalog/catalog_write");
	    String rtnStr = "";
	    if(list.size() > 0) rtnStr = SoftLabHumUtils.converMapToJson(list.get(0));
		mav.addObject("calalogMap", rtnStr);
		
		return "/admin/catalog/catalog_write";
	}
	
	@RequestMapping(value = "deleteCatalog", method = {RequestMethod.GET, RequestMethod.POST})
	public @ResponseBody int deleteOne(@RequestBody HashMap<String, Object> paramMap) {
	    logger.info("deleteCatalog =>>"+paramMap);
	    
	    int delCnt = service.deleteCatalog(paramMap);
		return delCnt;
	}
	
	@RequestMapping(value = "catalog_list", method = {RequestMethod.GET, RequestMethod.POST})
	public String listPage() {
		logger.info("catalog_list page");
		return "/admin/catalog/catalog_list";
	}
	
	@RequestMapping(value = "catalog_write", method = {RequestMethod.GET, RequestMethod.POST})
	public String writePage() {
		logger.info("catalog_write page");
		return "/admin/catalog/catalog_write";
	}
	
}
