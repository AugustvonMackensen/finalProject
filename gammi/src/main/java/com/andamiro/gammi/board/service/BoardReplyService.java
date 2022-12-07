package com.andamiro.gammi.board.service;

import java.util.ArrayList;

import com.andamiro.gammi.board.vo.BoardReply;

public interface BoardReplyService {
	
	ArrayList<BoardReply> replyList(int b_no); // 댓글 등록
	int insertreplyWriter(BoardReply boardreply); // 댓글 등록
	int updatereplyModify(BoardReply boardreply); // 댓글 수정
	int replyDelete(int br_no); // 댓글 삭제

}