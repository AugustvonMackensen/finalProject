package com.andamiro.gammi.search;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class SearchController {
	@RequestMapping("imgSearch.do")
	public String imgSearch() {
		return "search/imageView";
	}
	
	@GetMapping("result.do")
	public String searchResult() {
		return "food/searchView";
	}
	
	@RequestMapping("camSearch.do")
	public String camSearch() {
		return "search/camView";
	}
}
