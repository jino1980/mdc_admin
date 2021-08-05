package com.merck.catalog.admin.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.merck.catalog.admin.dao.CmmnCdDAO;
import com.merck.catalog.admin.dao.CommonDao;
import com.merck.catalog.admin.vo.TbSaa002d;


@Service
public class CmmnCdService extends CommonServiceImpl<TbSaa002d> {
	    
		@Autowired
	    private CmmnCdDAO dao;
	    
	    @Autowired
	    public CmmnCdService(CommonDao<TbSaa002d> commonDao) {
	        super(commonDao);
	        this.dao = (CmmnCdDAO) commonDao;
	    }

	    public List<Map<String, Object>> selectCmmnCdList(HashMap<String,Object> map) {
	        return dao.selectCmmnCdList(map);
	    }
	    
	    public Map<String, Object> selectCmmnCdChkForUpdate(HashMap<String,Object> map) {
	    	return dao.selectCmmnCdChkForUpdate(map);
	    }
	    
	    public Map<String, Object> selectCmmnCdChkForUsing(HashMap<String,Object> map) {
	    	return dao.selectCmmnCdChkForUsing(map);
	    }
	    
	    public String insertCmmnCd(HashMap<String,Object> map)  throws Exception{
	        return dao.insertCmmnCd(map);
	    }
	    
	    
	    public int updateCmmnCd(HashMap<String,Object> map) throws Exception {
	        return dao.updateCmmnCd(map);
	    }
	    
	    
	    public int deleteCmmnCd(HashMap<String,Object> map) throws Exception {
	        return dao.deleteCmmnCd(map);
	    }
	    
	    
	    public int deleteByCategoryList(HashMap<String,Object> map)  throws Exception{
	    	return dao.deleteByCategoryList(map);
	    }
	    
	}

