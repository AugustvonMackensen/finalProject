package com.andamiro.gammi.gammigroup.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.andamiro.gammi.gammigroup.vo.GammiGroup;
import com.andamiro.gammi.gammigroup.vo.GroupMember;

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

	public GroupMember getGroupMember(GroupMember gm) {
		return session.selectOne("groupMapper.getGroupMember",gm);
	}

	public int getMemberCount(int gno) {
		return session.selectOne("groupMapper.getmemberCount",gno);
	}

	public int createApplication(GroupMember gm) {
		return session.insert("groupMapper.createApplication",gm);
	}

	public ArrayList<GroupMember> getAllGM(int gno) {
		List<GroupMember> list = session.selectList("groupMapper.getAllGM",gno);
		return (ArrayList<GroupMember>)list;
	}

	public int deleteGroupMember(GroupMember gm) {
		return session.delete("groupMapper.deleteGroupMember",gm);
	}

	public int updateGroupMember(GroupMember gm) {
		return session.update("groupMapper.updateGroupMember",gm);
	}
}
