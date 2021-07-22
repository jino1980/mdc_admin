package com.merck.catalog.admin.controller;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.merck.catalog.admin.service.BoardService;
import com.merck.catalog.admin.service.PageServiceImpl;
import com.merck.catalog.admin.vo.BoardVO;
import com.merck.catalog.admin.vo.PageVO;
import com.merck.catalog.common.Message;

@Controller
@RequestMapping("/home/*")
public class BoardController {
    
    private static final Logger logger = LoggerFactory.getLogger(BoardController.class);
    
    @Autowired
    private BoardService service;
    
    @Autowired
    private PageServiceImpl page_service;
    
    @RequestMapping(value="insBoard", method=RequestMethod.POST)
    public String insBoard(BoardVO vo) {
        service.insert(vo);
        return "redirect:/home/board";
    }
    @RequestMapping(value="uptBoard", method=RequestMethod.POST)
    public String uptBoard(BoardVO vo, HttpServletRequest request) {
        logger.info("uptBoard : {}", vo.toString());
        if (service.checkPassword(vo) == 1) {
            service.update(vo);
            return "redirect:/home/board";
        } else {
            request.setAttribute("BoardVO", service.findOneById(vo.getId()));
            request.setAttribute("msg", Message.WRONG_PASSWORD);
            return "/home/boardContent";
        }
    }
    
    @RequestMapping(value="delBoard", method=RequestMethod.POST)
    public String delBoard(BoardVO vo, HttpServletRequest request) {
        if (service.checkPassword(vo) == 1) {
            service.delete(vo.getId());
            return "redirect:/home/board";
        } else {
            request.setAttribute("BoardVO", service.findOneById(vo.getId()));
            request.setAttribute("msg", Message.WRONG_PASSWORD);
            return "/home/boardContent";
        }
    }
    
    @RequestMapping(value="findOneBoard", method=RequestMethod.POST)
    public ModelAndView findOneBoard(@RequestParam("id") int id, ModelAndView mv) {
        mv.addObject("BoardVO", service.findOneById(id));
        mv.setViewName("/home/boardContent");
        return mv;
    }
    
    @RequestMapping(value="board", method={RequestMethod.GET, RequestMethod.POST})
    public ModelAndView findAllBoard(PageVO pageVO, ModelAndView mv) {
        
        page_service.pagination(pageVO, service.countAll());
            
        mv.addObject("BoardList", service.findAllByPageVO(pageVO));
        mv.addObject("PageVO", pageVO);
        mv.setViewName("/home/board");
        return mv;
    }
    
    @RequestMapping(value="boardContent", method=RequestMethod.POST)
    public String boardContent() {
        return "/home/boardContent";
    }
    
}
