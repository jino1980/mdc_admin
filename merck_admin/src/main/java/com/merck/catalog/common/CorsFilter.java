package com.merck.catalog.common;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class CorsFilter implements Filter {
    
    private static final Logger logger = LoggerFactory.getLogger(CorsFilter.class);
    
	@Override
	public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain) throws IOException, ServletException {
	    HttpServletResponse response = (HttpServletResponse) res;
        response.setHeader("X-Frame-Options", "ALLOW-FROM http://localhost:8080");
	    chain.doFilter(req, res);
	}

	@Override
	public void init(FilterConfig config) throws ServletException {
	    String testParam = config.getInitParameter("testParam");
	    logger.debug("testParam : {} ", testParam);
	}

	@Override
	public void destroy() {
	}

}
