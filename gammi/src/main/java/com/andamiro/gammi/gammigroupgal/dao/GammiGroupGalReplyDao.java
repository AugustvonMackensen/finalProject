package com.andamiro.gammi.gammigroupgal.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.andamiro.gammi.gammigroupgal.vo.GammiGroupGalReply;

@Repository("groupgalreplyDao")
public class GammiGroupGalReplyDao {
	@Autowired
	private SqlSessionTemplate session;

	public ArrayList<GammiGroupGalReply> replyList(int gal_no) {
		List<GammiGroupGalReply> list = session.selectList("groupgalreplyMapper.selectGroupGalReply", gal_no);
		return (ArrayList<GammiGroupGalReply>)list;
	}

	public int insertreplyWriter(GammiGroupGalReply groupgalreply) {
		return session.insert("groupgalreplyMapper.replyWrite", groupgalreply);
	}

	public int updategreplyModify(GammiGroupGalReply groupgalreply) {
		return session.update("groupgalreplyMapper.greplyModify",groupgalreply);
	}

	public int greplyDelete(int reply_no) {
		return session.delete("groupgalreplyMapper.greplyDelete", reply_no);
	}
}
