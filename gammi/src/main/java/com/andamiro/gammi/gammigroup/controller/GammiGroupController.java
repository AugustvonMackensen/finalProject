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
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.andamiro.gammi.common.Paging;
import com.andamiro.gammi.common.SearchPaging;
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
	public String groupSearch(@RequestParam(name="page", required=false) String page, 
			Model model) {
		
		int currentPage = 1;
		if(page != null) {
			currentPage = Integer.parseInt(page);
		}
		int limit = 10;
		int listCount = service.selectListCount();
		int maxPage = (int)((double)listCount / limit + 0.9);
		int startPage = (currentPage%10==0)? currentPage-9 :  (currentPage / 10) * 10 + 1 ;
		int endPage = startPage + 10 - 1;
		if(maxPage < endPage) {
			endPage = maxPage;
		}
		int startRow = (currentPage - 1) * limit + 1;
		int endRow = startRow + limit - 1;
		Paging paging = new Paging(startRow, endRow);
		
		ArrayList<GammiGroup> list = service.groupAllList(paging);
		if(list != null) {
			model.addAttribute("groups", list);
			model.addAttribute("listCount", listCount);
			model.addAttribute("maxPage", maxPage);
			model.addAttribute("currentPage", currentPage);
			model.addAttribute("startPage", startPage);
			model.addAttribute("endPage", endPage);
			model.addAttribute("limit", limit);
		}
		return "group/groupSearch";
	}
	//가입된 모임 페이지
	@RequestMapping("joinGroup.do")
	public String joinGroup(@RequestParam(name="page", required=false) String page, 
			Model model, HttpServletRequest request) {
		HttpSession session = request.getSession();
		Member user = (Member)session.getAttribute("loginMember");
		int currentPage = 1;
		if(page != null) {
			currentPage = Integer.parseInt(page);
		}
		int limit = 10;
		int listCount = service.selectJoinListCount(user.getM_id());
		int maxPage = (int)((double)listCount / limit + 0.9);
		int startPage = (currentPage%10==0)? currentPage-9 :  (currentPage / 10) * 10 + 1 ;
		int endPage = startPage + 10 - 1;
		if(maxPage < endPage) {
			endPage = maxPage;
		}
		
		int startRow = (currentPage - 1) * limit + 1;
		int endRow = startRow + limit - 1;
		Paging paging = new Paging(startRow, endRow, user.getM_id());
		
		ArrayList<GammiGroup> list = service.groupJoinAllList(paging);
		if(list != null) {
			model.addAttribute("groups", list);
			model.addAttribute("listCount", listCount);
			model.addAttribute("maxPage", maxPage);
			model.addAttribute("currentPage", currentPage);
			model.addAttribute("startPage", startPage);
			model.addAttribute("endPage", endPage);
			model.addAttribute("limit", limit);
		}
		return "group/groupSearch";
	}
	
	//모임 검색용
	@RequestMapping(value="groupsearchTitle.do")
	public String groupSearchNameMethod(@RequestParam("keyword") String keyword, 
			@RequestParam(name="page", required=false) String page,
			Model model) {
		int currentPage = 1;
		if(page != null) {
			currentPage = Integer.parseInt(page);
		}
		int limit = 10;
		int listCount = service.selectSearchTListCount(keyword);
		int maxPage = (int)((double)listCount / limit + 0.9);
		int startPage = (currentPage%10==0)? currentPage-9 :  (currentPage / 10) * 10 + 1 ;
		int endPage = startPage + 10 - 1;
		if(maxPage < endPage) {
			endPage = maxPage;
		}
		int startRow = (currentPage - 1) * limit + 1;
		int endRow = startRow + limit - 1;
		SearchPaging searchpaging = new SearchPaging(keyword, startRow, endRow);
		
		ArrayList<GammiGroup> list = service.selectSearchTitle(searchpaging);
		if(list != null) {
			model.addAttribute("groups", list);
			model.addAttribute("listCount", listCount);
			model.addAttribute("maxPage", maxPage);
			model.addAttribute("currentPage", currentPage);
			model.addAttribute("startPage", startPage);
			model.addAttribute("endPage", endPage);
			model.addAttribute("limit", limit);
			model.addAttribute("action", "title");
			model.addAttribute("keyword", keyword);
		}
		return "group/groupSearch";
	}
	
	//그룹장 검색용
		@RequestMapping(value="groupsearchOwner.do")
		public String groupSearchOwnerMethod(@RequestParam("keyword") String keyword, 
				@RequestParam(name="page", required=false) String page,
				Model model) {
			int currentPage = 1;
			if(page != null) {
				currentPage = Integer.parseInt(page);
			}
			int limit = 10;
			int listCount = service.selectSearchOListCount(keyword);
			int maxPage = (int)((double)listCount / limit + 0.9);
			int startPage = (currentPage%10==0)? currentPage-9 :  (currentPage / 10) * 10 + 1 ;
			int endPage = startPage + 10 - 1;
			if(maxPage < endPage) {
				endPage = maxPage;
			}
			int startRow = (currentPage - 1) * limit + 1;
			int endRow = startRow + limit - 1;
			SearchPaging searchpaging = new SearchPaging(keyword, startRow, endRow);
			ArrayList<GammiGroup> list = service.selectSearchOwner(searchpaging);
			
			model.addAttribute("groups", list);
			model.addAttribute("listCount", listCount);
			model.addAttribute("maxPage", maxPage);
			model.addAttribute("currentPage", currentPage);
			model.addAttribute("startPage", startPage);
			model.addAttribute("endPage", endPage);
			model.addAttribute("limit", limit);
			model.addAttribute("action", "owner");
			model.addAttribute("keyword", keyword);
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
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
				String renameFileName = sdf.format(
						new java.sql.Date(System.currentTimeMillis()));
				renameFileName += "." + fileName.substring(fileName.lastIndexOf(".") + 1);
				
				File renameFile = new File(savePath + "\\" + renameFileName);
				
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
		int result = service.insertNewGroup(gammiGroup);
		if(result > 0) {
			return "redirect:group.do";
		}else {
			if(result==-1) {
				model.addAttribute("message", "이미 존재하는 모임입니다.");
			}
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
		model.addAttribute("gno",group.getGroup_no());
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
		GammiGroup group = service.selectOneGroup(gno);
		if(gm!=null) {
		model.addAttribute("group",group);
		model.addAttribute("gm", gm);
		model.addAttribute("gno",gno);
		return "group/memberManagement";
		}
		else{
		model.addAttribute("message", "존재하지 않는 모임입니다.");
		return "common/error";
		}
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
			if(state==1) {		//1 수락, 3 추방
				service.acceptGroupMember(gm);
			}else if(state==3) {
				service.deleteGroupMember(gm);
			}
			job = new JSONObject();
			job.put("group_no", Integer.parseInt(no));
			return job.toJSONString();  
		}
	//소모임 제거
		@RequestMapping("delGroup.do")
		public String groupDelete(@RequestParam("gno")int gno, HttpServletRequest request){
			GammiGroup group = service.selectOneGroup(gno);
			if(group.getGroup_img()!=null) {
				String savePath = request.getSession().getServletContext().getRealPath("resources/groupImg");
				try {
					new File(savePath + "\\" + group.getGroup_img()).delete();
				} catch (Exception e) {
					
				}
			}
			service.deleteGroup(group);
			return "redirect:group.do";
		}
		
		//모임 제한/가능 변경 처리용
		@RequestMapping(value="groupok.do", method=RequestMethod.POST)
		public ResponseEntity<String> changeGroupOKMethod(@RequestBody String param) throws ParseException {
			GammiGroup group = new GammiGroup();
			JSONParser jparser = new JSONParser();
			JSONObject json = (JSONObject)jparser.parse(param);
			group.setGroup_name((String)json.get("group_name"));
			group.setGroup_ok((String)json.get("group_ok"));
			if(service.updateGroupok(group) > 0) {
				return new ResponseEntity<String>("success", HttpStatus.OK);
			} else {
				return new ResponseEntity<String>("failed", HttpStatus.REQUEST_TIMEOUT);
			}
		}
		
		//admin 회원정보 내 그룹제한
		@RequestMapping("glist.do")
		public ModelAndView memberListViewMethod(@RequestParam(name="page", required=false) String page, ModelAndView mv) {
			int currentPage = 1;
			if(page != null) {
				currentPage = Integer.parseInt(page);
			}
			int limit = 10;  
			int listCount = service.admin_groupListCount();
			int maxPage = (int)((double)listCount / limit + 0.9);
			int startPage = (currentPage%10==0)? currentPage-9 :  (currentPage / 10) * 10 + 1 ;
			int endPage = startPage + 10 - 1;
			if(maxPage < endPage) {
				endPage = maxPage;
			}
			
			int startRow = (currentPage - 1) * limit + 1;
			int endRow = startRow + limit - 1;
			Paging paging = new Paging(startRow, endRow);
			
			//페이징 계산 처리 끝 ---------------------------------------
			
			ArrayList<GammiGroup> list = service.admin_groupList(paging);
			
			if(list != null && list.size() > 0) {
				mv.addObject("list", list);
				mv.addObject("listCount", listCount);
				mv.addObject("maxPage", maxPage);
				mv.addObject("currentPage", currentPage);
				mv.addObject("startPage", startPage);
				mv.addObject("endPage", endPage);
				mv.addObject("limit", limit);

				mv.setViewName("member/admin_group");
			}else {
				mv.addObject("message", 
						currentPage + " 회원 목록 조회 실패.");
				mv.setViewName("common/error");
			}
			return mv;
		}
		//admin 모임관리(모임장아이디 검색)
		@RequestMapping(value="gsearowner.do", method=RequestMethod.GET)
		public String gsearowner(
				@RequestParam("keyword") String keyword, 
				@RequestParam(name="page", required=false) String page,
				Model model) {
			int currentPage = 1;
			if(page != null) {
				currentPage = Integer.parseInt(page);
			}
			
			int limit = 10;
			int listCount = service.admin_ownerCount(keyword);
			int maxPage = (int)((double)listCount / limit + 0.9);
			int startPage = (currentPage%10==0)? currentPage-9 :  (currentPage / 10) * 10 + 1 ;
			int endPage = startPage + 10 - 1;
			if(maxPage < endPage) {
				endPage = maxPage;
			}
			
			int startRow = (currentPage - 1) * limit + 1;
			int endRow = startRow + limit - 1;
			
			//페이징 계산 처리 끝 ---------------------------------------
			SearchPaging searchpaging = new SearchPaging(keyword, startRow, endRow);
			
			ArrayList<GammiGroup> list = service.admin_ownerSearch(searchpaging);
			
			if(list.size() > 0) {
				model.addAttribute("list", list);
				model.addAttribute("listCount", listCount);
				model.addAttribute("maxPage", maxPage);
				model.addAttribute("currentPage", currentPage);
				model.addAttribute("startPage", startPage);
				model.addAttribute("endPage", endPage);
				model.addAttribute("limit", limit);
				model.addAttribute("action", "owner");
				model.addAttribute("keyword", keyword);
			}
			return "member/admin_group";
		}
		
		//admin 모임관리(제한여부 검색)
		@RequestMapping(value="gsearchGOk.do", method=RequestMethod.GET)
		public String gsearchGok(
				@RequestParam("keyword") String keyword, 
				@RequestParam(name="page", required=false) String page,
				Model model) {
			int currentPage = 1;
			if(page != null) {
				currentPage = Integer.parseInt(page);
			}
			int limit = 10;
			int listCount = service.groupOKCount(keyword.toUpperCase());
			int maxPage = (int)((double)listCount / limit + 0.9);
			int startPage = (currentPage%10==0)? currentPage-9 :  (currentPage / 10) * 10 + 1 ;
			int endPage = startPage + 10 - 1;
			if(maxPage < endPage) {
				endPage = maxPage;
			}
			
			int startRow = (currentPage - 1) * limit + 1;
			int endRow = startRow + limit - 1;
			
			//페이징 계산 처리 끝 ---------------------------------------
			SearchPaging searchpaging = new SearchPaging(keyword.toUpperCase(), startRow, endRow);
			
			ArrayList<GammiGroup> list = service.groupOKSearch(searchpaging);
			
			if(list.size() > 0) {
				model.addAttribute("list", list);
				model.addAttribute("listCount", listCount);
				model.addAttribute("maxPage", maxPage);
				model.addAttribute("currentPage", currentPage);
				model.addAttribute("startPage", startPage);
				model.addAttribute("endPage", endPage);
				model.addAttribute("limit", limit);
				model.addAttribute("action", "groupok");
				model.addAttribute("keyword", keyword);
			}
			return "member/admin_group";
		}
}
