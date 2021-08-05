package com.merck.catalog.admin.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.merck.catalog.admin.dao.BoardCommonDAO;
import com.merck.catalog.admin.dao.CommonDao;
import com.merck.catalog.admin.vo.TbCab001m;
import com.merck.catalog.admin.vo.TbSaf002d;
import com.merck.catalog.common.SoftLabHumUtils;

@Service
public class BoardCommonService extends CommonServiceImpl<TbCab001m> {
	    
	    private BoardCommonDAO dao;
	    
	    @Autowired
	    public BoardCommonService(CommonDao<TbCab001m> commonDao) {
	        super(commonDao);
	        this.dao = (BoardCommonDAO) commonDao;
	    }

	    public List<Map<String, Object>> selectBoardCommonList(HashMap<String,Object> map) {
	        return dao.selectBoardCommonList(map);
	    }
	    
	    public List<Map<String, Object>> selectQnamList(HashMap<String,Object> map) {
	    	return dao.selectQnamList(map);
	    }
	    
	    public List<Map<String, Object>> selectImgGrpList(HashMap<String,Object> map) {
	    	return dao.selectImgGrpList(map);
	    }
	    public List<Map<String, Object>> selectCatalogGrpList(HashMap<String,Object> map) {
	    	return dao.selectCatalogGrpList(map);
	    }
	    
	    
	    
	    public String insertBoardCommon(HashMap<String,Object> map) {
	        return dao.insertBoardCommon(map);
	    }
	    
	    
	    public int updateBoardCommon(HashMap<String,Object> map) {
	        return dao.updateBoardCommon(map);
	    }
	    
	    public int updateForImgGrp(HashMap<String,Object> map) {
	    	return dao.updateForImgGrp(map);
	    }
	    
	    public int deleteBoardCommon(HashMap<String,Object> map) {
	        return dao.deleteBoardCommon(map);
	    }
	    
	    
	    public Map<String,Object> selectAttchFile(HashMap<String,Object> map) throws Exception {
	    	return dao.selectAttchFile(map);
	    }
	    public String insertAttchFile(HashMap<String,Object> map) throws Exception {
	    	 return dao.insertAttchFile(map);
		}
				
		public int deleteAttchFile(HashMap<String,Object> map) throws Exception {
			 return dao.deleteAttchFile(map);
		}
	}

