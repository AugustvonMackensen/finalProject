package com.andamiro.gammi.board.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.andamiro.gammi.board.model.vo.Board;
import com.andamiro.gammi.common.Paging;
import com.andamiro.gammi.common.SearchDate;
import com.andamiro.gammi.common.SearchPaging;

@Repository("boardDao")
public class BoardDao {
	//스프링-마이바티스 연동 객체 사용 : root-context.xml 에 있음
	
	@Autowired
	private SqlSessionTemplate session;
	
	public ArrayList<Board> selectNewTop3(){
		List<Board> list = session.selectList("boardMapper.selectNewTop3");
		return (ArrayList<Board>)list;
	}
	
	public ArrayList<Board> selectList(){
		List<Board> list = session.selectList("boardMapper.selectAll");
		return (ArrayList<Board>)list;
	}
	
	public ArrayList<Board> selectSearchTitle(SearchPaging searchpaging){
		List<Board> list = session.selectList("boardMapper.searchTitle", searchpaging);
		return (ArrayList<Board>)list;
	}
	
	public ArrayList<Board> selectSearchDate(SearchPaging searchpaging){
		List<Board> list = session.selectList("boardMapper.searchDate", searchpaging);
		return (ArrayList<Board>)list;
	}
	
	// 상세보기용 공지글 하나 조회
	public Board selectOne(int b_no) {
		return session.selectOne("boardMapper.selectBoard", b_no);
	}
	
	//공지글 삭제 처리
	public int delectBoard(Board board) {
		return session.delete("boardMapper.deleteboard", board);
	}
	
	//새 공지글 등록 처리
	public int insertBoard(Board board) {
		return session.insert("boardMapper.insertOrigin", board);
	}
	
	//기존 공지글 수정 처리
	public int updateBoard(Board board) {
		return session.update("boardMapper.updateOrigin", board);
	}
	
	// 페이징 부분
	public ArrayList<Board> selectList(Paging page) {
		List<Board> list = session.selectList("boardMapper.selectList", page);
		return (ArrayList<Board>)list;
	}

	public int updateAddReadcount(int b_no) {
		return session.update("boardMapper.addReadCount", b_no);
	}

	public int selectListCount() {
		return session.selectOne("boardMapper.getListCount");
	}

	public int selectSearchTListCount(String keyword) {
		return session.selectOne("boardMapper.getSearchTListCount", keyword);
	}

	public int selectSearchDListCount(SearchDate date) {
		return session.selectOne("boardMapper.getSearchDListCount", date);
	}

	public ArrayList<Board> selectSearchDate(SearchDate date) {
		return session.selectOne("boardMapper.getSearchDListCount", date);
	}

	public ArrayList<Board> selectSearchTitle(String keyword) {
		return session.selectOne("boardMapper.searchTitle", keyword);
	}

	public ArrayList<Board> selectSearchWriter(String keyword) {
		return session.selectOne("boardMapper.getSearchWListCount", keyword);
	}

	

}