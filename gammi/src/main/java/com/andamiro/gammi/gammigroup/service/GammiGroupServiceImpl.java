package com.andamiro.gammi.gammigroup.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.andamiro.gammi.gammigroup.dao.GammiGroupDao;
import com.andamiro.gammi.gammigroup.vo.GammiGroup;
import com.andamiro.gammi.gammigroup.vo.GroupMember;

@Service("groupService")
public class GammiGroupServiceImpl implements GammiGroupService{
	
	@Autowired
	private GammiGroupDao dao;
	
	@Override
	public ArrayList<GammiGroup> groupAllList() {
		return dao.groupAllList();
	}

	@Override
	public int insertNewGroup(GammiGroup gammiGroup) {
		return dao.insertNewGroup(gammiGroup);
	}

	@Override
	public GammiGroup selectOneGroup(int selectGroupNo) {
		return dao.selectOneGroup(selectGroupNo);
	}

	@Override
	public GroupMember getGroupMember(GroupMember gm) {
		return dao.getGroupMember(gm);
	}

	@Override
	public int getMemberCount(int gno) {
		return dao.getMemberCount(gno);
	}

	@Override
	public int createApplication(GroupMember gm) {
		return dao.createApplication(gm);
	}

	@Override
	public ArrayList<GroupMember> getAllGM(int gno) {
		return dao.getAllGM(gno);
	}

	@Override
	public int deleteGroupMember(GroupMember gm) {
		return dao.deleteGroupMember(gm);
	}

	@Override
	public int updateGroupMember(GroupMember gm) {
		// TODO Auto-generated method stub
		return dao.updateGroupMember(gm);
	}
	
}
