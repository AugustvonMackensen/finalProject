package com.andamiro.gammi.notice.service;

import java.util.ArrayList;

import com.andamiro.gammi.common.Paging;
import com.andamiro.gammi.common.SearchDate;
import com.andamiro.gammi.common.SearchPaging;
import com.andamiro.gammi.notice.vo.Notice;



public interface NoticeService {
	ArrayList<Notice> selectAll();
	Notice selectNotice(int notice_num);
	int insertNotice(Notice notice);
	int updateNotice(Notice notice);
	int deleteNotice(int notice_num);
	int updateAddReadcount(int notice_num);  //상세보기시에 조회수 1증가 처리용
	int selectListCount();	//총 게시글 갯수 조회용(페이지 수 계산용)
	ArrayList<Notice> selectNewTop4();
	ArrayList<Notice> selectSearchTitle(SearchPaging searchpaging);
	ArrayList<Notice> selectList(Paging page);  //한 페이지 출력할 공지사항 조회용
	int selectSearchTListCount(String keyword);
	int selectSearchCListCount(String keyword);
	ArrayList<Notice> selectSearchContent(SearchPaging searchpaging);
	ArrayList<Notice> selectStarlist(Paging paging);

}
