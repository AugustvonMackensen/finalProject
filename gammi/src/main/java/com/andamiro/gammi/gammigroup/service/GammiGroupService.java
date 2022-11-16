package com.andamiro.gammi.gammigroup.service;

import java.util.ArrayList;

import com.andamiro.gammi.gammigroup.vo.GammiGroup;

public interface GammiGroupService {
	public ArrayList<GammiGroup> groupAllList();

	public int insertNewGroup(GammiGroup gammiGroup); 
}
