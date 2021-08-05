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

import com.merck.catalog.admin.service.CmmnCdService;
import com.merck.catalog.common.SoftLabHumUtils;

@Controller
@RequestMapping("/admin/cmmnCd/*")
public class CmmnCdController {

	private static final Logger logger = LoggerFactory.getLogger(CmmnCdController.class);
	
	@Autowired
    private CmmnCdService service;
	
	@RequestMapping(value = "selectCmmnCdListRest", method = {RequestMethod.GET, RequestMethod.POST})
	public @ResponseBody List<Map<String, Object>> listRest(@RequestBody HashMap<String, Object> paramMap) {
	    logger.info("selectCmmnCdList =>>"+paramMap);
	    
	    List<Map<String, Object>> list = service.selectCmmnCdList(paramMap);
		return list;
	}
	
	@RequestMapping (value = "selectCmmnCdList/{taskSe}/{cmmnCdId}/{useYn}", method = {RequestMethod.GET})
	public ModelAndView list(@PathVariable String taskSe,@PathVariable String cmmnCdId,@PathVariable String useYn) {
		logger.info("selectCmmnCdList taskSe=>"+taskSe+" , cmmnCdId=>{} , useYn=>{}",cmmnCdId,useYn);
	    
		HashMap<String,Object> paramMap = new HashMap();
		paramMap.put("cmmnCdId", cmmnCdId);
	    paramMap.put("taskSe", taskSe);
	    paramMap.put("useYn", useYn);
	    List<Map<String, Object>> list = service.selectCmmnCdList(paramMap);
	    
	    String viewName = "/admin/cmmnCd/cmmncd_list";
	    if( "CATE".equals((String)paramMap.get("taskSe"))) {
	    	viewName = "/admin/env/cate_regist";
	    }
	    
	    ModelAndView mav = new ModelAndView();
	    mav.setViewName(viewName);
		mav.addObject("cmmnCdList", list);
		return mav;
	}
	
	@RequestMapping (value = "viewCmmnCd/{cmmnCdId}/{cmmnCd}", method = {RequestMethod.GET})
	public ModelAndView viewCmmnCd(@PathVariable String cmmnCdId,@PathVariable String cmmnCd) {
	    logger.info("viewCmmnCd cmmnCdId=>{}, cmmnCd=>{}",cmmnCdId,cmmnCd);
	    
	    HashMap paramMap = new HashMap();
	    paramMap.put("cmmnCdId", cmmnCdId);
	    paramMap.put("cmmnCd", cmmnCd);
	    
	    List<Map<String, Object>> list = service.selectCmmnCdList(paramMap);
	    
	    ModelAndView mav = new ModelAndView();
	    mav.setViewName("/admin/cmmnCd/cmmncd_write");
		mav.addObject("cmmnCdList", list);
		return mav;
	}
	
	@RequestMapping(value = "viewCmmnCdRest/{cmmnCdId}/{cmmnCd}", method = {RequestMethod.GET, RequestMethod.POST})
	public @ResponseBody Map<String,Object> viewQnaMangRegNo(@PathVariable String cmmnCdId,@PathVariable String cmmnCd,@RequestBody HashMap<String, Object> paramMap) {
	    logger.info("deleteCmmnCd cmmnCdId{}, cmmnCd{}",cmmnCdId,cmmnCd);
	    
	    paramMap.put("cmmnCdId", cmmnCdId);
	    paramMap.put("cmmnCd", cmmnCd);
	    List<Map<String, Object>> list = service.selectCmmnCdList(paramMap);
	    
	    if( list.isEmpty() ) {
	    	return paramMap;
	    }else {
	    	return list.get(0);
	    }
	}
	
	@RequestMapping(value = "chkForUpdate/{cmmnCdId}/{cmmnCd}", method = {RequestMethod.GET, RequestMethod.POST})
	public @ResponseBody Map<String,Object> selectCmmnCdChkForUpdate(@PathVariable String cmmnCdId,@PathVariable String cmmnCd,@RequestBody HashMap<String, Object> paramMap) {
		logger.info("selectCmmnCdChkForUpdate cmmnCdId{}, cmmnCd{}",cmmnCdId,cmmnCd);
		logger.info("selectCmmnCdChkForUpdate map=>>{}",paramMap);
		
		paramMap.put("cmmnCdId", cmmnCdId);
		paramMap.put("cmmnCd", cmmnCd);
		paramMap.put("isUpdate", "N");
		Map<String, Object> chhMap = service.selectCmmnCdChkForUpdate(paramMap);
		
		if( chhMap.isEmpty() ) {
			return paramMap;
		}else {
			return chhMap;
		}
	}
	
