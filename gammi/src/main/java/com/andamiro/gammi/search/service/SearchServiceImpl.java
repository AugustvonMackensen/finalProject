package com.andamiro.gammi.search.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.andamiro.gammi.recipe.vo.Recipe;
import com.andamiro.gammi.search.dao.SearchDao;
import com.andamiro.gammi.search.foodinfo.vo.Foodinfo;

@Service
public class SearchServiceImpl implements SearchService{
	
	@Autowired
	private SearchDao searchDao;
	
	public List<Recipe> selectRecipeByKeyword(String keyword) {
		return searchDao.selectRecipeByKeyword(keyword);
	}
	public Foodinfo selectFoodByKeyword(String keyword) {
		return searchDao.selectFoodByKeyword(keyword);
	}
}
