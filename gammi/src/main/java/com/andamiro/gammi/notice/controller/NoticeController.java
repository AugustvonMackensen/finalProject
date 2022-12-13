package com.andamiro.gammi.notice.controller;

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
import com.andamiro.gammi.member.service.MemberService;
import com.andamiro.gammi.member.vo.Member;
import com.andamiro.gammi.notice.service.NoticeService;
import com.andamiro.gammi.notice.vo.Notice;



@Controller
public class NoticeController {
	private static final Logger logger = LoggerFactory.getLogger(NoticeController.class);

	@Autowired
	private NoticeService noticeService;
	
	@Autowired
	private MemberService memberService;
	// 뷰 페이지 이동 처리용 ---------------------------------------------------------------
	
	// 새 공지글 등록 페이지로 이동
	@RequestMapping("movewrite.do")
	public String moveWritePage() {
		return "notice/noticeWriteForm";
	}
	
	//공지글 수정페이지로 이동
	@RequestMapping("nmoveup.do")
	public String moveUpdatePage(
			@RequestParam("notice_num") int notice_num, Model model) {
		//수정페이지에 출력할 해당 공지글 다시 조회함
		Notice notice = noticeService.selectNotice(notice_num);
		
		if(notice != null) {
			model.addAttribute("notice", notice);
			return "notice/noticeUpdateForm";
		}else {
			model.addAttribute("message", 
					notice_num + "번 공지글 수정페이지로 이동 실패!");
			return "common/error";
		}
	}
	// --------------------------------------------------------------
	
	//게시글 페이지 단위로 목록보기 요청 처리용
	@RequestMapping("nlist.do")
	public ModelAndView noticeListMethod(
			@RequestParam(name="page", required=false) String page,
			ModelAndView mv) {
		
		int currentPage = 1;
		if(page != null) {
			currentPage = Integer.parseInt(page);
		}
		
		int limit = 10;
		int listCount = noticeService.selectListCount();
		int maxPage = (int)((double)listCount / limit + 0.9);
		int startPage = (currentPage%10==0)? currentPage-9 :  (currentPage / 10) * 10 + 1 ;
		int endPage = startPage + 10 - 1;
		
		if(maxPage < endPage) {
			endPage = maxPage;
		}
		
		//쿼리문에 전달할 현재 페이지에 적용할 목록의 시작행과 끝행 계산
		int startRow = (currentPage - 1) * limit + 1;
		int endRow = startRow + limit - 1;
		Paging paging = new Paging(startRow, endRow);
		
		//페이징 계산 처리 끝 ---------------------------------------
		
		ArrayList<Notice> list = noticeService.selectList(paging);
		mv.addObject("list", list);
		if(list != null && list.size() > 0) {
			
			mv.addObject("listCount", listCount);
			mv.addObject("maxPage", maxPage);
			mv.addObject("currentPage", currentPage);
			mv.addObject("startPage", startPage);
			mv.addObject("endPage", endPage);
			mv.addObject("limit", limit);
		}
		mv.setViewName("notice/noticeListView");
		return mv;
	}
	
	
	//게시글 조회수로 목록보기 요청 처리용
	@RequestMapping("nstarlist.do")
	public String noticeStarlistMethod(
			@RequestParam("keyword") String keyword, 
			@RequestParam(name="page", required=false) String page,
			Model model) {
		int currentPage = 1;
		if(page != null) {
			currentPage = Integer.parseInt(page);
		}
		
		int limit = 10;
		int listCount = noticeService.selectListCount();
		int maxPage = (int)((double)listCount / limit + 0.9);
		int startPage = (currentPage%10==0)? currentPage-9 :  (currentPage / 10) * 10 + 1 ;
		int endPage = startPage + 10 - 1;
		if(maxPage < endPage) {
			endPage = maxPage;
		}
		
		int startRow = (currentPage - 1) * limit + 1;
		int endRow = startRow + limit - 1;
		
		//페이징 계산 처리 끝 ---------------------------------------
		SearchPaging searchpaging = new SearchPaging(keyword, startRow, endRow);
		
		ArrayList<Notice> list = noticeService.selectSearchReadcount(searchpaging);
		
		if(list.size() > 0) {
			model.addAttribute("list", list);
			model.addAttribute("listCount", listCount);
			model.addAttribute("maxPage", maxPage);
			model.addAttribute("currentPage", currentPage);
			model.addAttribute("startPage", startPage);
			model.addAttribute("endPage", endPage);
			model.addAttribute("limit", limit);
			model.addAttribute("action", "readcount");
			model.addAttribute("keyword", keyword);
			return "notice/noticeListView";
		}else {
			model.addAttribute("message", 
					keyword + "로 검색된 공지글 정보가 없습니다.");
			return "common/error";
		}
	}
	

	
	//공지글 제목 검색용
	@RequestMapping(value="nsearchTitle.do", method=RequestMethod.GET)
	public String noticeSearchTitleMethod(
			@RequestParam("keyword") String keyword, 
			@RequestParam(name="page", required=false) String page,
			Model model) {
		int currentPage = 1;
		if(page != null) {
			currentPage = Integer.parseInt(page);
		}
		
		int limit = 10;
		int listCount = noticeService.selectSearchTListCount(keyword);
		int maxPage = (int)((double)listCount / limit + 0.9);
		int startPage = (currentPage%10==0)? currentPage-9 :  (currentPage / 10) * 10 + 1 ;
		int endPage = startPage + 10 - 1;
		if(maxPage < endPage) {
			endPage = maxPage;
		}
		
		int startRow = (currentPage - 1) * limit + 1;
		int endRow = startRow + limit - 1;
		
		//페이징 계산 처리 끝 ---------------------------------------
		SearchPaging searchpaging = new SearchPaging(keyword, startRow, endRow);
		
		ArrayList<Notice> list = noticeService.selectSearchTitle(searchpaging);
		
		if(list.size() > 0) {
			model.addAttribute("list", list);
			model.addAttribute("listCount", listCount);
			model.addAttribute("maxPage", maxPage);
			model.addAttribute("currentPage", currentPage);
			model.addAttribute("startPage", startPage);
			model.addAttribute("endPage", endPage);
			model.addAttribute("limit", limit);
			model.addAttribute("action", "title");
			model.addAttribute("keyword", keyword);
			return "notice/noticeListView";
		}else {
			model.addAttribute("message", 
					keyword + "로 검색된 공지글 정보가 없습니다.");
			return "common/error";
		}
	}
	
