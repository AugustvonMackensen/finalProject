package com.andamiro.gammi.gammigroupgal.service;

import java.util.ArrayList;

import com.andamiro.gammi.common.Paging;
import com.andamiro.gammi.common.SearchPaging;
import com.andamiro.gammi.gammigroupgal.vo.GalleryImg;
import com.andamiro.gammi.gammigroupgal.vo.GammiGroupGal;

public interface GammiGroupGalService {

	ArrayList<GammiGroupGal> groupAllList(Paging paging);
	int insertNewGroupGal(GammiGroupGal gammiGroupGal); 	// 갤러리 생성 리스트
	public GammiGroupGal selectgroupgal(int gal_no); // 상세보기
	int updateOrigin(GammiGroupGal gammiGroupGal); // 수정
	GammiGroupGal selectgal(int gal_no);
	int deletegroupgal(int gal_no); // 삭제
	int insertNewGroupGalImg(GalleryImg gal_img);	//이미지테이블 저장
	ArrayList<GalleryImg> selectgal_img(int gal_no);//이미지 가져오기
	int selectListCount();
	int deleteGalImg(GalleryImg gal_img);
	int selectSearchTListCount(String keyword);
	ArrayList<GammiGroupGal> selectSearchTitle(SearchPaging searchpaging);
	int selectSearchCListCount(String keyword);
	ArrayList<GammiGroupGal> selectSearchContent(SearchPaging searchpaging);



	







}