package com.merck.catalog.admin.dao;

import com.merck.catalog.admin.vo.BoardVO;

public interface BoardDao extends CommonDao<BoardVO> {
    public int checkPassword(BoardVO vo);
}
