package com.andamiro.gammi.gammigroup.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.andamiro.gammi.gammigroup.dao.GammiGroupDao;
import com.andamiro.gammi.gammigroup.vo.GammiGroup;

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
	
}
