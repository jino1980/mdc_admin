package com.merck.catalog.admin.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.merck.catalog.admin.vo.TbCaa001m;
import com.merck.catalog.common.SoftLabHumUtils;

@Repository
public class BoardCommonDAO extends CommonDaoImpl<TbCaa001m>{
	
	private final String NAMESPACE = "com.merck.catalog.admin.dao.BoardCommon.";
	private final String TB_CAB001M_NAMESPACE = "com.merck.catalog.admin.dao.TbCab001mMapper."; // 게시판 기본
	private final String TB_CAB002D_NAMESPACE = "com.merck.catalog.admin.dao.TbCab002dMapper."; // 게시판 상세
	private final String TB_CAB004D_NAMESPACE = "com.merck.catalog.admin.dao.TbCab004dMapper."; // 문의담당자 상세
	private final String TB_CAC001D_NAMESPACE = "com.merck.catalog.admin.dao.TbCac001dMapper."; // 푸시상세
	private final String TB_SAF001D_NAMESPACE = "com.merck.catalog.admin.dao.TbSaf001dMapper."; // 첨부파일
	private final String TB_SAF002D_NAMESPACE = "com.merck.catalog.admin.dao.TbSaf002dMapper."; // 이미지파일
	private final String TB_SAF003D_NAMESPACE = "com.merck.catalog.admin.dao.TbSaf003dMapper."; // 카달로그 파일
	
	public List<Map<String,Object>> selectTaskBoardList(HashMap<String,Object> map) {
        return sqlSession.selectList(NAMESPACE+"selectTaskBoardList", map);
    }
	
	public String insertBoardByTask(HashMap<String,Object> map) {
		TbCaa001m vo = SoftLabHumUtils.convertMapToVo(map, TbCaa001m.class);
		
		
		Map newIdMap = sqlSession.selectOne(NAMESPACE+"selectNewId", vo);
		String newId = (String)newIdMap.get("newId");
		vo.setCatlgId(newId);
		
		sqlSession.insert(TB_CAB002D_NAMESPACE+"insert", vo);
		
        return newId;
    }
	
	
}
