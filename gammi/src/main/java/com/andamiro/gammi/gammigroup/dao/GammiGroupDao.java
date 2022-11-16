package com.andamiro.gammi.gammigroup.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.andamiro.gammi.gammigroup.vo.GammiGroup;
import com.andamiro.gammi.gammigroup.vo.GroupMember;
import com.andamiro.gammi.member.vo.Member;

@Repository("groupDao")
public class GammiGroupDao {
	@Autowired
	private SqlSessionTemplate session;

	public ArrayList<GammiGroup> groupAllList() {
		List<GammiGroup> list =session.selectList("groupMapper.selectAllList"); 
		return (ArrayList<GammiGroup>)list;
	}

	public int insertNewGroup(GammiGroup gammiGroup) {
		int result = session.insert("groupMapper.insertGroup",gammiGroup);
		int result2 = session.insert("groupMapper.insertGoupMember",gammiGroup);
		if(result==result2) {
			return result;
		}else {
			return 0;
		}
	}

	public GammiGroup selectOneGroup(int selectGroupNo) {
		return session.selectOne("groupMapper.selectOneGroup",selectGroupNo);
	}

	public int getGroupMember(GroupMember gm) {
		return session.selectOne("groupMapper.getGroupMember",gm);
	}

	public int getMemberCount(int gno) {
		return session.selectOne("groupMapper.getmemberCount",gno);
	}
}
