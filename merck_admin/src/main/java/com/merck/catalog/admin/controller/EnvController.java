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
	
	@RequestMapping(value = "catalog_list", method = {RequestMethod.GET, RequestMethod.POST})
	public String list() {
	    logger.info("category_admin page");
		return "/admin/env/category_admin";
	}
	
	@RequestMapping(value = "manager_admin", method = {RequestMethod.GET, RequestMethod.POST})
	public String write() {
		logger.info("manager_admin page");
		return "/admin/env/manager_admin";
	}
	
}
