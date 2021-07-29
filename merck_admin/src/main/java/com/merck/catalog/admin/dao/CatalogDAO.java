package com.merck.catalog.admin.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.merck.catalog.admin.vo.TbCaa001m;
import com.merck.catalog.common.SoftLabHumUtils;

@Repository
public class CatalogDAO extends CommonDaoImpl<TbCaa001m>{
	
	private final String NAMESPACE = "com.merck.catalog.admin.dao.Catalog.";
	private final String TBCAA001M_NAMESPACE = "com.merck.catalog.admin.dao.TbCaa001mMapper.";
	
	public List<Map<String,Object>> selectCatalogList(HashMap<String,Object> map) {
        return sqlSession.selectList(NAMESPACE+"selectCatalogList", map);
    }
	
	public String insertCatalog(HashMap<String,Object> map) {
		TbCaa001m vo = SoftLabHumUtils.convertMapToVo(map, TbCaa001m.class);
		
		
		Map newIdMap = sqlSession.selectOne(NAMESPACE+"selectCatalogNewId", vo);
		String newId = (String)newIdMap.get("newId");
		vo.setCatlgId(newId);
		
		sqlSession.insert(TBCAA001M_NAMESPACE+"insert", vo);
		
        return newId;
    }
	public int updateCatalog(HashMap<String,Object> map) {
		TbCaa001m vo = SoftLabHumUtils.convertMapToVo(map, TbCaa001m.class);
		return sqlSession.update(TBCAA001M_NAMESPACE+"updateByPrimaryKey", vo);
	}
	public int deleteCatalog(HashMap<String,Object> map) {
		TbCaa001m vo = SoftLabHumUtils.convertMapToVo(map, TbCaa001m.class);
		return sqlSession.delete(TBCAA001M_NAMESPACE+"deleteByPrimaryKey", vo);
	}
	
	
}
