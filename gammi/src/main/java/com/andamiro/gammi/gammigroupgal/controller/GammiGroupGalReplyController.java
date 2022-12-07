package com.andamiro.gammi.gammigroupgal.controller;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.andamiro.gammi.board.controller.BoardReplyController;
import com.andamiro.gammi.board.vo.BoardReply;
import com.andamiro.gammi.gammigroupgal.service.GammiGroupGalReplyService;
import com.andamiro.gammi.gammigroupgal.vo.GammiGroupGalReply;


@Controller
public class GammiGroupGalReplyController {
	private static final Logger logger = 
			LoggerFactory.getLogger(BoardReplyController.class);
	
	@Autowired
	private GammiGroupGalReplyService service;
	
	@RequestMapping(value="greply.do", method=RequestMethod.GET)
	public String insertgreplyWriter(HttpServletRequest request, 
			@RequestParam("page") int page, Model model) {
		GammiGroupGalReply groupgalreply = new GammiGroupGalReply();
		groupgalreply.setReply_content(request.getParameter("reply_content"));
		groupgalreply.setGal_no(Integer.parseInt(request.getParameter("gal_no")));
		groupgalreply.setReply_id(request.getParameter("reply_id"));
				
		if(service.insertreplyWriter(groupgalreply) > 0) {
			return "redirect:groupgaldetail.do?gal_no=" + groupgalreply.getGal_no() + "&page=" + page; 
		}else {
			model.addAttribute("message", groupgalreply.getGal_no() + "번 댓글 등록 실패");
			return "common/error";
		}
	}
	
	//댓글 수정 처리용
	@RequestMapping(value="greplyup.do", method=RequestMethod.POST)
	public String updategreplyModify(GammiGroupGalReply groupgalreply, @RequestParam("page") int page, Model model) {
		if(service.updategreplyModify(groupgalreply) > 0) {
			//댓글 수정 성공시 다시 상세페이지가 보여지게 한다면
			return "redirect:groupgaldetail.do?gal_no=" + groupgalreply.getGal_no() + "&page=" + page; 
		}else {
			model.addAttribute("message", groupgalreply.getReply_no() + "번 글 수정 실패");
			return "common/error";
		}
	}
	
	@RequestMapping("greplydel.do")
	public String replyDelete(@RequestParam("reply_no") int reply_no, @RequestParam("gal_no") int gal_no, 
	@RequestParam("page") int page, Model model) {
		
		if(service.greplyDelete(reply_no) > 0) {
			return "redirect:groupgaldetail.do?gal_no=" + gal_no + "&page=" + page; 
		}else {
			model.addAttribute("message", reply_no + "번 글 삭제 실패");
			return "common/error";
		}
	}
}
