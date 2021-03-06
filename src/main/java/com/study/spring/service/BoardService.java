package com.study.spring.service;

import java.util.List;
import java.util.Map;

public interface BoardService {
            
	List<Map<String, Object>> list(Map<String, Object> map);

	int insertBoard(Map<String, Object> map);

	int modify(Map<String, Object> map);

	Map<String, Object> content(int seq);

	int Uphit(int seq);

	int delete(List<Integer> list);

	List<Map<String, Object>> search(Map<String, Object> map);

	int total(Map<String, Object> map);

	List<Map<String, Object>> miplist(Map<String, Object> map);

}