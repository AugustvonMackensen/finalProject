package com.andamiro.gammi;

import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.andamiro.gammi.board.service.BoardService;
import com.andamiro.gammi.board.vo.Board;
import com.andamiro.gammi.news.service.NewsService;
import com.andamiro.gammi.news.vo.News;
import com.andamiro.gammi.notice.service.NoticeService;
import com.andamiro.gammi.notice.vo.Notice;
import com.andamiro.gammi.recipe.service.RecipeService;
import com.andamiro.gammi.recipe.vo.Recipe;
/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@Autowired
	private BoardService boardservice;
	
	@Autowired
	private NoticeService noticeservice;
	
  @Autowired
	private RecipeService recipeService;
  
  @Autowired
   private NewsService newsService;
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		return "home";
	}

	@RequestMapping("main.do")
	public String forwardMainView(Model model){
		ArrayList<Notice> noticelist = noticeservice.selectNewTop4();
		ArrayList<Board> boardlist = boardservice.selectNewTop4();
		ArrayList<Recipe> recipelist = recipeService.selectTop7();
		ArrayList<News> newslist = newsService.selectTop4();
		model.addAttribute("b_list", boardlist);
		model.addAttribute("n_list", noticelist);
		model.addAttribute("r_list",recipelist);
		model.addAttribute("news_list",newslist);
		
		return "common/main";  //내보낼 뷰파일명 리턴
	}
}
