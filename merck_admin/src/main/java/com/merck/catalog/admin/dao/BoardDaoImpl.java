package com.merck.catalog.admin.dao;

import org.springframework.stereotype.Repository;

import com.merck.catalog.admin.vo.BoardVO;

@Repository
public class BoardDaoImpl extends CommonDaoImpl<BoardVO> implements BoardDao {
    
    @Override
    public int checkPassword(BoardVO vo) {
        return sqlSession.selectOne("BoardVO.checkPassword", vo);
    }

}