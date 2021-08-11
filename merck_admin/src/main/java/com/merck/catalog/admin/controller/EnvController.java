package com.merck.catalog.admin.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.merck.catalog.admin.service.BoardCommonService;

@Controller
@RequestMapping("/admin/env/*")
public class EnvController {

	private static final Logger logger = LoggerFactory.getLogger(EnvController.class);
	
	@Autowired
    private BoardCommonService service;
	
	@RequestMapping(value = "cate_regist", method = {RequestMethod.GET, RequestMethod.POST})
	public String cate_regist() {
	    logger.info("cate_regist page");
		return "/admin/env/cate_regist";
	}
	
	@RequestMapping(value = "qnam_regist", method = {RequestMethod.GET, RequestMethod.POST})
	public String qnam_regist() {
		logger.info("qnam_regist page");
		return "/admin/env/qnam_regist";
	}
	
	@RequestMapping(value = "help_regist", method = {RequestMethod.GET, RequestMethod.POST})
	public String help_regist() {
		logger.info("help_regist page");
		
		HashMap paramMap = new HashMap();
		paramMap.put("boardId", "HELP00000001");
	    paramMap.put("postId", "0000000001");
	    paramMap.put("taskSe", "HELP");
	    paramMap.put("taskSeCd", "HLP");
	    List<Map<String, Object>> list = service.selectBoardCommonList(paramMap);
	    
	    if( list.size() == 0 ) {
	    	paramMap.put("registUsrId", "SOFTLAB");
		    paramMap.put("updtUsrId", "SOFTLAB");
		    paramMap.put("title", "도움말 등록_0000000001");
	    	service.insertBoardCommon(paramMap);
	    }
		
		return "redirect:/admin/board/viewBoardCommon/HELP00000001/0000000001";
	}
	
}
