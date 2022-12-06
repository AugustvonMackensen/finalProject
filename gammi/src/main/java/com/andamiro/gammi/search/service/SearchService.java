package com.andamiro.gammi.search.service;

import java.util.List;

import com.andamiro.gammi.recipe.vo.Recipe;
import com.andamiro.gammi.search.foodinfo.vo.Foodinfo;

public interface SearchService {
	public List<Recipe> selectRecipeByKeyword(String keyword);
	public Foodinfo selectFoodByKeyword(String keyword);
}
