package com.andamiro.gammi.board.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.andamiro.gammi.board.dao.BoardReplyDao;
import com.andamiro.gammi.board.vo.BoardReply;


@Service("boardreplyService")
public class BoardReplyServiceImpl implements BoardReplyService {
	
	@Autowired
	private BoardReplyDao boardreplyDao;

	@Override
	public ArrayList<BoardReply> replyList(int b_no) {
		return boardreplyDao.replyList(b_no);
	}

	@Override
	public int insertreplyWriter(BoardReply boardreply) {
		return boardreplyDao.insertreplyWriter(boardreply);
	}

	@Override
	public int updatereplyModify(BoardReply boardreply) {
		return boardreplyDao.updatereplyModify(boardreply);
	}

	@Override
	public int replyDelete(int br_no) {
		return boardreplyDao.replyDelete(br_no);
	}

	
}