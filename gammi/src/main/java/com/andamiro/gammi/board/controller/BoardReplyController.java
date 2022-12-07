package com.andamiro.gammi.board.controller;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.andamiro.gammi.board.service.BoardReplyService;
import com.andamiro.gammi.board.vo.BoardReply;

@Controller
	public class BoardReplyController {
		private static final Logger logger = 
				LoggerFactory.getLogger(BoardReplyController.class);
			
		@Autowired
		private BoardReplyService boardreplyService;
		
		
		@RequestMapping(value="breply.do", method=RequestMethod.GET)
		public String insertreplyWriter(HttpServletRequest request, 
				@RequestParam("page") int page, Model model) {
			BoardReply boardreply = new BoardReply();
			boardreply.setBr_content(request.getParameter("br_content"));
			boardreply.setB_no(Integer.parseInt(request.getParameter("b_no")));
			boardreply.setBr_id(request.getParameter("br_id"));
					
			if(boardreplyService.insertreplyWriter(boardreply) > 0) {
				return "redirect:bdetail.do?b_no=" + boardreply.getB_no() + "&page=" + page; 
			}else {
				model.addAttribute("message", boardreply.getB_no() + "번 댓글 등록 실패");
				return "common/error";
			}
		}
		
		//댓글 수정 처리용
		@RequestMapping(value="replyup.do", method=RequestMethod.POST)
		public String updatereplyModify(BoardReply boardreply, @RequestParam("page") int page, Model model) {
			if(boardreplyService.updatereplyModify(boardreply) > 0) {
				//댓글 수정 성공시 다시 상세페이지가 보여지게 한다면
				
				return "redirect:bdetail.do?b_no=" + boardreply.getB_no() + "&page=" + page; 
			}else {
				model.addAttribute("message", boardreply.getBr_no() + "번 글 수정 실패");
				return "common/error";
			}
		}
		
		@RequestMapping("replydel.do")
		public String replyDelete(@RequestParam("br_no") int br_no, @RequestParam("b_no") int b_no, 
		@RequestParam("page") int page, Model model) {
			
			if(boardreplyService.replyDelete(br_no) > 0) {
				return "redirect:bdetail.do?b_no=" + b_no + "&page=" + page; 
			}else {
				model.addAttribute("message", br_no + "번 글 삭제 실패");
				return "common/error";
			}
		}
	}
		


