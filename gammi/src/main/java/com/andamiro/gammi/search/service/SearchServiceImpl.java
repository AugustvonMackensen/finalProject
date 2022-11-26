package com.andamiro.gammi.search.service;

import org.springframework.stereotype.Service;

import com.andamiro.gammi.recipe.vo.Recipe;
import com.andamiro.gammi.search.dao.SearchDao;
import com.andamiro.gammi.search.foodinfo.vo.Foodinfo;

@Service
public class SearchServiceImpl implements SearchService{
	private SearchDao searchDao;
	public Recipe selectRecipeByKeyword(String keyword) {
		return searchDao.selectRecipeByKeyword(keyword);
	}
	public Foodinfo selectFoodByKeyword(String keyword) {
		return searchDao.selectFoodByKeyword(keyword);
	}
}
