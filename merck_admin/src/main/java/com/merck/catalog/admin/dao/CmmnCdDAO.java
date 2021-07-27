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
	    
	    
	    public String getTime() {
	        return sqlSession.selectOne(NAMESPACE + ".getTime");
	    }

	    
		@Override
		public int deleteByPrimaryKey(String cmmnCdId) {
			// TODO Auto-generated method stub
			return 0;
		}

		@Override
		public int insert(TbSaa001m tbSaa001m) {
			// TODO Auto-generated method stub
			sqlSession.insert(NAMESPACE + ".insert", tbSaa001m);
			return 0;
		}

		@Override
		public TbSaa001m selectByPrimaryKey(String cmmnCdId) {
			// TODO Auto-generated method stub
			cmmnCdId = "TEST001003";
			return sqlSession.selectOne(NAMESPACE + ".selectByPrimaryKey", cmmnCdId);
		}

		@Override
		public List<TbSaa001m> selectAll() {
			// TODO Auto-generated method stub
			return sqlSession.selectList(NAMESPACE + ".selecAll");
		}

		@Override
		public int updateByPrimaryKey(TbSaa001m record) {
			// TODO Auto-generated method stub
			return sqlSession.update(NAMESPACE + ".updateByPrimaryKey", record);
		}


		@Override
		public int countAll() {
			// TODO Auto-generated method stub
			return 0;
		}


		@Override
		public TbSaa001m findOneById(int Id) {
			// TODO Auto-generated method stub
			return null;
		}


		@Override
		public List<TbSaa001m> findAllByPageVO(PageVO vo) {
			// TODO Auto-generated method stub
			return null;
		}


		@Override
		public int update(TbSaa001m obj) {
			// TODO Auto-generated method stub
			return 0;
		}


		@Override
		public int delete(int Id) {
			// TODO Auto-generated method stub
			return 0;
		}

	}

