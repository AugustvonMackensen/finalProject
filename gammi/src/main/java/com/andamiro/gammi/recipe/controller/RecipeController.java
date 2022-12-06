package com.andamiro.gammi.recipe.controller;


import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.andamiro.gammi.common.Paging;
import com.andamiro.gammi.common.SearchPaging;
import com.andamiro.gammi.member.vo.Member;
import com.andamiro.gammi.recipe.service.RecipeService;
import com.andamiro.gammi.recipe.vo.Recipe;


@Controller
public class RecipeController {
	private static final Logger logger = 
			LoggerFactory.getLogger(RecipeController.class);
	
	
	@Autowired
	private RecipeService recipeService;
	
//	
//	@RequestMapping(value="rtop5.do", method=RequestMethod.POST)
//	@ResponseBody  
//	public String recipeReadcountTop5Method() throws UnsupportedEncodingException {		
//		
//		//조회수 많은 원글 5개 조회해 옴
//		ArrayList<Recipe> list = recipeService.selectTop5();
//		logger.info("rtop5.do : " + list.size());
//		
//		//전송용 json 객체 준비
//		JSONObject sendJson = new JSONObject();
//		//list 를 옮길 json 배열 객체 준비
//		JSONArray jarr = new JSONArray();
//		
//		//list 를 jarr 에 옮기기 (복사)
//		for(Recipe recipe : list) {
//			//recipe 객체의 각 필드값 저장할 json 객체 생성함
//			JSONObject jobj = new JSONObject();
//			
//			jobj.put("recipe_num", recipe.getRecipe_num());
//			
//			//한글에 대해서는 인코딩해서 json 에 담도록 함
//			//한글이 깨지지 않음
//			jobj.put("recipe_title", URLEncoder.encode(recipe.getRecipe_title(), "utf-8"));
//			jobj.put("recipe_readcount", recipe.getRecipe_readcount());
//				
//			jarr.add(jobj);  //jobj 를 jarr에 저장
//		}
//		
//		//전송용 객체에 jarr 을 담음
//		sendJson.put("list", jarr);
//		
//		//json 을 json string 타입으로 바꿔서 전송함
//		return sendJson.toJSONString();  //뷰리졸버로 리턴함
//		
//		//ajax 로 리턴은 여러가지 방법이 있음 : response 객체 이용
//		//1. 출력스트림으로 응답하는 방법 (아이디 중복체크에서 사용)
//		//2. 뷰리졸버로 리턴하는 방법 : response body에 값을 저장함
//	}
	
	
	@RequestMapping("starlist.do")
	public ModelAndView recipeStarListMethod(
			@RequestParam(name="page", required=false) String page, 
			ModelAndView mv) {
		int currentPage = 1;
		if(page != null) {
			currentPage = Integer.parseInt(page);
		}
		
		int limit = 40;
		int listCount = recipeService.selectListCount();
		int maxPage = (int)((double)listCount / limit + 0.9);
		int startPage = (currentPage / 10) * 10 + 1;
		//현재 페이지가 포함된 페이지 그룹의 끝값 지정
		int endPage = startPage + 10 - 1;
		
		if(maxPage < endPage) {
			endPage = maxPage;
		}
		
		//쿼리문에 전달할 현재 페이지에 적용할 목록의 시작행과 끝행 계산
		int startRow = (currentPage - 1) * limit + 1;
		int endRow = startRow + limit - 1;
		Paging paging = new Paging(startRow, endRow);
		
		//페이징 계산 처리 끝 ---------------------------------------
		
		ArrayList<Recipe> list = recipeService.selectStarList(paging);
		
		if(list != null && list.size() > 0) {
			mv.addObject("list", list);
			mv.addObject("listCount", listCount);
			mv.addObject("maxPage", maxPage);
			mv.addObject("currentPage", currentPage);
			mv.addObject("startPage", startPage);
			mv.addObject("endPage", endPage);
			mv.addObject("limit", limit);
			
			mv.setViewName("recipe/recipeListView");
		}else {
			mv.addObject("message", 
					currentPage + " 페이지 목록 조회 실패.");
			mv.setViewName("common/error");
		}
		
		return mv;
	}
	
	
	//레시피 페이지 단위로 목록보기 요청 처리용
	@RequestMapping("rlist.do")
	public ModelAndView recipeListMethod(
			@RequestParam(name="page", required=false) String page,
			ModelAndView mv) {
		
		int currentPage = 1;
		if(page != null) {
			currentPage = Integer.parseInt(page);
		}
		
		//한 페이지에 레시피 10개씩 출력되게 하는 경우
		//페이징 계산 처리 -- 별도의 클래스로 작성해도 됨 ---------------
		//별도의 클래스의 메소드에서 Paging 을 리턴하면 됨
		int limit = 40;  //한 페이지에 출력할 목록 갯수
		//전체 페이지 갯수 계산을 위해 총 목록 갯수 조회해 옴
		int listCount = recipeService.selectListCount();
		//페이지 수 계산
		//주의 : 목록이 11개이면 페이지 수는 2페이지가 됨
		// 나머지 목록 1개도 1페이지가 필요함
		int maxPage = (int)((double)listCount / limit + 0.9);
		//현재 페이지가 포함된 페이지 그룹의 시작값 지정
		// => 뷰 아래쪽에 표시할 페이지 수를 10개로 하는 경우
		int startPage = (currentPage / 10) * 10 + 1;
		//현재 페이지가 포함된 페이지 그룹의 끝값 지정
		int endPage = startPage + 10 - 1;
		
		if(maxPage < endPage) {
			endPage = maxPage;
		}
		
		//쿼리문에 전달할 현재 페이지에 적용할 목록의 시작행과 끝행 계산
		int startRow = (currentPage - 1) * limit + 1;
		int endRow = startRow + limit - 1;
		Paging paging = new Paging(startRow, endRow);
		
		//페이징 계산 처리 끝 ---------------------------------------
		
		ArrayList<Recipe> list = recipeService.selectList(paging);
		
		if(list != null && list.size() > 0) {
			mv.addObject("list", list);
			mv.addObject("listCount", listCount);
			mv.addObject("maxPage", maxPage);
			mv.addObject("currentPage", currentPage);
			mv.addObject("startPage", startPage);
			mv.addObject("endPage", endPage);
			mv.addObject("limit", limit);
			
			mv.setViewName("recipe/recipeListView");
		}else {
			mv.addObject("message", 
					currentPage + " 페이지 목록 조회 실패.");
			mv.setViewName("common/error");
		}
		
		return mv;
	}
	
	
	@RequestMapping("detail.do")
	public ModelAndView recipeAddCountMethod(ModelAndView mv, @RequestParam("recipe_num") int recipe_num, 
											@RequestParam(name="page", required=false) String page, HttpSession session) {
		
		int currentPage = 1;
		if(page != null) {
			currentPage = Integer.parseInt(page);
		}
		
		recipeService.updateAddReadcount(recipe_num);
		
		Recipe recipe = recipeService.selectRecipe(recipe_num);
		
		if(recipe != null) {
			mv.addObject("recipe", recipe);
			Member loginMember = (Member)session.getAttribute("loginMember");
			
		}else {
			mv.addObject("message", 
					currentPage + " 페이지 목록 조회 실패.");
			mv.setViewName("common/error");
		}
		return mv;
	} // class end
	

