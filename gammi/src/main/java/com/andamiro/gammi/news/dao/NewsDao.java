package com.andamiro.gammi.news.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.andamiro.gammi.common.Paging;
import com.andamiro.gammi.common.SearchPaging;
import com.andamiro.gammi.news.vo.News;

@Repository("newsDao")
public class NewsDao {
	@Autowired
	private SqlSessionTemplate session;

	public int selectListCount() {
		return session.selectOne("newsMapper.selectListCount");
	}
	
	public ArrayList<News> selectList(Paging paging) {
		List<News> list = session.selectList("newsMapper.selectList",paging);
		return (ArrayList<News>)list;
	}

	public int newsSearchTitleListCount(String keyword) {
		return session.selectOne("newsMapper.newsSearchTitleListCount",keyword);
	}

	public ArrayList<News> newsSearchTitle(SearchPaging searchpaging) {
		List<News> list = session.selectList("newsMapper.newsSearchTitle",searchpaging);
		return (ArrayList<News>)list;
	}

	public ArrayList<News> selectTop4() {
		List<News> list = session.selectList("newsMapper.selectTop4");
		return (ArrayList<News>)list;
	}

}
