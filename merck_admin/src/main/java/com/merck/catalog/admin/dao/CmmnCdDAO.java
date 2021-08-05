package com.merck.catalog.admin.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.merck.catalog.admin.controller.BoardCommonController;
import com.merck.catalog.admin.vo.TbSaa002d;
import com.merck.catalog.common.SoftLabHumUtils;


@Repository
public class CmmnCdDAO  extends CommonDaoImpl<TbSaa002d>{

	private static final Logger logger = LoggerFactory.getLogger(BoardCommonController.class);
	
    @Inject
    SqlSession sqlSession;

    private static final String NAMESPACE = "com.merck.catalog.admin.dao.CmmnCdDAO.";
    private static final String NAMESPACE_SAA001M = "com.merck.catalog.admin.dao.TbSaa001mMapper.";
    private static final String NAMESPACE_SAA002D = "com.merck.catalog.admin.dao.TbSaa002dMapper.";

    public List<Map<String, Object>> selectCmmnCdList(HashMap<String,Object> map) {
	    return sqlSession.selectList(NAMESPACE+"selectCmmnCdList", map);
	}
    
    public Map<String, Object> selectCmmnCdChkForUpdate(HashMap<String,Object> map) {
    	return sqlSession.selectOne(NAMESPACE+"selectCmmnCdChkForUpdate", map);
    }
    
    public Map<String, Object> selectCmmnCdChkForUsing(HashMap<String,Object> map) {
    	return (Map<String, Object>) sqlSession.selectList(NAMESPACE+"selectCmmnCdChkForUsing", map).get(0);
    }
	    
	public String insertCmmnCd(HashMap<String,Object> map) throws Exception{
		Map newCmmnCdMap = sqlSession.selectOne(NAMESPACE+"selectNewCmmnCd", map);
		String newCmmnCd = (String)newCmmnCdMap.get("newId");
		map.put("cmmnCd",newCmmnCd);
		sqlSession.insert(NAMESPACE_SAA002D+"insert", SoftLabHumUtils.convertMapToVo(map,TbSaa002d.class));
		return newCmmnCd;
	}
	
	public int updateCmmnCd(HashMap<String,Object> map) throws Exception {
		return sqlSession.update(NAMESPACE_SAA002D+"updateByPrimaryKey", SoftLabHumUtils.convertMapToVo(map,TbSaa002d.class));
	}
	
	public int deleteCmmnCd(HashMap<String,Object> map) throws Exception {
		return sqlSession.delete(NAMESPACE_SAA002D+"deleteByPrimaryKey", SoftLabHumUtils.convertMapToVo(map,TbSaa002d.class));
	}
	
	public int deleteByCategoryList(HashMap<String,Object> map) throws Exception {
		return sqlSession.delete(NAMESPACE+"deleteByCategoryList", map);
	}
    
    
}

