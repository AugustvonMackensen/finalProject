package com.andamiro.gammi.recipe.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.andamiro.gammi.common.Paging;
import com.andamiro.gammi.common.SearchPaging;
import com.andamiro.gammi.recipe.vo.Recipe;

@Repository("recipeDao")
public class RecipeDao {
	
	//스프링-마이바티스 연동 객체 사용 : root-context.xml 에 있음
	@Autowired
	private SqlSessionTemplate session;

	public int selectListCount() {
		return session.selectOne("recipeMapper.getListCount");
	}

	public ArrayList<Recipe> selectList(Paging paging) {
		List<Recipe> list = session.selectList("recipeMapper.selectList", paging);
		return (ArrayList<Recipe>)list;
	}

	public ArrayList<Recipe> selectSearchTitle(SearchPaging searchpaging) {
		List<Recipe> list = session.selectList("recipeMapper.searchTitle", searchpaging);
		return (ArrayList<Recipe>)list;
	}

	public int selectSearchTListCount(String keyword) {
		return session.selectOne("recipeMapper.getSearchTListCount", keyword);
	}

	public ArrayList<Recipe> selectTop5() {
		List<Recipe> list = session.selectList("recipeMapper.selectTop5");
		return (ArrayList<Recipe>)list;
	}

	public ArrayList<Recipe> selectTop7() {
		List<Recipe> list = session.selectList("recipeMapper.selectTop7");
		return (ArrayList<Recipe>)list;
	}

} // class end
