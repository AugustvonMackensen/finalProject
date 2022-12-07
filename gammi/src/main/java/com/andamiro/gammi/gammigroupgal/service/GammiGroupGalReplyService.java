package com.andamiro.gammi.gammigroupgal.service;

import java.util.ArrayList;

import com.andamiro.gammi.board.vo.BoardReply;
import com.andamiro.gammi.gammigroupgal.vo.GammiGroupGalReply;

public interface GammiGroupGalReplyService {

	ArrayList<GammiGroupGalReply> replyList(int gal_no); // 댓글 목록

	int insertreplyWriter(GammiGroupGalReply groupgalreply); // 댓글 등록

	int updategreplyModify(GammiGroupGalReply groupgalreply); // 댓글 수정

	int greplyDelete(int reply_no);


}
