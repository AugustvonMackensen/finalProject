package com.andamiro.gammi.recipe.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.andamiro.gammi.common.Paging;
import com.andamiro.gammi.common.SearchPaging;
import com.andamiro.gammi.recipe.dao.RecipeDao;
import com.andamiro.gammi.recipe.vo.Recipe;


@Service("recipeService")
public class RecipeServiceImpl implements RecipeService {
	
	@Autowired
	private RecipeDao recipeDao;
	
	@Override
	public int selectListCount() {
		return recipeDao.selectListCount();
	}

	@Override
	public ArrayList<Recipe> selectList(Paging paging) {
		return recipeDao.selectList(paging);
	}

	@Override
	public ArrayList<Recipe> selectSearchTitle(SearchPaging searchpaging) {
		return recipeDao.selectSearchTitle(searchpaging);
	}

	@Override
	public int selectSearchTListCount(String keyword) {
		return recipeDao.selectSearchTListCount(keyword);
	}

	@Override
	public ArrayList<Recipe> selectTop5() {
		return recipeDao.selectTop5();
	}

	@Override
	public ArrayList<Recipe> selectTop7() {
		return recipeDao.selectTop7();
	}
} // class end
