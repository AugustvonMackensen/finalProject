package com.andamiro.gammi.news.service;

import java.util.ArrayList;

import com.andamiro.gammi.common.Paging;
import com.andamiro.gammi.common.SearchPaging;
import com.andamiro.gammi.news.vo.News;

public interface NewsService {

	int selectListCount();

	ArrayList<News> selectList(Paging paging);

	int newsSearchTitleListCount(String keyword);

	ArrayList<News> newsSearchTitle(SearchPaging searchpaging);

	ArrayList<News> selectTop4();

}
