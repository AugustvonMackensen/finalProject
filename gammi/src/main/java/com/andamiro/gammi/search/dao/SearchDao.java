package com.andamiro.gammi.search.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.andamiro.gammi.search.foodinfo.vo.Foodinfo;

@Repository("searchDao")
public class SearchDao {
	@Autowired
	private SqlSessionTemplate session;
	
	public Foodinfo selectFoodByKeyword(String keyword) {
		String key = session.selectOne("foodinfoMapper.keywordInfokeyword", keyword);
		return session.selectOne("foodinfoMapper.selectFoodByKeyword",key);
	}
}