	//레시피 제목 검색
	@RequestMapping(value="rsearchTitle.do", method=RequestMethod.GET)
	public String recipeSearchTitleMethod(
			@RequestParam("keyword") String keyword, Model model,
			@RequestParam(name="page", required=false) String page) {
		
		int currentPage = 1;
		if(page != null) {
			currentPage = Integer.parseInt(page);
		}
		
		//한 페이지에 레시피 40개씩 출력되게 하는 경우
		//페이징 계산 처리 -- 별도의 클래스로 작성해도 됨 ---------------
		//별도의 클래스의 메소드에서 Paging 을 리턴하면 됨
		int limit = 40;  //한 페이지에 출력할 목록 갯수
		//전체 페이지 갯수 계산을 위해 총 목록 갯수 조회해 옴
		int listCount = recipeService.selectSearchTListCount(keyword);
		//페이지 수 계산
		//주의 : 목록이 11개이면 페이지 수는 2페이지가 됨
		// 나머지 목록 1개도 1페이지가 필요함
		int maxPage = (int)((double)listCount / limit + 0.9);
		//현재 페이지가 포함된 페이지 그룹의 시작값 지정
		// => 뷰 아래쪽에 표시할 페이지 수를 10개로 하는 경우
		int startPage = (currentPage / 10) * 10 + 1;
		//현재 페이지가 포함된 페이지 그룹의 끝값 지정
		int endPage = startPage + 10 - 1;
		
		if(maxPage < endPage) {
			endPage = maxPage;
		}
		
		//쿼리문에 전달할 현재 페이지에 적용할 목록의 시작행과 끝행 계산
		int startRow = (currentPage - 1) * limit + 1;
		int endRow = startRow + limit - 1;
		
		//페이징 계산 처리 끝 ---------------------------------------
		SearchPaging searchpaging = new SearchPaging(keyword, startRow, endRow);
		
		ArrayList<Recipe> list = recipeService.selectSearchTitle(searchpaging);
		
		if(list.size() > 0 && list != null) {
			model.addAttribute("list", list);
			model.addAttribute("listCount", listCount);
			model.addAttribute("maxPage", maxPage);
			model.addAttribute("currentPage", currentPage);
			model.addAttribute("startPage", startPage);
			model.addAttribute("endPage", endPage);
			model.addAttribute("limit", limit);
			model.addAttribute("action", "title");
			model.addAttribute("keyword", keyword);
			return "recipe/recipeListView";
		}else {
			model.addAttribute("message", 
					keyword + "로 검색된 레시피 정보가 없습니다.");
			return "common/error";
		}	
	} // method end
	
	
	
} // class end
