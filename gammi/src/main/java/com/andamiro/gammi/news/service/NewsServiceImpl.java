package com.andamiro.gammi.news.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.andamiro.gammi.common.Paging;
import com.andamiro.gammi.common.SearchPaging;
import com.andamiro.gammi.news.dao.NewsDao;
import com.andamiro.gammi.news.vo.News;

@Service("newsService")
public class NewsServiceImpl implements NewsService{
	@Autowired
	private NewsDao dao;

	@Override
	public int selectListCount() {
		return dao.selectListCount();
	}

	@Override
	public ArrayList<News> selectList(Paging paging) {
		return dao.selectList(paging);
	}

	@Override
	public int newsSearchTitleListCount(String keyword) {
		return dao.newsSearchTitleListCount(keyword);
	}

	@Override
	public ArrayList<News> newsSearchTitle(SearchPaging searchpaging) {
		return dao.newsSearchTitle(searchpaging);
	}

	@Override
	public ArrayList<News> selectTop4() {
		return dao.selectTop4();
	}
}
