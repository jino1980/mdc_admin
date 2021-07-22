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
	
	@RequestMapping(value = "notice_list", method = {RequestMethod.GET, RequestMethod.POST})
	public String noticeList() {
	    logger.info("notice_list page");
		return "/admin/alert/notice_list";
	}
	@RequestMapping(value = "notice_write", method = {RequestMethod.GET, RequestMethod.POST})
	public String noticeWrite() {
		logger.info("notice_write page");
		return "/admin/alert/notice_write";
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
	
	@RequestMapping(value = "popup_list", method = {RequestMethod.GET, RequestMethod.POST})
	public String popUpList() {
		logger.info("popup_list page");
		return "/admin/alert/popup_list";
	}
	
	@RequestMapping(value = "popup_write", method = {RequestMethod.GET, RequestMethod.POST})
	public String popupWrite() {
		logger.info("popup_write page");
		return "/admin/alert/popup_write";
	}
	
}
