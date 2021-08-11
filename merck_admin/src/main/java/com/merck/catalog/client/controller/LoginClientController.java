package com.merck.catalog.client.controller;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.util.UrlPathHelper;

import com.merck.catalog.common.Message;

@Controller
public class LoginClientController {

	private static final Logger logger = LoggerFactory.getLogger(LoginClientController.class);

	
	/*
     * security-context.xml
     */
    @RequestMapping(value = "/login", method = { RequestMethod.GET, RequestMethod.POST })
    public ModelAndView login(@RequestParam(value = "error", required = false) String error
            , @RequestParam(value = "logout", required = false) String logout, ModelAndView model) {
        logger.info("Welcome login.");

        if (error != null) {
            model.addObject("error", Message.WRONG_PASSWORD);
        }

        if (logout != null) {
            model.addObject("msg", Message.LOGOUT_SUCCESS);
        }

        model.setViewName("login");
        return model;
    }

    /*
     * security-context.xml
     * default-target-url="/loginSuccess"
     */
    @RequestMapping(value = "/loginSuccess", method = RequestMethod.GET)
    public String home() {
        logger.info("loginSuccess.");
        return "/home/home";
    }
	
	/* 
	 * kakao login
	 */
	@RequestMapping(value = "/client/oauth/kakao",  method = {RequestMethod.GET, RequestMethod.POST})
	public String kakaoLogin() {
	    logger.info("kakaoLogin page");
		return "/client/oauth/kakao_login";
	}
	
	/* 
	 * kakao login callback
	 */
	@RequestMapping(value = "/client/oauth/login_kakao_cabllBack",  method = {RequestMethod.GET, RequestMethod.POST})
	public String kakaoLoginCallBack( HttpServletRequest request, HttpServletResponse response, HttpSession session, Model model) throws Exception {

		logger.info("### login_kakao_cabllBack");
		
		return "/client/oauth/login_kakao_cabllBack";

		/*UrlPathHelper urlPathHelper = new UrlPathHelper(); 
		String originalURL = urlPathHelper.getOriginatingRequestUri(request); 
		Map<String, String[]> paramMap = request.getParameterMap(); 
		Iterator keyData = paramMap.keySet().iterator(); 
		Map dto = new HashMap(); 
		while (keyData.hasNext()) { 
			String key = ((String) keyData.next()); 
			String[] value = paramMap.get(key); 
			dto.put(key, value[0].toString()); 
		} 
		
		String url = "https://kauth.kakao.com/oauth/token"; 
		RestTemplate restTemplate = new RestTemplate(); 
		HttpHeaders headers = new HttpHeaders(); 
		headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED); 
		
		LinkedMultiValueMap<String, String> map = new LinkedMultiValueMap<String, String>(); 
		map.add("client_id", "8a44e8df3a34d6ee211fe858d9e2ed72"); 
		String redirect_url = "http://127.0.0.1:8080/client/oauth/login_kakao_cabllBack"; 
		map.add("redirect_uri", redirect_url); 
		map.add("grant_type", "authorization_code"); 
		map.add("code", (String) dto.get("code")); 
		
		HttpEntity<LinkedMultiValueMap<String, String>> request2 = new HttpEntity<LinkedMultiValueMap<String, String>>( map, headers); 
		Map response2 = restTemplate.postForObject(url, request2, HashMap.class); 
		
		map.clear(); 
		model.addAttribute("access_token", response2.get("access_token")); 
		
		return "/client/oauth/login_kakao_cabllBack";
		*/
	}

}
