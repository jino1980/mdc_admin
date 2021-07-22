package com.merck.catalog.admin.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/admin/catalog/*")
public class CatalogController {

	private static final Logger logger = LoggerFactory.getLogger(CatalogController.class);
	
	@RequestMapping(value = "catalog_list", method = {RequestMethod.GET, RequestMethod.POST})
	public String list() {
	    logger.info("catalog_list page");
		return "/admin/catalog/catalog_list";
	}
	
	@RequestMapping(value = "catalog_write", method = {RequestMethod.GET, RequestMethod.POST})
	public String write() {
		logger.info("catalog_write page");
		return "/admin/catalog/catalog_write";
	}
	
}
