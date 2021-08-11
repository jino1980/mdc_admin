package com.merck.catalog.admin.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/")
public class RootController {

	private static final Logger logger = LoggerFactory.getLogger(RootController.class);
	
	@RequestMapping(method = {RequestMethod.GET, RequestMethod.POST})
	public String home() {
	    logger.info("Start root.");
		return "/rootpage";
	}
}
