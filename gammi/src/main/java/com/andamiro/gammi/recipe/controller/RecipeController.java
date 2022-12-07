package com.andamiro.gammi.recipe.controller;


import java.io.File;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.andamiro.gammi.common.Paging;
import com.andamiro.gammi.common.SearchPaging;
import com.andamiro.gammi.member.vo.Member;
import com.andamiro.gammi.recipe.service.RecipeService;
import com.andamiro.gammi.recipe.vo.Recipe;




@Controller
public class RecipeController {
	private final Logger logger = LoggerFactory.getLogger(getClass());
	
	
	@Autowired
	private RecipeService recipeService;
	

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
	
	//레시피 상세보기 요청 처리용
	@RequestMapping("rdetail.do")
	public String recipeDetailMethod(ModelAndView mv,
			@RequestParam("recipe_num") int recipe_num,
			@RequestParam(name="page", required=false) String page,
			Model model, HttpSession session) {
		int currentPage = 1;
		if(page != null) {
			currentPage = Integer.parseInt(page);
		}
		//조회수 1증가 처리
		recipeService.updateAddReadcount(recipe_num);
		//관리자용 상세보기 페이지와 일반 회원 상세보기 페이지 구분함
		//매개변수에 HttpSession 추가함
		Recipe recipe = recipeService.selectRecipe(recipe_num);
		
		if(recipe != null) {
			model.addAttribute("recipe", recipe);
//			mv.addObject("recipe", recipe);
//			mv.addObject("currentPage", currentPage);
//			mv.setViewName("recipe/recipeDetailView");
			
			Member loginMember = (Member)session.getAttribute("loginMember");
//			if(loginMember != null && loginMember.getAdmin().equals("Y")) {
//				//관리자가 상세보기를 요청했을 때
//				return "recipe/recipeAdminDetailView";
//			}else {
//				return "recipe/recipeDetailView";
//			}
			
			return "recipe/recipeDetailView";
			
		}else {
			model.addAttribute("message", 
					recipe_num + "번 레시피 상세보기 실패!");
			return "common/error";
		}
		
	}
	
	//레시피 삭제 요청 처리용
	@RequestMapping("rdel.do")
	public String recipeDeleteMethod(
			@RequestParam("recipe_num") int recipe_num, 
			@RequestParam(name="rfile", required=false) String renameFileName,
			Model model, HttpServletRequest request) {
		
		if(recipeService.deleteRecipe(recipe_num) > 0) {
			//첨부된 파일이 있는 레시피일때는 저장 폴더에 있는
			//첨부파일도 삭제함
			if(renameFileName != null) {
				new File(	request.getSession().getServletContext().getRealPath(
							"resources/recipe_upfiles") + "\\" + renameFileName).delete();
			}
			
			return "redirect:rlist.do";
		}else {
			model.addAttribute("message", 
					recipe_num + "번 레시피 삭제 실패!");
			return "common/error";
		}
	}
	
	
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
	}
	
	
} // class end
