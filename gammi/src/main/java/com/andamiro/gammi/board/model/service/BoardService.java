package com.andamiro.gammi.board.model.service;

import java.util.ArrayList;

import com.andamiro.gammi.board.model.vo.Board;
import com.andamiro.gammi.common.Paging;
import com.andamiro.gammi.common.SearchDate;
import com.andamiro.gammi.common.SearchPaging;


public interface BoardService {
	ArrayList<Board> selectAll();
	Board selectBoard(int b_no);
	int insertBoard(Board board);
	int updateBoard(Board board);
	int deleteBoard(Board board);
	int updateAddReadcount(int b_no);  //상세보기시에 조회수 1증가 처리용
	int selectListCount();	//총 게시글 갯수 조회용(페이지 수 계산용)
	ArrayList<Board> selectNewTop3();
	ArrayList<Board> selectSearchTitle(SearchPaging searchpaging);
	ArrayList<Board> selectSearchTitle(String keyword);
	ArrayList<Board> selectSearchDate(SearchDate date);
	ArrayList<Board> selectSearchWriter(String keyword);
	ArrayList<Board> selectList(Paging page);  //한 페이지 출력할 자유게시판 조회용
	int selectSearchTListCount(String keyword);
	int selectSearchDListCount(SearchDate date);
	
	
	
	
}