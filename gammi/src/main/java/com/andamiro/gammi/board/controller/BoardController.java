package com.andamiro.gammi.board.controller;

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

import com.andamiro.gammi.board.model.service.BoardReplyService;
import com.andamiro.gammi.board.model.service.BoardService;
import com.andamiro.gammi.board.model.vo.Board;
import com.andamiro.gammi.board.model.vo.BoardReply;
import com.andamiro.gammi.common.Paging;
import com.andamiro.gammi.common.SearchDate;
import com.andamiro.gammi.common.SearchPaging;
import com.andamiro.gammi.member.vo.Member;
import com.andamiro.gammi.notice.vo.Notice;


@Controller
public class BoardController {
	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);
	
	@Autowired
	private BoardService boardService;
	@Autowired
	private BoardReplyService boardreplyService;
	
	@RequestMapping("ListView.do")
	public ModelAndView boardListMethod(
			@RequestParam(name="page", required=false) String page,
			ModelAndView mv) {
		
		int currentPage = 1;
		if(page != null) {
			currentPage = Integer.parseInt(page);
		}
		
		

		int limit = 10;  
		int listCount = boardService.selectListCount();

		int maxPage = (int)((double)listCount / limit + 0.9);

		int startPage = (currentPage / 10) * 10 + 1;
		int endPage = startPage + 10 - 1;
		
		if(maxPage < endPage) {
			endPage = maxPage;
		}
		
		int startRow = (currentPage - 1) * limit + 1;
		int endRow = startRow + limit - 1;
		Paging paging = new Paging(startRow, endRow);
		
		//페이징 계산 처리 끝 ---------------------------------------
		
		ArrayList<Board> list = boardService.selectList(paging);
		
		if(list != null && list.size() > 0) {
			mv.addObject("list", list);
			mv.addObject("listCount", listCount);
			mv.addObject("maxPage", maxPage);
			mv.addObject("currentPage", currentPage);
			mv.addObject("startPage", startPage);
			mv.addObject("endPage", endPage);
			mv.addObject("limit", limit);
			
			mv.setViewName("board/boardListView");
		}else {
			mv.addObject("message", 
					currentPage + " 페이지 목록 조회 실패.");
			mv.setViewName("common/error");
		}
		logger.info(list + "여기");
		return mv;
	}
	
