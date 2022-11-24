package com.andamiro.gammi.search.service;

import com.andamiro.gammi.search.foodinfo.vo.Foodinfo;
import com.andamiro.gammi.search.recipe.vo.Recipe;

public interface SearchService {
	public Recipe selectRecipeByKeyword(String keyword);
	public Foodinfo selectFoodByKeyword(String keyword);
}
