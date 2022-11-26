package com.andamiro.gammi.search.service;

import com.andamiro.gammi.recipe.vo.Recipe;
import com.andamiro.gammi.search.foodinfo.vo.Foodinfo;

public interface SearchService {
	public Recipe selectRecipeByKeyword(String keyword);
	public Foodinfo selectFoodByKeyword(String keyword);
}
