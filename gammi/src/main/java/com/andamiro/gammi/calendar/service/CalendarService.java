package com.andamiro.gammi.calendar.service;

import java.util.ArrayList;

import com.andamiro.gammi.calendar.vo.GammiCalendar;

public interface CalendarService {

	public ArrayList<GammiCalendar> calenList(int gno);

	public int saveCal(GammiCalendar cal);

	public int removeCal(GammiCalendar cal);

}
