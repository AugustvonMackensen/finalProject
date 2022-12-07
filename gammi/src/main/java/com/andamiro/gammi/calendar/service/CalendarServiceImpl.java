package com.andamiro.gammi.calendar.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.andamiro.gammi.calendar.dao.CalendarDao;
import com.andamiro.gammi.calendar.vo.GammiCalendar;

@Service("calendarService")
public class CalendarServiceImpl implements CalendarService{

	@Autowired
	private CalendarDao dao;
	
	public ArrayList<GammiCalendar> calenList(int gno) {
		return dao.calenList(gno);
	}

}
