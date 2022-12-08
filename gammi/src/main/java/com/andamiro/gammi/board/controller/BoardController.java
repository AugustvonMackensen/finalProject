package com.andamiro.gammi.board.controller;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

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

import com.andamiro.gammi.board.service.BoardReplyService;
import com.andamiro.gammi.board.service.BoardService;
import com.andamiro.gammi.board.vo.Board;
import com.andamiro.gammi.board.vo.BoardReply;
import com.andamiro.gammi.common.Paging;
import com.andamiro.gammi.common.SearchPaging;
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

		int startPage = (currentPage%10==0)? currentPage-9 :  (currentPage / 10) * 10 + 1 ;
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
			logger.info(mfile+"");
			logger.info(delFlag+"");
			logger.info(board+"");
			//게시 원글 첨부파일 저장 폴더 경로 지정
			String savePath = request.getSession().getServletContext().getRealPath("resources/b_upfiles");
			if(board.getB_original_image() != null && delFlag != null && delFlag.equals("yes")) {
				new File(savePath + "\\" + board.getB_rename_image()).delete();
				board.setB_original_image(null);
				board.setB_rename_image(null);
			}
			
			//2. 새로운 첨부파일이 있을 때 : 게시글 첨부파일은 1개만 가능한 경우
			if(!mfile.isEmpty()) {
				if(board.getB_original_image() != null) {
					new File(savePath + "\\" + board.getB_rename_image()).delete();
					board.setB_original_image(null);
					board.setB_rename_image(null);
				}
				
				//이전 첨부파일이 없을 때 --------------------------
				String fileName = mfile.getOriginalFilename();
				
				if(fileName != null && fileName.length() > 0) {
					SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
					String renameFileName = sdf.format(new java.sql.Date(System.currentTimeMillis()));
					renameFileName += "." + fileName.substring(fileName.lastIndexOf(".") + 1);
					
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
				
			}  //새로운 첨부파일이 있을 때만
			
			//-------------------------------------------------------------
			logger.info(board+"");
			if(boardService.updateBoard(board) > 0) {
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
							.getRealPath("resources/b_upfiles")
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
		
		int startPage = (currentPage%10==0)? currentPage-9 :  (currentPage / 10) * 10 + 1 ;
		
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
	
	   //조회순 출력
    @RequestMapping(value="bsearchReadCount.do", method=RequestMethod.GET)
    public String bsearchReadCountMethod(
    		@RequestParam("keyword") String keyword, 
			@RequestParam(name="page", required=false) String page,
			Model model) {
		int currentPage = 1;
		if(page != null) {
			currentPage = Integer.parseInt(page);
		}
		
		int limit = 10;  //한 페이지에 출력할 목록 갯수
		int listCount = boardService.selectListCount();
		int maxPage = (int)((double)listCount / limit + 0.9);
		int startPage = (currentPage%10==0)? currentPage-9 :  (currentPage / 10) * 10 + 1 ;
		int endPage = startPage + 10 - 1;
		if(maxPage < endPage) {
			endPage = maxPage;
		}
		
		int startRow = (currentPage - 1) * limit + 1;
		int endRow = startRow + limit - 1;
		
		SearchPaging searchpaging = new SearchPaging(keyword, startRow, endRow);
		ArrayList<Board> list = boardService.selectSearchCount(searchpaging);
		
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
			return "board/boardListView";
		}else {
			model.addAttribute("message", keyword + "로 검색된 공지글 정보가 없습니다.");
			return "common/error";
		}
	}
	
	
	
    @RequestMapping(value="bsearchWriter.do", method=RequestMethod.GET)
    public String boardSearchWriterMethod(
    		@RequestParam("keyword") String keyword, 
			@RequestParam(name="page", required=false) String page,
			Model model) {
		int currentPage = 1;
		if(page != null) {
			currentPage = Integer.parseInt(page);
		}
		
		
		int limit = 10;  //한 페이지에 출력할 목록 갯수
		
		int listCount = boardService.selectSearchWListCount(keyword);
		
		int maxPage = (int)((double)listCount / limit + 0.9);
		
		int startPage = (currentPage%10==0)? currentPage-9 :  (currentPage / 10) * 10 + 1 ;
		
		int endPage = startPage + 10 - 1;
		
		if(maxPage < endPage) {
			endPage = maxPage;
		}
		
		
		int startRow = (currentPage - 1) * limit + 1;
		int endRow = startRow + limit - 1;
		
		
		SearchPaging searchpaging = new SearchPaging(keyword, startRow, endRow);
		
		ArrayList<Board> list = boardService.selectSearchWriter(searchpaging);
		
		if(list.size() > 0) {
			model.addAttribute("list", list);
			model.addAttribute("listCount", listCount);
			model.addAttribute("maxPage", maxPage);
			model.addAttribute("currentPage", currentPage);
			model.addAttribute("startPage", startPage);
			model.addAttribute("endPage", endPage);
			model.addAttribute("limit", limit);
			model.addAttribute("action", "writer");
			model.addAttribute("keyword", keyword);
			return "board/boardListView";
		}else {
			model.addAttribute("message", keyword + "로 검색된 공지글 정보가 없습니다.");
			return "common/error";
		}
	}
    //게시글 첨부파일 다운로드 처리용
  	@RequestMapping("bfdown.do")
  	public ModelAndView fileDownMethod(ModelAndView mv, 
  			HttpServletRequest request, 
  			@RequestParam("ofile") String originalFileName,
  			@RequestParam("rfile") String renameFileName) {
  		
  		//공지사항 첨부파일 저장 폴더 경로 지정
  		String savePath = request.getSession()
  				.getServletContext().getRealPath(
  						"resources/b_upfiles");
  		File renameFile = new File(savePath + "\\" + renameFileName);
  		File originFile = new File(originalFileName);
  		
  		mv.setViewName("filedown");
  		mv.addObject("renameFile", renameFile);
  		mv.addObject("originFile", originFile);
  		
  		return mv;
  	}
}

