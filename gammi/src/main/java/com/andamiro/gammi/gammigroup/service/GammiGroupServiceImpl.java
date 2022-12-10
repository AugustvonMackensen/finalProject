package com.andamiro.gammi.gammigroup.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.andamiro.gammi.common.Paging;
import com.andamiro.gammi.common.SearchPaging;
import com.andamiro.gammi.gammigroup.dao.GammiGroupDao;
import com.andamiro.gammi.gammigroup.vo.GammiGroup;
import com.andamiro.gammi.gammigroup.vo.GroupMember;

@Service("groupService")
public class GammiGroupServiceImpl implements GammiGroupService{
	
	@Autowired
	private GammiGroupDao dao;

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
	public int acceptGroupMember(GroupMember gm) {
		return dao.acceptGroupMember(gm);
	}

	@Override
	public int refuseGroupMember(GroupMember gm) {
		return dao.refuseGroupMember(gm);
	}

	@Override
	public int selectSearchTListCount(String keyword) {
		return dao.selectSearchTListCount(keyword);
	}

	@Override
	public ArrayList<GammiGroup> selectSearchTitle(SearchPaging searchpaging) {
		return dao.selectSearchTitle(searchpaging);
	}

	@Override
	public int selectListCount() {
		return dao.selectListCount();
	}

	@Override
	public ArrayList<GammiGroup> groupAllList(Paging paging) {
		return dao.groupAllList(paging);
	}

	@Override
	public int selectJoinListCount(String m_id) {
		return dao.selectJoinListCount(m_id);
	}

	@Override
	public ArrayList<GammiGroup> groupJoinAllList(Paging paging) {
		return dao.groupJoinAllList(paging);
	}

	@Override
	public int selectSearchOListCount(String keyword) {
		return dao.selectSearchOListCount(keyword);
	}

	@Override
	public ArrayList<GammiGroup> selectSearchOwner(SearchPaging searchpaging) {
		return dao.selectSearchOwner(searchpaging);
	}

	@Override
	public int deleteGroup(GammiGroup group) {
		return dao.deleteGroup(group);
	}

	@Override
	public int updateGroupok(GammiGroup group) {
		return dao.updateGroupok(group);
	}

	@Override
	public int groupOKCount(String upperCase) {
		return dao.groupOKCount(upperCase);
	}

	@Override
	public ArrayList<GammiGroup> groupOKSearch(SearchPaging searchpaging) {
		return dao.groupOKSearch(searchpaging);
	}

	@Override
	public int admin_groupListCount() {
		return dao.admin_groupListCount();
	}

	@Override
	public ArrayList<GammiGroup> admin_groupList(Paging paging) {
		return dao.admin_groupList(paging);
	}

	@Override
	public int admin_ownerCount(String keyword) {
		return dao.admin_ownerCount(keyword);
	}

	@Override
	public ArrayList<GammiGroup> admin_ownerSearch(SearchPaging searchpaging) {
		return dao.admin_ownerSearch(searchpaging);
	}
	
}
