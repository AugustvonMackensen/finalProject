package com.andamiro.gammi.board.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.andamiro.gammi.board.dao.BoardDao;
import com.andamiro.gammi.board.vo.Board;
import com.andamiro.gammi.common.Paging;
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
	public ArrayList<Board> selectSearchTitle(SearchPaging searchpaging) {
		return boardDao.selectSearchTitle(searchpaging);
	}

	@Override
	public int selectSearchWListCount(String keyword) {
		return boardDao.selectSearchWListCount(keyword);
	}

	@Override
	public ArrayList<Board> selectSearchWriter(SearchPaging searchpaging) {
		return boardDao.selectSearchWriter(searchpaging);
	}

	@Override
	public ArrayList<Board> selectNewTop4() {
		return boardDao.selectNewTop4();
	}

	@Override
	public ArrayList<Board> selectSearchCount(SearchPaging searchpaging) {
		return boardDao.selectSearchCount(searchpaging);
	}
	
}
