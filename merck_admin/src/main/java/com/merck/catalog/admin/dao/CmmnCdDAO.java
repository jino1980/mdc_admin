package com.merck.catalog.admin.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.merck.catalog.admin.vo.PageVO;
import com.merck.catalog.admin.vo.TbSaa001m;


	@Repository
	public class CmmnCdDAO implements TbSaa001mMapper {
	

	    @Inject
	    SqlSession sqlSession;

	    private static final String NAMESPACE = "com.merck.catalog.admin.dao.TbSaa001mMapper";

		@Override
		public int deleteByPrimaryKey(String cmmnCdId) {
			// TODO Auto-generated method stub
			return 0;
		}

		@Override
		public int insert(com.mybatis.gen.model.TbSaa001m record) {
			// TODO Auto-generated method stub
			return 0;
		}

		@Override
		public com.mybatis.gen.model.TbSaa001m selectByPrimaryKey(String cmmnCdId) {
			// TODO Auto-generated method stub
			return null;
		}

		@Override
		public List<com.mybatis.gen.model.TbSaa001m> selectAll() {
			// TODO Auto-generated method stub
			return null;
		}

		@Override
		public int updateByPrimaryKey(com.mybatis.gen.model.TbSaa001m record) {
			// TODO Auto-generated method stub
			return 0;
		}
	    
	    
	    
	}

