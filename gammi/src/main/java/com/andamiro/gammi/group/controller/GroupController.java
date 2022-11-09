package com.andamiro.gammi.group.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class GroupController {
	private final Logger logger = LoggerFactory.getLogger(getClass());
	
	@RequestMapping("group.do")
	public String groupSearch() {
		return "group/groupSearch";
	}
}
