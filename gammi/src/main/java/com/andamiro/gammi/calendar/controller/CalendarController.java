package com.andamiro.gammi.calendar.controller;

import java.util.ArrayList;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.andamiro.gammi.calendar.service.CalendarService;
import com.andamiro.gammi.calendar.vo.GammiCalendar;

@Controller
public class CalendarController {
	private final Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired
	private CalendarService service;
	
	@RequestMapping("calendarOpen.do")
	public String calendarOpen(Model model, @RequestParam("gno") int gno) {
		logger.info("gno : " + gno);
		ArrayList<GammiCalendar> list = service.calenList(gno);
		model.addAttribute("list",list);
		return "group/calendar/gammiCal";
	}
	
}
