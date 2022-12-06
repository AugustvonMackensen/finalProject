package com.andamiro.gammi.search.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.andamiro.gammi.recipe.vo.Recipe;
import com.andamiro.gammi.search.foodinfo.vo.Foodinfo;

@Repository("searchDao")
public class SearchDao {
	@Autowired
	private SqlSessionTemplate session;
	
	public List<Recipe> selectRecipeByKeyword(String keyword) {
		return null;
	}

	public Foodinfo selectFoodByKeyword(String keyword) {
		return session.selectOne("foodinfoMapper.selectFoodByKeyword", keyword);
	}

}
