package com.andamiro.gammi.recipe.service;

import java.util.ArrayList;

import com.andamiro.gammi.common.Paging;
import com.andamiro.gammi.common.SearchPaging;
import com.andamiro.gammi.recipe.vo.Recipe;


public interface RecipeService {

	int selectListCount();

	ArrayList<Recipe> selectList(Paging paging);

	int updateAddReadcount(int recipe_num);
	
	int deleteRecipe(int recipe_num);

	Recipe selectRecipe(int recipe_num);

	int insertRecipe(Recipe recipe);

	int updateRecipe(Recipe recipe);

	ArrayList<Recipe> selectSearchTitle(SearchPaging searchpaging);

	ArrayList<Recipe> selectSearchContent(SearchPaging searchpaging);

	ArrayList<Recipe> selectStarList(Paging paging);

	int selectSearchTListCount(String keyword);

	int selectSearchCListCount(String keyword);
//----------------------------------------------------
	public ArrayList<Recipe> selectTop5();

	public ArrayList<Recipe> selectTop7();



	
	
	



}
