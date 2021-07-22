package com.merck.catalog.common;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class CrossScriptingFilter implements Filter {
    
    
    private static final Logger logger = LoggerFactory.getLogger(CrossScriptingFilter.class);

	@Override
	public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain) throws IOException, ServletException {
	    chain.doFilter(new XSSRequestWrapper((HttpServletRequest) req), res);
	}

	@Override
	public void init(FilterConfig config) throws ServletException {
	    logger.warn("XSS Filtering init");
	}


	@Override
	public void destroy() {
	    
	}

}
