package com.andamiro.gammi.board.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.andamiro.gammi.board.vo.BoardReply;

@Repository("boardreplyDao")
public class BoardReplyDao {
	@Autowired
	private SqlSessionTemplate session;


	public int insertreplyWriter(BoardReply boardreply) {
		return session.insert("boardreplyMapper.replyWrite", boardreply);
	}

	public int updatereplyModify(BoardReply boardreply) {
		return session.update("boardreplyMapper.replyModify", boardreply);
	}

	public int replyDelete(int br_no) {
		return session.delete("boardreplyMapper.replyDelete", br_no);
	}

	public ArrayList<BoardReply> replyList(int b_no) {
		List<BoardReply> list = session.selectList("boardreplyMapper.selectBoardReply", b_no);
		return (ArrayList<BoardReply>)list;
	}

}