//	// 상세보기 페이지 이동
//	@RequestMapping("bdetail.do")
//	public String moveLoginPage() {
//		return "board/boardDetailView";
//	}
	
	// 게시글 상세보기 처리용
	@RequestMapping("bdetail.do")
	public ModelAndView boardDetailMethod(ModelAndView mv,
			@RequestParam("b_no") int b_no,
			@RequestParam(name="page", required=false) String page) {
		int currentPage = 1;
		if(page != null) {
			currentPage = Integer.parseInt(page);
		}
		
		
			
		
		
		// 조회수 1증가 처리
		boardService.updateAddReadcount(b_no);
		
		//해당 게시글 조회
		Board board = boardService.selectBoard(b_no);
		ArrayList<BoardReply> replylist = boardreplyService.replyList(b_no); 

		
		if(board !=null) {

			mv.addObject("board", board);
			mv.addObject("currentPage", currentPage);
			mv.addObject("replylist", replylist);
			mv.setViewName("board/boardDetailView"); //디테일만 바꿈
			
		}else {
			mv.addObject("message", 
					b_no + "번 게시글 조회 실패");
			mv.setViewName("common/error");
		}
		return mv;
	}
	
	//게시 원글 쓰기 페이지로 이동 처리용
		@RequestMapping("bwform.do")
		public String moveBoardWriteForm() {
			return "board/boardWriteForm";
		}
		
		//게시 원글 등록 처리용 : 파일 첨부(업로드) 기능 있음
		@RequestMapping(value="bwinsert.do", method=RequestMethod.POST)
		public String qwInsertMethod(Board board, Model model, 
				HttpServletRequest request, 
				@RequestParam(name="upfile", required=false) MultipartFile mfile) {
			logger.info("bwinsert.do : " + mfile);
			
			//업로드된 파일 저장 폴더 지정
			String savePath = request.getSession()
					.getServletContext().getRealPath(
							"resources/b_upfiles");
			
			//첨부파일이 있을 때만 업로드된 파일을 지정된 폴더로 옮기기
			if(!mfile.isEmpty()) {
				//전송온 파일이름 추출함
				String fileName = mfile.getOriginalFilename();
				
				//다른 공지글의 첨부파일과
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
					
	
					board.setB_original_image(fileName);
					board.setB_rename_image(renameFileName);
				}
				
			}  //첨부파일이 있을 때만
			
			if(boardService.insertBoard(board) > 0) {
				return "redirect:ListView.do";
			}else {
				model.addAttribute("message", "새 게시 원글 등록 실패!");
				return "common/error";
			}
		}
	
		@RequestMapping("bmoveup.do")
		public String moveBoardUpdateView(
				@RequestParam("b_no") int b_no,
				
				Model model) {
			//수정페이지로 보낼 Board 객체 정보 조회함
			Board board = boardService.selectBoard(b_no);
			if(board != null) {
				model.addAttribute("board", board);
				
				return "board/boardUpdateForm";
			}else {
				model.addAttribute("message", 
						b_no + "번 글 수정페이지로 이동 실패");
				return "common/error";
			}
		}
		
		//게시 원글 수정 요청 처리용
		@RequestMapping(value="bup.do", method=RequestMethod.POST)
		public String boardUpdateMethod(
				Board board, Model model, 
				
				@RequestParam(name="delFlag", required=false) String delFlag,
				@RequestParam(name="upfile", required=false) MultipartFile mfile,
				HttpServletRequest request) {
			
			//게시 원글 첨부파일 저장 폴더 경로 지정
			String savePath = request.getSession()
					.getServletContext().getRealPath(
							"resources/b_reupfiles");
			
			//첨부파일 수정 처리된 경우 --------------------------------
			//1. 원래 첨부파일이 있는데 삭제를 선택한 경우
			if(board.getB_original_image() != null 
					&& delFlag != null && delFlag.equals("yes")) {
				//저장 폴더에서 파일을 삭제함
				new File(savePath + "\\" + board.getB_rename_image()).delete();
				//board 의 파일정보도 제거함
				board.setB_original_image(null);
				board.setB_rename_image(null);
			}
			
			//2. 새로운 첨부파일이 있을 때 : 게시글 첨부파일은 1개만 가능한 경우
			if(!mfile.isEmpty()) {
				//저장 폴더의 이전 파일은 삭제함
				if(board.getB_original_image() != null) {
					//저장 폴더에서 파일을 삭제함
					new File(savePath + "\\" + board.getB_rename_image()).delete();
					//board 의 파일정보도 제거함
					board.setB_original_image(null);
					board.setB_rename_image(null);
				}
				
				//이전 첨부파일이 없을 때 --------------------------
				//전송온 파일이름 추출함
				String fileName = mfile.getOriginalFilename();
				
				//다른 공지글의 첨부파일과
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
					
					//board 객체에 첨부파일명 기록 저장하기
					board.setB_original_image(fileName);
					board.setB_rename_image(renameFileName);
				}  //이름바꾸기해서 저장 처리
				
			}  //새로운 첨부파일이 있을 때만
			
			//-------------------------------------------------------------
			
			if(boardService.updateBoard(board) > 0) {
				//원글 수정 성공시 상세보기 페이지를 내보낸다면
				
				model.addAttribute("b_no", board.getB_no());
				return "redirect:bdetail.do";
			}else {
				model.addAttribute("message", 
						board.getB_no() + "번 게시 원글 수정 실패!");
				return "common/error";
			}
		}
		//게시글 삭제
		@RequestMapping("bdel.do")
		public String questionDeleteMethod(Board board,
				HttpServletRequest request, Model model) {
			
			if(boardService.deleteBoard(board) > 0) {
				//글삭제가 성공하면, 저장폴더에 첨부파일도 삭제 처리
				if(board.getB_rename_image() != null) {
					new File(request.getSession()
							.getServletContext()
							.getRealPath("resources/board_upfiles")
							+ "\\" + board.getB_rename_image()).delete();
				}
				
				return "redirect:ListView.do?page=1";
			}else {
				model.addAttribute("message", 
						board.getB_no() + "번 글 삭제 실패");
				return "common/error";
			}
		}

	//공지글 제목 검색용
	@RequestMapping(value="bsearchTitle.do", method=RequestMethod.GET)
	public String boardSearchTitleMethod(
			@RequestParam("keyword") String keyword, 
			@RequestParam(name="page", required=false) String page,
			Model model) {
		int currentPage = 1;
		if(page != null) {
			currentPage = Integer.parseInt(page);
		}
		
		
		int limit = 10;  //한 페이지에 출력할 목록 갯수
		
		int listCount = boardService.selectSearchTListCount(keyword);
		
		int maxPage = (int)((double)listCount / limit + 0.9);
		
		int startPage = (currentPage / 10) * 10 + 1;
		
		int endPage = startPage + 10 - 1;
		
		if(maxPage < endPage) {
			endPage = maxPage;
		}
		
		
		int startRow = (currentPage - 1) * limit + 1;
		int endRow = startRow + limit - 1;
		
		
		SearchPaging searchpaging = new SearchPaging(keyword, startRow, endRow);
		
		ArrayList<Board> list = boardService.selectSearchTitle(searchpaging);
		
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
			return "board/boardListView";
		}else {
			model.addAttribute("message", 
					keyword + "로 검색된 공지글 정보가 없습니다.");
			return "common/error";
		}
	}

	
	   //공지글 작성자 검색용
    @RequestMapping(value="bsearchWriter.do", method=RequestMethod.GET)
    public String boardSearchWriterMethod(
          @RequestParam("keyword") String keyword, Model model) {
       ArrayList<Board> list = boardService.selectSearchWriter(keyword);
       
       if(list.size() > 0) {
          model.addAttribute("list", list);
          return "board/boardListView";
       }else {
          model.addAttribute("message", 
                keyword + "로 검색된 공지글 정보가 없습니다.");
          return "common/error";
       }
    }
	
	
	
		
	
	
	
}

