package com.merck.catalog.admin.dao;

import java.io.Serializable;
import java.lang.reflect.ParameterizedType;
import java.lang.reflect.Type;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.merck.catalog.admin.vo.PageVO;

@SuppressWarnings({"unchecked", "rawtypes"})
@Repository
public abstract class CommonDaoImpl<T extends Serializable> implements CommonDao<T> {

    @Autowired
    protected SqlSessionTemplate sqlSession;
    
    protected Class<? extends T> daoType;
    
    String sqlName = "";
    
    public CommonDaoImpl() {
        Type t = getClass().getGenericSuperclass();
        ParameterizedType pt = (ParameterizedType) t;
        daoType = (Class) pt.getActualTypeArguments()[0];
        sqlName = daoType.getSimpleName();
    }
    
    public int countAll() {
      return sqlSession.selectOne(sqlName+".countAll");
    }
    
    public T findOneById(int Id) {
        return sqlSession.selectOne(sqlName+".findOneById", Id);
    }

    public List<T> findAllByPageVO(PageVO vo) {
        return sqlSession.selectList(sqlName+".findAllByPageVO", vo);
    }

    public int insert(T vo) {
        return sqlSession.insert(sqlName+".insert", vo);
    }

    public int update(T vo) {
        return sqlSession.update(sqlName+".update", vo);
    }

    public int delete(int Id) {
        return sqlSession.delete(sqlName+".delete", Id);
    }
}
