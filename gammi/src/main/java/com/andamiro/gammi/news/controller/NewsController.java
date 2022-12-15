package com.andamiro.gammi.news.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.andamiro.gammi.common.Paging;
import com.andamiro.gammi.common.SearchPaging;
import com.andamiro.gammi.news.service.NewsService;
import com.andamiro.gammi.news.vo.News;

@Controller
public class NewsController {
	@Autowired
	private NewsService service;
	
	//뉴스 페이지 단위로 목록보기 요청 처리용
		@RequestMapping("newslist.do")
		public ModelAndView newsListMethod(
				@RequestParam(name="page", required=false) String page,
				ModelAndView mv) {
			int currentPage = 1;
			if(page != null) {
				currentPage = Integer.parseInt(page);
			}
			int limit = 10; 
			int listCount = service.selectListCount();
			int maxPage = (int)((double)listCount / limit + 0.9);
			int startPage = (currentPage%10==0)? currentPage-9 :  (currentPage / 10) * 10 + 1 ;
			int endPage = startPage + 10 - 1;
			
			if(maxPage < endPage) {
				endPage = maxPage;
			}
			int startRow = (currentPage - 1) * limit + 1;
			int endRow = startRow + limit - 1;
			Paging paging = new Paging(startRow, endRow);
			
			//페이징 계산 처리 끝 ---------------------------------------
			
			ArrayList<News> list = service.selectList(paging);
			
			if(list != null) {
				mv.addObject("list", list);
				mv.addObject("listCount", listCount);
				mv.addObject("maxPage", maxPage);
				mv.addObject("currentPage", currentPage);
				mv.addObject("startPage", startPage);
				mv.addObject("endPage", endPage);
				mv.addObject("limit", limit);
			}
			mv.setViewName("news/newsListView");
			return mv;
		}
		
		//뉴스 제목 검색
		@RequestMapping(value="newsTitle.do", method=RequestMethod.GET)
		public String newsTitleMethod(
				@RequestParam("keyword") String keyword, Model model,
				@RequestParam(name="page", required=false) String page) {
			int currentPage = 1;
			if(page != null) {
				currentPage = Integer.parseInt(page);
			}
			
			int limit = 10;
			int listCount = service.newsSearchTitleListCount(keyword);
			int maxPage = (int)((double)listCount / limit + 0.9);
			int startPage = (currentPage%10==0)? currentPage-9 :  (currentPage / 10) * 10 + 1 ;
			int endPage = startPage + 10 - 1;
			
			if(maxPage < endPage) {
				endPage = maxPage;
			}
			
			int startRow = (currentPage - 1) * limit + 1;
			int endRow = startRow + limit - 1;
			
			SearchPaging searchpaging = new SearchPaging(keyword, startRow, endRow);
			
			ArrayList<News> list = service.newsSearchTitle(searchpaging);
			
			if(list != null) {
				model.addAttribute("list", list);
				model.addAttribute("listCount", listCount);
				model.addAttribute("maxPage", maxPage);
				model.addAttribute("currentPage", currentPage);
				model.addAttribute("startPage", startPage);
				model.addAttribute("endPage", endPage);
				model.addAttribute("limit", limit);
				model.addAttribute("action", "title");
				model.addAttribute("keyword", keyword);
			}
			return "news/newsListView";
		}
}
