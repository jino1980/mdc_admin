package com.merck.catalog.common;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class SampleInterceptor extends HandlerInterceptorAdapter {
    
    private static final Logger logger = LoggerFactory.getLogger(SampleInterceptor.class);
	
	@Override
	public boolean preHandle(HttpServletRequest request,
	        HttpServletResponse response, Object handler) throws Exception {
	    logger.debug("preHandle executed");
	    return true;
	}

	@Override
	public void postHandle(HttpServletRequest request,
	        HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
	    logger.debug("postHandle executed");
	}

	@Override
	public void afterCompletion(HttpServletRequest request,
	        HttpServletResponse response, Object handler, Exception ex) throws Exception {
	    logger.debug("afterHandle executed"); 
	}	

}
