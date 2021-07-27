package com.merck.catalog.admin.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.merck.catalog.admin.dao.CatalogDAO;
import com.merck.catalog.admin.dao.CommonDao;
import com.merck.catalog.admin.vo.TbCaa001m;

@Service
public class CatalogService extends CommonServiceImpl<TbCaa001m> {
	    
	    private CatalogDAO dao;
	    
	    @Autowired
	    public CatalogService(CommonDao<TbCaa001m> commonDao) {
	        super(commonDao);
	        this.dao = (CatalogDAO) commonDao;
	    }

	    public List<Map<String, Object>> selectCatalogList(HashMap<String,Object> map) {
	        return dao.selectCatalogList(map);
	    }
	    
	    public int insertCatalog(HashMap<String,Object> map) {
	        return dao.insertCatalog(map);
	    }
	    
	    public int updateCatalog(HashMap<String,Object> map) {
	        return dao.updateCatalog(map);
	    }
	    
	    public int deleteCatalog(HashMap<String,Object> map) {
	        return dao.deleteCatalog(map);
	    }
	    
	}

