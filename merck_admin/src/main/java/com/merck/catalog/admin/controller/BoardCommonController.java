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
import com.merck.catalog.admin.service.CmmnCdService;

@Controller
@RequestMapping("/admin/board/*")
public class BoardCommonController {

	private static final Logger logger = LoggerFactory.getLogger(BoardCommonController.class);
	
	
	@Autowired
    private BoardCommonService service;
	
	@Autowired
	private CmmnCdService cmmnCdSerivce;
	
	@RequestMapping(value = "selectBoardCommonList", method = {RequestMethod.GET, RequestMethod.POST})
	public @ResponseBody List<Map<String, Object>> list(@RequestBody HashMap<String, Object> paramMap) {
	    logger.info("selectBoardCommonList =>>"+paramMap);
	    
	    List<Map<String, Object>> list = service.selectBoardCommonList(paramMap);
		return list;
	}
	
	@RequestMapping (value = "viewBoardCommon/{boardId}/{postId}", method = {RequestMethod.GET})
	public ModelAndView viewBoardCommon(@PathVariable String boardId,@PathVariable String postId) {
	    logger.info("viewBoardCommon boardId{}, postId{}",boardId,postId);
	    String taskSe = boardId.substring(0,4).toLowerCase();
	    
	    HashMap paramMap = new HashMap();
	    paramMap.put("boardId", boardId);
	    paramMap.put("postId", postId);
	    paramMap.put("taskSe", boardId.substring(0,4));
	    
	    List<Map<String, Object>> list = service.selectBoardCommonList(paramMap);
	    
	    paramMap.put("cmmnCdId","CATE01");
	    List<Map<String, Object>> categoryCmmnCdList = cmmnCdSerivce.selectCmmnCdList(paramMap);
	    
	    // 이미지 목록
	    List<Map<String, Object>> imgGrpList = service.selectImgGrpList(paramMap);
	    
	    ModelAndView mav = new ModelAndView();
	    mav.setViewName("/admin/alert/"+taskSe+"_write");
	    //String rtnStr = "";
	    //if(list.size() > 0) rtnStr = SoftLabHumUtils.converMapToJson(list.get(0));
		mav.addObject("boardPostList", list);
		mav.addObject("categoryCmmnCdList", categoryCmmnCdList);
		mav.addObject("imgGrpList", imgGrpList);
		return mav;
		//return new ModelAndView("/admin/notc/notc_write", "notcList", null );
	}
	
	@RequestMapping(value = "viewQnaMangRegNo/{boardId}/{postId}", method = {RequestMethod.GET, RequestMethod.POST})
	public @ResponseBody Map<String,Object> viewQnaMangRegNo(@PathVariable String boardId,@PathVariable String postId,@RequestBody HashMap<String, Object> paramMap) {
	    logger.info("deleteBoardCommon boardId{}, postId{}",boardId,postId);
	    
	    paramMap.put("boardId", boardId);
	    paramMap.put("postId", postId);
	    List<Map<String, Object>> list = service.selectBoardCommonList(paramMap);
	    
	    if( list.isEmpty() ) {
	    	return paramMap;
	    }else {
	    	return list.get(0);
	    }
	}
	
	@RequestMapping(value = "saveBoardCommon", method = {RequestMethod.GET, RequestMethod.POST})
	public @ResponseBody String saveBoardCommon(@RequestBody HashMap<String, Object> paramMap) {
	    logger.info("saveBoardCommon =>>"+paramMap);
	    String postId = (String)paramMap.get("postId");
	    
	    int saveCnt = 0;
	    String newPostId = postId;
	    
	    paramMap.put("registUsrId", "SOFTLAB");
	    paramMap.put("updtUsrId", "SOFTLAB");
	    
	    if( !"".equals(postId)) {
	    	saveCnt = service.updateBoardCommon(paramMap);
	    }else {
	    	newPostId = service.insertBoardCommon(paramMap);
	    }
		return newPostId;
	}
	
	@RequestMapping(value = "deleteBoardCommon/{boardId}/{postId}", method = {RequestMethod.GET, RequestMethod.POST})
	public @ResponseBody int deleteBoardCommon(@PathVariable String boardId,@PathVariable String postId,@RequestBody HashMap<String, Object> paramMap) {
	    logger.info("deleteBoardCommon boardId{}, postId{}",boardId,postId);
	    
	    paramMap.put("boardId", boardId);
	    paramMap.put("postId", postId);
	    int delCnt = service.deleteBoardCommon((HashMap<String, Object>) paramMap);
		return delCnt;
	}
	
}
