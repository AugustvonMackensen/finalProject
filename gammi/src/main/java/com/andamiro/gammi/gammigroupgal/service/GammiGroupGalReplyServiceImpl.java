package com.andamiro.gammi.gammigroupgal.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.andamiro.gammi.gammigroupgal.dao.GammiGroupGalReplyDao;
import com.andamiro.gammi.gammigroupgal.vo.GammiGroupGalReply;




@Service("groupgalReplyService")
public class GammiGroupGalReplyServiceImpl implements GammiGroupGalReplyService {
	@Autowired
	private GammiGroupGalReplyDao dao;
	
	
	@Override
	public ArrayList<GammiGroupGalReply> replyList(int gal_no) {
		return dao.replyList(gal_no);
	}


	@Override
	public int insertreplyWriter(GammiGroupGalReply groupgalreply) {
		return dao.insertreplyWriter(groupgalreply);
	}


	@Override
	public int updategreplyModify(GammiGroupGalReply groupgalreply) {
		return dao.updategreplyModify(groupgalreply);
	}


	@Override
	public int greplyDelete(int reply_no) {
		return dao.greplyDelete(reply_no);
	}



}
