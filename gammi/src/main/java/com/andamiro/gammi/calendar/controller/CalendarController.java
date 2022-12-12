package com.andamiro.gammi.calendar.controller;

import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.andamiro.gammi.calendar.service.CalendarService;
import com.andamiro.gammi.calendar.vo.GammiCalendar;

@RestController 
public class CalendarController {
	private final Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired
	private CalendarService service;
	
	@RequestMapping("calendarOpen.do")
	public ModelAndView calendarOpen(ModelAndView mv, @RequestParam("gno") int gno) {
		mv.addObject("gno", gno);
		mv.setViewName("group/calendar/gammiCal");
		return mv;
	}
	
	@RequestMapping(value="calGetData.do", method=RequestMethod.POST)
	@ResponseBody
	public JSONObject getDataMethod(@RequestParam("gno") String gno, HttpServletResponse response) throws Exception {
		ArrayList<GammiCalendar> list = service.calenList(Integer.parseInt(gno));
		
		JSONObject json = new JSONObject();
		JSONArray jsonArray = new JSONArray();
		response.setContentType("application/json; charset=utf-8");
		for(GammiCalendar cal : list) {
			JSONObject obj = new JSONObject();
			obj.put("cal_id", cal.getCal_id());
			obj.put("group_no", cal.getGroup_no());
			obj.put("title",  cal.getCal_title());
			obj.put("writer", cal.getCal_writer());
			obj.put("content", cal.getCal_content());
			obj.put("start", cal.getStart_date());
			obj.put("end", cal.getEnd_date());
			obj.put("allday", cal.getAllday());
			jsonArray.add(obj);
		}
		json.put("list", jsonArray);
		logger.info("내용 : " + json.toJSONString());
		return json;
	}
	
	@RequestMapping(value="saveCal.do", method=RequestMethod.POST)
	public ResponseEntity<String> saveCalMethod(@RequestBody String param) throws Exception {
		JSONParser jparser = new JSONParser();
		JSONObject job = (JSONObject)jparser.parse(param);
		GammiCalendar cal = new GammiCalendar();
		cal.setCal_title((String)job.get("title"));
		logger.info((String)job.get("start")+",");
		
	    cal.setDbStart_date((String)job.get("start"));
	    cal.setDbEnd_date((String)job.get("end"));
		
		cal.setAllday((Boolean)job.get("allDaycurrent_data")?1:0);
		cal.setGroup_no(Integer.parseInt((String)job.get("group_no")));
		cal.setCal_writer((String)job.get("cal_writer"));
		if(service.saveCal(cal) > 0)
			return new ResponseEntity<String>("success", HttpStatus.OK);
		else
			return new ResponseEntity<String>("failed", HttpStatus.REQUEST_TIMEOUT);
	}
	@RequestMapping(value="removeCal.do", method=RequestMethod.POST)
	public ResponseEntity<String> removeCalMethod(@RequestBody String param) throws Exception {
		JSONParser jparser = new JSONParser();
		JSONObject job = (JSONObject)jparser.parse(param);
		GammiCalendar cal = new GammiCalendar();
		cal.setCal_id(Integer.parseInt((String)job.get("cal_id")));
		if(service.removeCal(cal) > 0)
			return new ResponseEntity<String>("success", HttpStatus.OK);
		else
			return new ResponseEntity<String>("failed", HttpStatus.REQUEST_TIMEOUT);
	}
}
