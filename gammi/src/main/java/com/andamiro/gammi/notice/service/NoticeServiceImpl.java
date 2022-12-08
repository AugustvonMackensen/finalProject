package com.andamiro.gammi.notice.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.andamiro.gammi.common.Paging;
import com.andamiro.gammi.common.SearchDate;
import com.andamiro.gammi.common.SearchPaging;
import com.andamiro.gammi.notice.dao.NoticeDao;
import com.andamiro.gammi.notice.vo.Notice;



@Service("noticeService")
public class NoticeServiceImpl implements NoticeService {
	
	@Autowired
	private NoticeDao noticeDao;
	
	@Override
	public ArrayList<Notice> selectAll() {
		return noticeDao.selectList();
	}

	@Override
	public Notice selectNotice(int notice_num) {
		return noticeDao.selectOne(notice_num);
	}

	@Override
	public int insertNotice(Notice notice) {
		return noticeDao.insertNotice(notice);
	}

	@Override
	public int updateNotice(Notice notice) {
		return noticeDao.updateNotice(notice);
	}

	@Override
	public int deleteNotice(int notice_num) {
		return noticeDao.delectNotice(notice_num);
	}

	@Override
	public ArrayList<Notice> selectNewTop4() {
		return noticeDao.selectNewTop4();
	}

	@Override
	public ArrayList<Notice> selectList(Paging page) {
		return noticeDao.selectList(page);
	}

	@Override
	public int updateAddReadcount(int notice_num) {
		return noticeDao.updateAddReadcount(notice_num);
	}

	@Override
	public int selectListCount() {
		return noticeDao.selectListCount();
	}

	@Override
	public int selectSearchTListCount(String keyword) {
		return noticeDao.selectSearchTListCount(keyword);
	}

	@Override
	public ArrayList<Notice> selectSearchTitle(SearchPaging searchpaging) {
		return noticeDao.selectSearchTitle(searchpaging);
	}

	@Override
	public int selectSearchCListCount(String keyword) {
		return noticeDao.selectSearchCListCount(keyword);
	}

	@Override
	public ArrayList<Notice> selectSearchContent(SearchPaging searchpaging) {
		return noticeDao.selectSearchContent(searchpaging);
	}

	@Override
	public ArrayList<Notice> selectStarlist(Paging paging) {
		return noticeDao.selectStarlist(paging);
	}


	@Override
	public ArrayList<Notice> selectSearchReadcount(SearchPaging searchpaging) {
		return noticeDao.selectSearchReadcount(searchpaging);
	}
	
}
