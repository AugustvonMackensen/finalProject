package com.andamiro.gammi.gammigroupgal.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.andamiro.gammi.gammigroup.vo.GroupMember;
import com.andamiro.gammi.gammigroupgal.vo.GalleryImg;
import com.andamiro.gammi.gammigroupgal.vo.GammiGroupGal;

@Repository("groupgalDao")
public class GammiGroupGalDao {
	@Autowired
	private SqlSessionTemplate session;
	
	public ArrayList<GammiGroupGal> groupAllList() {
		List<GammiGroupGal> list =session.selectList("groupgalMapper.selectAllList"); 
		return (ArrayList<GammiGroupGal>)list;
	}

	public int insertNewGroupGal(GammiGroupGal gammiGroupGal) {
		return session.insert("groupgalMapper.insertGroupGal",gammiGroupGal);
	}

	public GammiGroupGal selectgroupgal(int gal_no) {
		return session.selectOne("groupgalMapper.selectgroupgal", gal_no);
	}

	public int updateOrigin(GammiGroupGal gammiGroupGal) {
		return session.update("groupgalMapper.updategal", gammiGroupGal);
	}

	public GammiGroupGal selectgal(int gal_no) {
		return session.selectOne("groupgalMapper.selectgal", gal_no);
	}

	public int deletegroupgal(int gal_no) {
		return session.delete("groupgalMapper.deletegal", gal_no);
	}

	public int insertNewGroupGalImg(GalleryImg gal_img) {
		return session.insert("groupgalMapper.insertNewImg",gal_img);
	}

	public ArrayList<GalleryImg> selectgal_img(int gal_no) {
		List<GalleryImg> list = session.selectList("groupgalMapper.selectgal_img",gal_no);
		return (ArrayList<GalleryImg>)list;
	}




}
