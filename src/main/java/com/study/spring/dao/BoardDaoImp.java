package com.study.spring.dao;


import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;


@Repository("BoardDao")
public class BoardDaoImp implements BoardDao {

	@Resource(name = "sqlSessionTemplate")
	private SqlSessionTemplate sqlSessionTemplate;
	
	public List<Map<String, Object>> list(Map<String, Object> map){
		return sqlSessionTemplate.selectList("mapper.listDao", map);
	}
	
	public int insertBoard(Map<String, Object> map){
		return sqlSessionTemplate.insert("mapper.writeok", map);
	}

	public int modify(Map<String, Object> map) {
		return sqlSessionTemplate.update("mapper.modify", map);
	}

	public Map<String, Object> content(int seq) {
		return sqlSessionTemplate.selectOne("mapper.content", seq);
	}

	public int Uphit(int seq) {
		return sqlSessionTemplate.update("mapper.uphit", seq);
	}

	public int delete(List<Integer> list) {
		return sqlSessionTemplate.delete("mapper.delete", list);
	}

	public List<Map<String, Object>> search(Map<String, Object> map) {
		return sqlSessionTemplate.selectList("mapper.search", map);
	}

	public int total(Map<String, Object> map) {
		return sqlSessionTemplate.selectOne("mapper.total", map);
	}

	public List<Map<String, Object>> miplist(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return sqlSessionTemplate.selectList("mapper.miplist", map);
	}
}
