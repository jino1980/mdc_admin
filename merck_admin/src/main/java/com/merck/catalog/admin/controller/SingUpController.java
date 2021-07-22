package com.merck.catalog.admin.controller;

import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.merck.catalog.admin.dao.HomeDao;
import com.merck.catalog.admin.vo.UserVO;
import com.merck.catalog.common.Authority;
import com.merck.catalog.common.Message;

@Controller
public class SingUpController {

	private static final Logger logger = LoggerFactory.getLogger(SingUpController.class);

	@Autowired
	HomeDao homeDao;
	
	@RequestMapping(value = "/signUp", method = RequestMethod.GET)
	public String signForm(Locale locale, Model model) {
		logger.info("Thanks! Join us. {}", locale);
		return "/home/signUp";
	}
	
	@RequestMapping(value = "/signUpInsert", method = RequestMethod.POST)
	public String insert(UserVO vo, RedirectAttributes redirectAttr) {
		logger.info("Go insert! {}", vo.getName());
		
		if(checkUser(vo.getName())) {
			vo.setAuthority(Authority.ROLE_USER);
			homeDao.insertUser(vo);
			homeDao.insertAuthority(vo);
			return "redirect:/login";
		} else {
			redirectAttr.addFlashAttribute("msg", Message.DUPICATE_USER);
			return "redirect:/home/signUp";
		}
	}
	
	public boolean checkUser(String username) {
		if (homeDao.getUserCountByName(username) > 0) {
			return false;
		} else {
			return true;
		}
	}
	
}
