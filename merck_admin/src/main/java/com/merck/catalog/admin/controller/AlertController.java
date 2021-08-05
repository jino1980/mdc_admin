package com.merck.catalog.admin.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/admin/alert/*")
public class AlertController {

	private static final Logger logger = LoggerFactory.getLogger(AlertController.class);
	
	@RequestMapping(value = "notc_list", method = {RequestMethod.GET, RequestMethod.POST})
	public String notcList() {
	    logger.info("notc_list page");
		return "/admin/alert/notc_list";
	}
	@RequestMapping(value = "notc_write", method = {RequestMethod.GET, RequestMethod.POST})
	public String notcWrite() {
		logger.info("notc_write page");
		return "/admin/alert/notc_write";
	}
	
	@RequestMapping(value = "push_list", method = {RequestMethod.GET, RequestMethod.POST})
	public String pushList() {
		logger.info("push_list page");
		return "/admin/alert/push_list";
	}
	@RequestMapping(value = "push_write", method = {RequestMethod.GET, RequestMethod.POST})
	public String pushWrite() {
		logger.info("push_write page");
		return "/admin/alert/push_write";
	}
	
	@RequestMapping(value = "popp_list", method = {RequestMethod.GET, RequestMethod.POST})
	public String popUpList() {
		logger.info("popp_list page");
		return "/admin/alert/popp_list";
	}
	
	@RequestMapping(value = "popp_write", method = {RequestMethod.GET, RequestMethod.POST})
	public String poppWrite() {
		logger.info("popp_write page");
		return "/admin/alert/popp_write";
	}
	
}
