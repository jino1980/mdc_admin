package com.merck.catalog.admin.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.merck.catalog.admin.dao.BoardDao;
import com.merck.catalog.admin.dao.BoardDaoImpl;
import com.merck.catalog.admin.dao.CommonDao;
import com.merck.catalog.admin.vo.BoardVO;

@Service
public class BoardServiceImpl extends CommonServiceImpl<BoardVO> implements BoardService {
    
    private BoardDao dao;
    
    public BoardServiceImpl() {
    
    }
    
    @Autowired
    public BoardServiceImpl(CommonDao<BoardVO> commonDao) {
        super(commonDao);
        this.dao = (BoardDaoImpl) commonDao;
    }

    @Override
    public int checkPassword(BoardVO vo) {
        return dao.checkPassword(vo);
    }

}
