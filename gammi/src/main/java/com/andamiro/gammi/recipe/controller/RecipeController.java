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
	
	//레시피 첨부파일 다운로드 처리용
	@RequestMapping("rfdown.do")
	public ModelAndView fileDownMethod(ModelAndView mv, 
			HttpServletRequest request, 
			@RequestParam("ofile") String originalFileName,
			@RequestParam("rfile") String renameFileName) {
		// 첨부파일 저장 폴더 경로 지정
		String savePath = request.getSession()
				.getServletContext().getRealPath(
						"resources/recipe_upfiles");
		
		//저장 폴더에서 읽을 파일에 대한 파일 객체 생성함		
		File renameFile = new File(savePath + "\\" + renameFileName);
		//파일다운시 내보낼 파일 객체 생성
		File originFile = new File(originalFileName);
		
		mv.setViewName("filedown"); //등록된 파일다운로드 처리용 뷰클래스의 id명
		mv.addObject("renameFile", renameFile);
		mv.addObject("originFile", originFile);
		
		return mv;
	}
	
	
	//레시피 쓰기 페이지로 이동
	@RequestMapping("rwform.do")
	public String moveRecipeWriteForm() {
		return "recipe/recipeWriteForm";
	}
	
	//레시피 등록 처리용 : 파일 첨부(업로드) 기능 있음
	@RequestMapping(value="rinsert.do", method=RequestMethod.POST)
	public String recipeInsertMethod(Recipe recipe, Model model, 
			HttpServletRequest request, 
			@RequestParam(name="upfile", required=false) MultipartFile mfile) {
		logger.info("rinsert.do : " + mfile);
		
		//업로드된 파일 저장 폴더 지정
		String savePath = request.getSession()
				.getServletContext().getRealPath(
						"resources/recipe_upfiles");
		
		//첨부파일이 있을 때만 업로드된 파일을 지정된 폴더로 옮기기
		if(!mfile.isEmpty()) {
			//전송온 파일이름 추출함
			String fileName = mfile.getOriginalFilename();
			
			//다른 레시피의 첨부파일과
			//파일명이 중복되어서 오버라이팅되는 것을 막기 위해
			//파일명을 변경해서 폴더에 저장하는 방식을 사용할 수 있음
			//변경 파일명 : 년월일시분초.확장자
			if(fileName != null && fileName.length() > 0) {
				//바꿀 파일명에 대한 문자열 만들기
				//레시피 등록 요청시점의 날짜시간정보를 이용함
				SimpleDateFormat sdf = 
						new SimpleDateFormat("yyyyMMddHHmmss");
				//변경할 파일이름 만들기
				String renameFileName = sdf.format(
						new java.sql.Date(System.currentTimeMillis()));
				//원본 파일의 확장자를 추출해서, 변경 파일명에 붙여줌
				renameFileName += "." + fileName.substring(fileName.lastIndexOf(".") + 1);
				
				//파일 객체 만들기
				File originFile = new File(savePath + "\\" + fileName);
				File renameFile = new File(savePath + "\\" + renameFileName);
				
				//업로드된 파일 저장시키고, 바로 이름바꾸기 실행함
				try {
					mfile.transferTo(renameFile);
				} catch (Exception e) {					
					e.printStackTrace();
					model.addAttribute("message", "전송파일 저장 실패!");
					return "common/error";
				} 
				
				//recipe 객체에 첨부파일명 기록 저장하기
				recipe.setRecipe_original_imgname(fileName);
				recipe.setRecipe_rename_imgname(renameFileName);
			}
			
		}  //첨부파일이 있을 때만
		
		if(recipeService.insertRecipe(recipe) > 0) {
			return "redirect:rlist.do";
		}else {
			model.addAttribute("message", "새 레시피 등록 실패!");
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
	@RequestMapping(value="rsearchTitle.do", method=RequestMethod.POST)
	public String recipeSearchTitleMethod(
			@RequestParam("keyword") String keyword, Model model,
			@RequestParam(name="page", required=false) String page) {
		
		ArrayList<Recipe> list = recipeService.selectSearchTitle(keyword);

		
		
		
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
		
		
		if(list.size() > 0 && list != null) {
			model.addAttribute("list", list);
			model.addAttribute("listCount", listCount);
			model.addAttribute("maxPage", maxPage);
			model.addAttribute("currentPage", currentPage);
			model.addAttribute("startPage", startPage);
			model.addAttribute("endPage", endPage);
			model.addAttribute("limit", limit);
			
			return "recipe/recipeListView";
		}else {
			model.addAttribute("message", 
					keyword + "로 검색된 레시피 정보가 없습니다.");
			return "common/error";
		}	
	} // method end
	
	//레시피 내용 검색
	@RequestMapping(value="rsearchContent.do", method=RequestMethod.POST)
	public String recipeSearchContentMethod(
			@RequestParam("keyword") String keyword, Model model) {
			ArrayList<Recipe> list = recipeService.selectSearchContent(keyword);
		
		if(list.size() > 0) {
			model.addAttribute("list", list);
			return "recipe/recipeListView";
		}else {
			model.addAttribute("message", 
					keyword + "로 검색된 레시피 정보가 없습니다.");
			return "common/error";
		}
	}
	
	// 레시피 수정페이지 이동
	@RequestMapping("rmoveup.do")
	public String moveRecipeUpdateView(
			@RequestParam("recipe_num") int recipe_num,
			Model model) {
		Recipe recipe = recipeService.selectRecipe(recipe_num);
		if(recipe != null) {
			model.addAttribute("recipe", recipe);
			return "recipe/recipeUpdateForm";
		}else {
			model.addAttribute("message", 
					recipe_num + "번 레시피 수정페이지로 이동 실패");
			return "common/error";
		}
	}	
	
	//레시피 수정 요청 처리용
	@RequestMapping(value="rupdate.do", method=RequestMethod.POST)
	public String recipeUpdateMethod(Recipe recipe, Model model, 
			@RequestParam(name="delFlag", required=false) String delFlag,
			@RequestParam(name="upfile", required=false) MultipartFile mfile,
			HttpServletRequest request) {
		
		//첨부파일 저장 폴더 경로 지정
		String savePath = request.getSession()
				.getServletContext().getRealPath(
						"resources/recipe_upfiles");
		
		//첨부파일 수정 처리된 경우 --------------------------------
		//1. 원래 첨부파일이 있는데 삭제를 선택한 경우
		if(recipe.getRecipe_original_imgname() != null 
				&& delFlag != null && delFlag.equals("yes")) {
			//저장 폴더에서 파일을 삭제함
			new File(savePath + "\\" + recipe.getRecipe_rename_imgname()).delete();
			//레시피의 파일정보도 제거함
			recipe.setRecipe_original_imgname(null);
			recipe.setRecipe_rename_imgname(null);
		}
		
		//2. 새로운 첨부파일이 있을 때 : 레시피 첨부파일은 1개만 가능한 경우
		if(!mfile.isEmpty()) {
			//저장 폴더의 이전 파일은 삭제함
			if(recipe.getRecipe_original_imgname() != null) {
				//저장 폴더에서 파일을 삭제함
				new File(savePath + "\\" + recipe.getRecipe_rename_imgname()).delete();
				//레시피의 파일정보도 제거함
				recipe.setRecipe_original_imgname(null);
				recipe.setRecipe_rename_imgname(null);
			}
			
			//이전 첨부파일이 없을 때 --------------------------
			//전송온 파일이름 추출함
			String fileName = mfile.getOriginalFilename();
			
			//다른 레시피의 첨부파일과
			//파일명이 중복되어서 오버라이팅되는 것을 막기 위해
			//파일명을 변경해서 폴더에 저장하는 방식을 사용할 수 있음
			//변경 파일명 : 년월일시분초.확장자
			if(fileName != null && fileName.length() > 0) {
				//바꿀 파일명에 대한 문자열 만들기
				//공지글 등록 요청시점의 날짜시간정보를 이용함
				SimpleDateFormat sdf = 
						new SimpleDateFormat("yyyyMMddHHmmss");
				//변경할 파일이름 만들기
				String renameFileName = sdf.format(
						new java.sql.Date(System.currentTimeMillis()));
				//원본 파일의 확장자를 추출해서, 변경 파일명에 붙여줌
				renameFileName += "." + fileName.substring(fileName.lastIndexOf(".") + 1);
				
				//파일 객체 만들기
				File originFile = new File(savePath + "\\" + fileName);
				File renameFile = new File(savePath + "\\" + renameFileName);
				
				//업로드된 파일 저장시키고, 바로 이름바꾸기 실행함
				try {
					mfile.transferTo(renameFile);
				} catch (Exception e) {					
					e.printStackTrace();
					model.addAttribute("message", "전송파일 저장 실패!");
					return "common/error";
				} 
				
				//레시피 객체에 첨부파일명 기록 저장하기
				recipe.setRecipe_original_imgname(fileName);
				recipe.setRecipe_rename_imgname(renameFileName);
			}  //이름바꾸기해서 저장 처리
			
		}  //새로운 첨부파일이 있을 때만
		
		//-------------------------------------------------------------
		
		if(recipeService.updateRecipe(recipe) > 0) {
			return "redirect:rlist.do";
		}else {
			model.addAttribute("message", 
					recipe.getRecipe_num() + "번 레시피 수정 실패!");
			return "common/error";
		}
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
} // class end
