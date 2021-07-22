package com.merck.catalog.admin.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.merck.catalog.admin.vo.HomeVO;
import com.merck.catalog.admin.vo.UserVO;

@Repository
public class HomeDao {
	@Autowired
	private SqlSessionTemplate sqlSession;

	public List<HomeVO> zoro() {
		return sqlSession.selectList("sql.zoro");
	}

	public UserVO getUserByName(String username) {
		return sqlSession.selectOne("sql.getUser", username);
	}
	
	public int getUserCountByName(String username) {
		return sqlSession.selectOne("sql.getUserCount", username);
	}
	
	public int insertUser(UserVO vo) {
		return sqlSession.insert("sql.insertUser", vo);
	}
	
	public int insertAuthority(UserVO vo) {
		return sqlSession.insert("sql.insertAuth", vo);
	}
	
}