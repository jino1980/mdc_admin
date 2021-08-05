package com.merck.catalog.admin.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/admin/env/*")
public class EnvController {

	private static final Logger logger = LoggerFactory.getLogger(EnvController.class);
	
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
		return "/admin/env/help_regist";
	}
	
}