	//공지글 내용 검색용
	@RequestMapping(value="nsearchContent.do", method=RequestMethod.GET)
	public String noticeSearchContentMethod(
			@RequestParam("keyword") String keyword, 
			@RequestParam(name="page", required=false) String page,
			Model model) {
		int currentPage = 1;
		if(page != null) {
			currentPage = Integer.parseInt(page);
		}
		
		int limit = 10;
		int listCount = noticeService.selectSearchCListCount(keyword);
		int maxPage = (int)((double)listCount / limit + 0.9);
		int startPage = (currentPage%10==0)? currentPage-9 :  (currentPage / 10) * 10 + 1 ;
		int endPage = startPage + 10 - 1;
		
		if(maxPage < endPage) {
			endPage = maxPage;
		}
		
		int startRow = (currentPage - 1) * limit + 1;
		int endRow = startRow + limit - 1;
		
		//페이징 계산 처리 끝 ---------------------------------------
		SearchPaging searchpaging = new SearchPaging(keyword, startRow, endRow);
		
		ArrayList<Notice> list = noticeService.selectSearchContent(searchpaging);
		
		if(list.size() > 0) {
			model.addAttribute("list", list);
			model.addAttribute("listCount", listCount);
			model.addAttribute("maxPage", maxPage);
			model.addAttribute("currentPage", currentPage);
			model.addAttribute("startPage", startPage);
			model.addAttribute("endPage", endPage);
			model.addAttribute("limit", limit);
			model.addAttribute("action", "content");
			model.addAttribute("keyword", keyword);
			
			return "notice/noticeListView";
		}else {
			model.addAttribute("message", 
					keyword + "로 검색된 공지글 정보가 없습니다.");
			return "common/error";
		}
	}
	
	
	//공지글 상세보기 요청 처리용
	@RequestMapping("ndetail.do")
	public String noticeDetailMethod(
			@RequestParam("notice_num") int notice_num, 
			Model model, HttpSession session) {
		//관리자용 상세보기 페이지와 일반 회원 상세보기 페이지 구분함
		//매개변수에 HttpSession 추가함
		
		Notice notice = noticeService.selectNotice(notice_num);
		noticeService.updateAddReadcount(notice_num); // 상세보기 시 조회수 1 증가 
		
		if(notice != null) {
			model.addAttribute("notice", notice);
			
			Member loginMember = (Member)session.getAttribute("loginMember");
			if(loginMember != null && memberService.selectMember(loginMember.getM_id()).getAdmin().equals("Y")) {
				//관리자가 상세보기를 요청했을 때
				return "notice/noticeAdminDetailView";
			}else {
				return "notice/noticeDetailView";
			}
		}else {
			model.addAttribute("message", 
					notice_num + "번 공지글 상세보기 실패!");
			return "common/error";
		}
		
	}
	
	//공지글 삭제 요청 처리용
	@RequestMapping("ndel.do")
	public String noticeDeleteMethod(
			@RequestParam("notice_num") int notice_num, 
			@RequestParam(name="rfile", required=false) String renameFileName,
			Model model, HttpServletRequest request) {
		
		if(noticeService.deleteNotice(notice_num) > 0) {
			//첨부된 파일이 있는 공지일때는 저장 폴더에 있는
			//첨부파일도 삭제함
			if(renameFileName != null) {
				new File(	request.getSession().getServletContext().getRealPath(
							"resources/notice_upfiles") + "\\" + renameFileName).delete();
			}
			
			return "redirect:nlist.do";
		}else {
			model.addAttribute("message", 
					notice_num + "번 공지 삭제 실패!");
			return "common/error";
		}
	}
	
