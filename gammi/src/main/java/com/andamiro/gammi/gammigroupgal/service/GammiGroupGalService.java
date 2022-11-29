package com.andamiro.gammi.gammigroupgal.service;

import java.util.ArrayList;

import com.andamiro.gammi.gammigroup.vo.GroupMember;
import com.andamiro.gammi.gammigroupgal.vo.GalleryImg;
import com.andamiro.gammi.gammigroupgal.vo.GammiGroupGal;

public interface GammiGroupGalService {

	ArrayList<GammiGroupGal> groupAllList(); 	// 갤러리 리스트
	int insertNewGroupGal(GammiGroupGal gammiGroupGal); 	// 갤러리 생성 리스트
	public GammiGroupGal selectgroupgal(int gal_no); // 상세보기
	int updateOrigin(GammiGroupGal gammiGroupGal); // 수정
	GammiGroupGal selectgal(int gal_no);
	int deletegroupgal(int gal_no); // 삭제
	int insertNewGroupGalImg(GalleryImg gal_img);	//이미지테이블 저장
	ArrayList<GalleryImg> selectgal_img(int gal_no);//이미지 가져오기
}