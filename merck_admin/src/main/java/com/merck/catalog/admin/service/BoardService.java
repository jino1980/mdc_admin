package com.merck.catalog.admin.service;

import com.merck.catalog.admin.vo.BoardVO;

public interface BoardService extends CommonService<BoardVO> {
    public int checkPassword(BoardVO vo);
}
