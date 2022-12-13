package com.andamiro.gammi.gammigroupgal.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.andamiro.gammi.common.Paging;
import com.andamiro.gammi.common.SearchPaging;
import com.andamiro.gammi.gammigroup.vo.GammiGroup;
import com.andamiro.gammi.gammigroup.vo.GroupMember;
import com.andamiro.gammi.gammigroupgal.dao.GammiGroupGalDao;
import com.andamiro.gammi.gammigroupgal.vo.GalleryImg;
import com.andamiro.gammi.gammigroupgal.vo.GammiGroupGal;



@Service("groupgalService")
public class GammiGroupGalServiceImpl implements GammiGroupGalService {
	
	@Autowired
	private GammiGroupGalDao dao;



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

	@Override
	public int insertNewGroupGalImg(GalleryImg gal_img) {
		return dao.insertNewGroupGalImg(gal_img);
	}

	@Override
	public ArrayList<GalleryImg> selectgal_img(int gal_no) {
		return dao.selectgal_img(gal_no);
	}

	@Override
	public int selectListCount(int gno) {
		return dao.selectListCount(gno);
	}

	@Override
	public ArrayList<GammiGroupGal> groupAllList(Paging paging) {
		return dao.groupAllList(paging);
	}

	@Override
	public int deleteGalImg(GalleryImg gal_img) {
		return dao.deleteGalImg(gal_img);
	}

	@Override
	public int selectSearchTListCount(String keyword) {
		return dao.selectSearchTListCount(keyword);
	}

	@Override
	public ArrayList<GammiGroupGal> selectSearchTitle(SearchPaging searchpaging) {
		return dao.selectSearchTitle(searchpaging);
	}

	@Override
	public int selectSearchCListCount(String keyword) {
		return dao.selectSearchCListCount(keyword);
	}

	@Override
	public ArrayList<GammiGroupGal> selectSearchContent(SearchPaging searchpaging) {
		return dao.selectSearchContent(searchpaging);
	}







}
