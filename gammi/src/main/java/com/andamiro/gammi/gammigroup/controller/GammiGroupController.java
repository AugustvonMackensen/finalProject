package com.andamiro.gammi.gammigroup.controller;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.andamiro.gammi.gammigroup.service.GammiGroupService;
import com.andamiro.gammi.gammigroup.vo.GammiGroup;

@Controller
public class GammiGroupController {
	private final Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired
	private GammiGroupService service;
	
	//모임 생성 폼으로 이동
	@RequestMapping("creategroupform.do")
	public String moveCreateForm() {
		return "group/createGroupForm";
	}
	
	//모임 전체 목록 페이지
	@RequestMapping("group.do")
	public String groupSearch(Model model) {
		ArrayList<GammiGroup> allList = service.groupAllList();
		if(allList!=null) {
			model.addAttribute("groups",allList);
			model.addAttribute("size", allList.size());
		}else
		{
			model.addAttribute("size",0);
		}
		
		return "group/groupSearch";
	}
	
	//모임 생성
	@RequestMapping(value="groupinsert.do", method=RequestMethod.POST)
	public String groupInsertMethod(GammiGroup gammiGroup, Model model, 
			HttpServletRequest request, @RequestParam(name="upfile", required=false) MultipartFile mfile) {
		
		String savePath = request.getSession()
				.getServletContext().getRealPath(
						"resources/groupImg");
		
		if(!mfile.isEmpty()) {
			String fileName = mfile.getOriginalFilename();
			
			if(fileName != null && fileName.length() > 0) {
				SimpleDateFormat sdf = 
						new SimpleDateFormat("yyyyMMddHHmmss");
				//변경할 파일이름 만들기
				String renameFileName = sdf.format(
						new java.sql.Date(System.currentTimeMillis()))+"_"+gammiGroup.getGroup_name();	
				renameFileName += "." + fileName.substring(fileName.lastIndexOf(".") + 1);
				
				//파일 객체 만들기
				File renameFile = new File(savePath + "\\" + renameFileName);
				
				//업로드된 파일 저장시키고, 바로 이름바꾸기 실행함
				try {
					mfile.transferTo(renameFile);
				} catch (Exception e) {					
					e.printStackTrace();
					model.addAttribute("message", "전송파일 저장 실패!");
					return "common/error";
				} 
				
				gammiGroup.setGroup_img(renameFileName);
			}
		}
		if(service.insertNewGroup(gammiGroup) > 0) {
			return "redirect:group.do";
		}else {
			model.addAttribute("message", "새 게시 원글 등록 실패!");
			return "common/error";
		}
	}
	
	//모임 입장
	@RequestMapping("selectGroup.do")
	public String moveIntoGroup() {
		return "group/groupMain";
	}
}
