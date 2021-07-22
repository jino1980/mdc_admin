package com.merck.catalog.admin.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.merck.catalog.common.Message;

@Controller
public class LoginController {

    private static final Logger logger = LoggerFactory.getLogger(LoginController.class);

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

}