	//파일업로드 기능이 있는 공지글 등록 요청 처리용
	@RequestMapping(value="ninsert.do", method=RequestMethod.POST)
	public String noticeInsertMethod(Notice notice, Model model, 
			HttpServletRequest request, 
			@RequestParam(name="upfile", required=false) MultipartFile mfile) {
		logger.info("ninsert.do : " + notice);
		
		//업로드된 파일 저장 폴더 지정
		String savePath = request.getSession()
				.getServletContext().getRealPath(
						"resources/notice_upfiles");
		
		if(!mfile.isEmpty()) {
			//전송온 파일이름 추출함
			String fileName = mfile.getOriginalFilename();
			
			if(fileName != null && fileName.length() > 0) {
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
				
				//notice 객체에 첨부파일명 기록 저장하기
				notice.setNotice_original_filename(fileName);
				notice.setNotice_rename_filename(renameFileName);
			}
			
		}  //첨부파일이 있을 때만
		
		if(noticeService.insertNotice(notice) > 0) {
			return "redirect:nlist.do";
		}else {
			model.addAttribute("message", "새 공지글 등록 실패!");
			return "common/error";
		}
	}
	
	//첨부파일 다운로드 요청 처리용
	@RequestMapping("nfdown.do")
	public ModelAndView fileDownMethod(ModelAndView mv, 
  			HttpServletRequest request, 
  			@RequestParam("ofile") String originalFileName,
  			@RequestParam("rfile") String renameFileName) {
  		
  		//공지사항 첨부파일 저장 폴더 경로 지정
  		String savePath = request.getSession()
  				.getServletContext().getRealPath(
  						"resources/notice_upfiles");
  		File renameFile = new File(savePath + "\\" + renameFileName);
  		File originFile = new File(originalFileName);
  		
  		mv.setViewName("filedown");
  		mv.addObject("renameFile", renameFile);
  		mv.addObject("originFile", originFile);
  		
  		return mv;
  	}
	
	//공지글 수정 요청 처리용
	@RequestMapping(value="nupdate.do", method=RequestMethod.POST)
	public String noticeUpdateMethod(Notice notice, Model model, 
			@RequestParam(name="delFlag", required=false) String delFlag,
			@RequestParam(name="upfile", required=false) MultipartFile mfile,
			HttpServletRequest request) {
		
		//공지사항 첨부파일 저장 폴더 경로 지정
		String savePath = request.getSession()
				.getServletContext().getRealPath(
						"resources/notice_upfiles");
		
		
		
		//첨부파일 수정 처리된 경우 --------------------------------
		//1. 원래 첨부파일이 있는데 삭제를 선택한 경우
		if(notice.getNotice_original_filename() != null 
				&& delFlag != null && delFlag.equals("yes")) {
			//저장 폴더에서 파일을 삭제함
			new File(savePath + "\\" + notice.getNotice_rename_filename()).delete();
			//notice 의 파일정보도 제거함
			notice.setNotice_original_filename(null);
			notice.setNotice_rename_filename(null);
		}
		
		//2. 새로운 첨부파일이 있을 때 : 공지글 첨부파일은 1개만 가능한 경우
		if(!mfile.isEmpty()) {
			
			
			//저장 폴더의 이전 파일은 삭제함
			if(notice.getNotice_original_filename() != null) {
				//저장 폴더에서 파일을 삭제함
				new File(savePath + "\\" + notice.getNotice_rename_filename()).delete();
				//notice 의 파일정보도 제거함
				notice.setNotice_original_filename(null);
				notice.setNotice_rename_filename(null);
			}
			
			String fileName = mfile.getOriginalFilename();
			
			if(fileName != null && fileName.length() > 0) {
				SimpleDateFormat sdf = 
						new SimpleDateFormat("yyyyMMddHHmmss");
				String renameFileName = sdf.format(
						new java.sql.Date(System.currentTimeMillis()));
				renameFileName += "." + fileName.substring(fileName.lastIndexOf(".") + 1);
				
				File originFile = new File(savePath + "\\" + fileName);
				File renameFile = new File(savePath + "\\" + renameFileName);
				
				try {
					mfile.transferTo(renameFile);
				} catch (Exception e) {					
					e.printStackTrace();
					model.addAttribute("message", "전송파일 저장 실패!");
					return "common/error";
				} 
				
				//notice 객체에 첨부파일명 기록 저장하기
				notice.setNotice_original_filename(fileName);
				notice.setNotice_rename_filename(renameFileName);
			}  //이름바꾸기해서 저장 처리
			
		}  //새로운 첨부파일이 있을 때만
		
		//-------------------------------------------------------------
		
		if(noticeService.updateNotice(notice) > 0) {
			return "redirect:nlist.do";
		}else {
			model.addAttribute("message", 
					notice.getNotice_num() + "번 공지 수정 실패!");
			return "common/error";
		}
	}
}