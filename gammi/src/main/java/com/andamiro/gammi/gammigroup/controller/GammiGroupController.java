package com.andamiro.gammi.gammigroup.controller;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.andamiro.gammi.gammigroup.service.GammiGroupService;
import com.andamiro.gammi.gammigroup.vo.GammiGroup;
import com.andamiro.gammi.gammigroup.vo.GroupMember;
import com.andamiro.gammi.member.vo.Member;

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
						new java.sql.Date(System.currentTimeMillis()));
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
	
	//모임 입장		1)가입여부 확인 1-1)가입되어있다면 내부 입장. 1-2) 미가입시  가입 폼으로 이동
	@RequestMapping(value="selectGroup.do")
	public String moveIntoGroup(@RequestParam("selectGroupNo") String gno, HttpServletRequest request, Model model) {
		HttpSession session = request.getSession();
		Member user = (Member)session.getAttribute("loginMember");
		GroupMember gm = new GroupMember();
		gm.setGroup_no(Integer.parseInt(gno));
		gm.setM_id(user.getM_id());
		
		GammiGroup group = service.selectOneGroup(Integer.parseInt(gno));
		int memberCount = service.getMemberCount(Integer.parseInt(gno));
		GroupMember check = service.getGroupMember(gm);
		
		model.addAttribute("group", group);
		model.addAttribute("memberCount",memberCount);
		model.addAttribute("member", check);
		if(check!=null && check.getMember_grade()>2) {		//가입된 회원
			return "group/groupMain";
		}else {		    	//미가입 회원
			return "group/groupJoinForm";
		}
	}
	
	//가입신청 이후 목록으로 이동
	@RequestMapping(value = "applicationGroup.do", method=RequestMethod.POST)
	public String applicationGroup(GammiGroup group, GroupMember gm, Model model) {
		gm.setGroup_no(group.getGroup_no());
		gm.setMember_grade(1);
		GroupMember check = service.getGroupMember(gm);
		if(check == null) {
			service.createApplication(gm);
			model.addAttribute("message", "가입 신청이 완료 되었습니다.");
		}else {
			model.addAttribute("message", "이미 가입 신청된 그룹입니다.");
		}
		return "common/alert";
	}
	
	//멤버 관리 페이지
	@RequestMapping(value = "groupMemberManagement.do")
	public String groupMemberManagement(@RequestParam("gno") int gno, Model model) {
		ArrayList<GroupMember> gm = service.getAllGM(gno);
		model.addAttribute("gm", gm);
		return "group/memberManagement";
	}
	
	//멤버 가입 수락
		@RequestMapping(value = "mGrade.do", method=RequestMethod.POST)
		@ResponseBody
		public String groupmGrade(@RequestBody String param, HttpServletResponse response) throws ParseException {
			JSONParser jparser = new JSONParser();
			JSONObject job = (JSONObject)jparser.parse(param);
			int state = Integer.parseInt((String)job.get("num"));
			String no = (String)job.get("group_no");
			String id = (String)job.get("m_id");
			GroupMember gm = new GroupMember();
			gm.setGroup_no(Integer.parseInt(no));
			gm.setM_id(id);
			if(state==1) {		//1 수락, 2 거절, 3 추방
				service.acceptGroupMember(gm);
			}else if(state==2) {
				service.refuseGroupMember(gm);
			}else if(state==3) {
				service.deleteGroupMember(gm);
			}
			job = new JSONObject();
			job.put("group_no", Integer.parseInt(no));
			return job.toJSONString();  
		}
	
}
