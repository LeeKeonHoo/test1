package com.study.spring.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.study.spring.dao.BoardDaoImp;

@Service("BoardService")
public class ServiceDao implements BoardService {
	
	@Resource(name = "BoardDao")
	private BoardDaoImp boardDao;
	
	public List<Map<String, Object>> list(Map<String, Object> map) {
		return boardDao.list(map);
	}
	
	public int insertBoard(Map<String, Object> map) {
		return boardDao.insertBoard(map);
	}

	@Override
	public int modify(Map<String, Object> map) {
		return boardDao.modify(map);
	}

	@Override
	public Map<String, Object> content(int seq) {
		return boardDao.content(seq);
	}

	@Override
	public int Uphit(int seq) {
		return boardDao.Uphit(seq);
	}

	@Override
	public int delete(List<Integer> list) {
		return boardDao.delete(list);
	}

	@Override
	public List<Map<String, Object>> search(Map<String, Object> map) {
		return boardDao.search(map);
	}

	@Override
	public int total(Map<String, Object> map) {
		return boardDao.total(map);
	}

	@Override
	public List<Map<String, Object>> miplist(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return boardDao.miplist(map);
	}


	
}
