package com.andamiro.gammi.board.model.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.andamiro.gammi.board.model.dao.BoardDao;
import com.andamiro.gammi.board.model.vo.Board;
import com.andamiro.gammi.common.Paging;
import com.andamiro.gammi.common.SearchDate;
import com.andamiro.gammi.common.SearchPaging;


@Service("boardService")
public class BoardServiceImpl implements BoardService {
	
	@Autowired
	private BoardDao boardDao;
	
	@Override
	public ArrayList<Board> selectAll() {
		return boardDao.selectList();
	}

	@Override
	public Board selectBoard(int b_no) {
		return boardDao.selectOne(b_no);
	}

	@Override
	public int insertBoard(Board board) {
		return boardDao.insertBoard(board);
	}

	@Override
	public int updateBoard(Board board) {
		return boardDao.updateBoard(board);
	}

	@Override
	public int deleteBoard(Board board) {
		return boardDao.delectBoard(board);
	}

	@Override
	public ArrayList<Board> selectNewTop3() {
		return boardDao.selectNewTop3();
	}

	@Override
	public ArrayList<Board> selectList(Paging page) {
		return boardDao.selectList(page);
	}

	@Override
	public int updateAddReadcount(int b_no) {
		return boardDao.updateAddReadcount(b_no);
	}

	@Override
	public int selectListCount() {
		return boardDao.selectListCount();
	}

	@Override
	public int selectSearchTListCount(String keyword) {
		return boardDao.selectSearchTListCount(keyword);
	}

	@Override
	public int selectSearchDListCount(SearchDate date) {
		return boardDao.selectSearchDListCount(date);
	}

	@Override
	public ArrayList<Board> selectSearchTitle(SearchPaging searchpaging) {
		return boardDao.selectSearchTitle(searchpaging);
	}

	@Override
	public ArrayList<Board> selectSearchDate(SearchDate date) {
		return boardDao.selectSearchDate(date);
	}

	@Override
	public ArrayList<Board> selectSearchTitle(String keyword) {
		return boardDao.selectSearchTitle(keyword);
	}

	@Override
	public ArrayList<Board> selectSearchWriter(String keyword) {
		return boardDao.selectSearchWriter(keyword);
	}
	
}
