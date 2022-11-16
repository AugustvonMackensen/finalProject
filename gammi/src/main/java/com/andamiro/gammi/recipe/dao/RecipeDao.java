package com.andamiro.gammi.recipe.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.andamiro.gammi.common.Paging;
import com.andamiro.gammi.recipe.vo.Recipe;

@Repository("recipeDao")
public class RecipeDao {
	
	//스프링-마이바티스 연동 객체 사용 : root-context.xml 에 있음
	@Autowired
	private SqlSessionTemplate session;

//	public ArrayList<Recipe> selectTop5() {
//		List<Recipe> list = session.selectList("recipeMapper.selectTop5");
//		return (ArrayList<Recipe>)list;
//	}

	public int selectListCount() {
		return session.selectOne("recipeMapper.getListCount");
	}

	public ArrayList<Recipe> selectList(Paging paging) {
		List<Recipe> list = session.selectList("recipeMapper.selectList", paging);
		return (ArrayList<Recipe>)list;
	}

	public int updateAddReadcount(int recipe_num) {
		return session.update("recipeMapper.addReadCount", recipe_num);
	}

	public int deleteRecipe(int recipe_num) {
		return session.delete("recipeMapper.deleteRecipe", recipe_num);
	}

	public Recipe selectRecipe(int recipe_num) {
		return session.selectOne("recipeMapper.selectRecipe", recipe_num);
	}

	public int insertRecipe(Recipe recipe) {
		return session.insert("recipeMapper.insertRecipe", recipe);
	}

	public int updateRecipe(Recipe recipe) {
		return session.update("recipeMapper.updateRecipe", recipe);
	}

	public ArrayList<Recipe> selectSearchTitle(String keyword) {
		List<Recipe> list = session.selectList("recipeMapper.searchTitle", keyword);
		return (ArrayList<Recipe>)list;
	}

	public ArrayList<Recipe> selectSearchContent(String keyword) {
		List<Recipe> list = session.selectList("recipeMapper.searchContent", keyword);
		return (ArrayList<Recipe>)list;
	}

	public ArrayList<Recipe> selectStarList(Paging paging) {
		List<Recipe> list = session.selectList("recipeMapper.selectStarList", paging);
		return (ArrayList<Recipe>)list;
	}



	
} // class end
