package com.andamiro.gammi.recipe.service;

import java.util.ArrayList;

import com.andamiro.gammi.common.Paging;
import com.andamiro.gammi.common.SearchPaging;
import com.andamiro.gammi.recipe.vo.Recipe;
import com.andamiro.gammi.search.foodinfo.vo.Foodinfo;


public interface RecipeService {
//
	int selectListCount();
//
	ArrayList<Recipe> selectList(Paging paging);

//
	ArrayList<Recipe> selectSearchTitle(SearchPaging searchpaging);

//
	int selectSearchTListCount(String keyword);

//----------------------------------------------------
	public ArrayList<Recipe> selectTop5(String keyword);

	public ArrayList<Recipe> selectTop7();

}