	@RequestMapping(value = "chkForUsing/{cmmnCdId}/{cmmnCd}", method = {RequestMethod.GET, RequestMethod.POST})
	public @ResponseBody Map<String,Object> selectCmmnCdChkForUsing(@PathVariable String cmmnCdId,@PathVariable String cmmnCd,@RequestBody HashMap<String, Object> paramMap) {
		logger.info("selectCmmnCdChkForUpdate cmmnCdId=>{}, cmmnCd=>{}",cmmnCdId,cmmnCd);
		logger.info("selectCmmnCdChkForUpdate map=>>{}",paramMap);
		
		paramMap.put("cmmnCdId", cmmnCdId);
		paramMap.put("cmmnCd", cmmnCd);
		paramMap.put("isUsing", "N");
		Map<String, Object> chhMap = service.selectCmmnCdChkForUsing(paramMap);
		
		if( chhMap.isEmpty() ) {
			return paramMap;
		}else {
			return chhMap;
		}
	}
	
	@RequestMapping(value = "saveCmmnCd", method = {RequestMethod.GET, RequestMethod.POST})
	public @ResponseBody int saveCmmnCd(@RequestBody List<HashMap<String, Object>> paramList) throws Exception {
	    logger.info("saveCmmnCd =>>"+paramList);
	    
	    int idx = 1;
	    int delIdx = 0;
	    int updateCnt = 0;
	    int delCnt = 0;
	    int insertCnt = 0;
	    
	    HashMap<String,Object> deleteMap = new HashMap();
	    String notInCmmnCd = "";
	    
	    for (HashMap<String, Object> paramMap : paramList) {
	    	
	    	String cmmnCd = (String)paramMap.get("cmmnCd");
	    	
	    	int saveCnt = 0;
	    	String newPostId = "";
	    	
	    	paramMap.put("registUsrId", "SOFTLAB");
	    	paramMap.put("updtUsrId", "SOFTLAB");
	    	
	    	
	    	// 昏力扒 贸府 饶 Merge
	    	if( !"".equals( SoftLabHumUtils.nvl(cmmnCd)) ) {
	    		notInCmmnCd+=(delIdx++>0?",":"")+cmmnCd;
	    		
	    		logger.debug("### notInCmmnCd.... =>>> {}",notInCmmnCd);
	    		
	    		deleteMap.put("cmmnCdId", (String)paramMap.get("cmmnCdId"));
	    	}    	
	    	
	    	// update
	    	
	    	paramMap.put("cmmnCdSn", idx);
	    	paramMap.put("cmmnSortSn",idx);
	    	
	    	if( !"".equals( SoftLabHumUtils.nvl(cmmnCd)) ) {
	    		updateCnt = service.updateCmmnCd(paramMap);
	    	
	    	// insert 
	    	}else {
	    		String newCmmnCd = service.insertCmmnCd(paramMap);
	    		notInCmmnCd+=(delIdx++>0?",":"")+newCmmnCd;
	    		++insertCnt;
	    		logger.debug("## cmmnCd insert - newCmmnCd {}",newCmmnCd);
	    	}
	    	
	    	
	    	idx++;
		}
	    
	    // 昏力 贸府
	    String[] notInCmmnCdArr = notInCmmnCd.split(",");
	    logger.debug("### notInCmmnCdArr => {}",notInCmmnCdArr);
	    deleteMap.put("notInCmmnCdArr", notInCmmnCdArr);
	    delCnt = service.deleteByCategoryList(deleteMap);
	    
		return insertCnt+updateCnt+delCnt;
	}
	
	@RequestMapping(value = "deleteCmmnCd/{cmmnCdId}/{cmmnCd}", method = {RequestMethod.GET, RequestMethod.POST})
	public @ResponseBody int deleteCmmnCd(@PathVariable String cmmnCdId,@PathVariable String cmmnCd,@RequestBody HashMap<String, Object> paramMap)  throws Exception{
	    logger.info("deleteCmmnCd cmmnCdId{}, cmmnCd{}",cmmnCdId,cmmnCd);
	    
	    paramMap.put("cmmnCdId", cmmnCdId);
	    paramMap.put("cmmnCd", cmmnCd);
	    int delCnt = service.deleteCmmnCd((HashMap<String, Object>) paramMap);
		return delCnt;
	}
	
}
