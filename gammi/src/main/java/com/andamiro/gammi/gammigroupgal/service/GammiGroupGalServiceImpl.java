package com.andamiro.gammi.gammigroupgal.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.andamiro.gammi.gammigroup.vo.GammiGroup;
import com.andamiro.gammi.gammigroup.vo.GroupMember;
import com.andamiro.gammi.gammigroupgal.dao.GammiGroupGalDao;
import com.andamiro.gammi.gammigroupgal.vo.GammiGroupGal;



@Service("groupgalService")
public class GammiGroupGalServiceImpl implements GammiGroupGalService {
	
	@Autowired
	private GammiGroupGalDao dao;

	@Override
	public ArrayList<GammiGroupGal> groupAllList() {
		return dao.groupAllList();
	}

	@Override
	public int insertNewGroupGal(GammiGroupGal gammiGroupGal) {
		return dao.insertNewGroupGal(gammiGroupGal);
	}

	@Override
	public GammiGroupGal selectgroupgal(int gal_no) {
		return dao.selectgroupgal(gal_no);
	}

	@Override
	public int updateOrigin(GammiGroupGal gammiGroupGal) {
		return dao.updateOrigin(gammiGroupGal);
	}

	@Override
	public GammiGroupGal selectgal(int gal_no) {
		return dao.selectgal(gal_no);
	}

	@Override
	public int deletegroupgal(int gal_no) {
		return dao.deletegroupgal(gal_no);
	}







}