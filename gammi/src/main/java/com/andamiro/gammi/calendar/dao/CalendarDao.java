package com.andamiro.gammi.calendar.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.andamiro.gammi.calendar.vo.GammiCalendar;

@Repository("calendarDao")
public class CalendarDao {
	@Autowired
	private SqlSessionTemplate session;

	public ArrayList<GammiCalendar> calenList(int gno) {
		try {
		List<GammiCalendar> list = session.selectList("calendarMapper.calenList", gno);
		return (ArrayList<GammiCalendar>)list;
		}catch(Exception e) {
			System.out.println(e);
			return null;
		}
		
	}

	public int saveCal(GammiCalendar cal) {
		int result=0;
		try {
			result = session.insert("calendarMapper.saveCal", cal);
		}catch(Exception e) {
			result= -1;
		}finally {
			return result;
		}
	}

	public int removeCal(GammiCalendar cal) {
		int result=0;
		try {
			result = session.delete("calendarMapper.removeCal", cal);
		}catch(Exception e) {
			result= -1;
		}finally {
			return result;
		}
	}
	
}

	
