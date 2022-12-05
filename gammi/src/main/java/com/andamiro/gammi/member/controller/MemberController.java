package com.andamiro.gammi.member.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;

import com.andamiro.gammi.common.Paging;
import com.andamiro.gammi.member.service.MemberService;
import com.andamiro.gammi.member.vo.Member;

@Controller
public class MemberController {
	
	private static final Logger logger = 
						LoggerFactory.getLogger(MemberController.class);
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private MailSendService mailService;
	
	@Autowired
	private BCryptPasswordEncoder bcryptPasswordEncoder;
	
	// 회원가입 이동 
	@RequestMapping("enrollPage.do")
	public String moveEnrollPage() {
		return "member/enrollPage";
	}
	
	// 로그인 페이지 이동 
	@RequestMapping("loginPage.do")
	public String moveLoginPage() {
		return "member/loginPage";
	}
				
	//아이디찾기 페이지 이동 
	@RequestMapping("moveIdRecovery.do") 
	public String moveIdFindPage() {
		return "member/idFind";
		}
	
	//비밀번호 찾기 페이지 이동 
	@RequestMapping("movePwdRecovery.do")
	public String movePwdRecoveryPage() {
		return "member/findPw";
	}
	
	//수정페이지 이동 
	@RequestMapping("moveup.do")
	public String moveUpdatePage(@RequestParam String m_id, Model model) {
		Member member = memberService.selectMember(m_id);
		if(member != null) {
			model.addAttribute("member", member);
			return "member/update";
		} else {
			model.addAttribute("message", m_id + " : 회원 조회 실패!");
			return "common/error";
		}
	}
	//회원 가입 처리용
		@RequestMapping(value="enroll.do", method=RequestMethod.POST)
		public String memberInsertMethod(Member member, Model model) {
			//메소드 매개변수에 vo 를 지정하면, 자동 객체 생성되면서
			//뷰페이지 form 태그 input 의 name 과 vo 의 필드명이 같으면
			//자동으로 전송온 값(parameter)이 꺼내져서 객체에 옮겨 저장됨
			//커맨드 객체(command object) 라고 함
			//logger.info("enroll.do : " + member);
			
			//패스워드 암호화 처리
			member.setM_pw(this.bcryptPasswordEncoder.encode(
					member.getM_pw()));
			//logger.info("after encode : " + member);
			//logger.info("length : " + member.getUserpwd().length());
			
			if(memberService.insertMember(member) > 0) {
				//회원 가입 성공
				return "common/main";
			}else {
				//회원 가입 실패
				model.addAttribute("message", "회원 가입 실패!");
				return "common/error";
			}
		}
		
		//ajax 통신으로 처리하는 요청 메소드 -------------------------
		//아이디 중복 확인 
		@RequestMapping(value="idchk.do", method=RequestMethod.POST)
		public void dupIdCheckMethod(
				@RequestParam("m_id") String m_id, 
				HttpServletResponse response) throws IOException {
			
			int idCount = memberService.selectDupCheckId(m_id);
			
			String returnValue = null;
			if(idCount == 0) {
				returnValue = "ok";
			}else {
				returnValue = "dup";
			}
			
			//response 를 이용해서 클라이언트로 출력스트림을 만들고 값 보내기
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.append(returnValue);
			out.flush();
			out.close();
		}
		
		//닉네임 중복 확인 
		@RequestMapping(value="nickchk.do", method=RequestMethod.POST)
		public void dupNickNameCheckMethod(
				@RequestParam("m_nickname") String m_nickname, 
				HttpServletResponse response) throws IOException {
			
			int idCount = memberService.selectDupCheckNickName(m_nickname);
			
			String returnValue = null;
			if(idCount == 0) {
				returnValue = "ok";
			}else {
				returnValue = "dup";
			}
			
			//response 를 이용해서 클라이언트로 출력스트림을 만들고 값 보내기
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.append(returnValue);
			out.flush();
			out.close();
		}
		
		
		
		@RequestMapping(value="login.do", method=RequestMethod.POST)
		public String loginMethod(Member member, 
				HttpSession loginSession, SessionStatus status,
				Model model) {
			//logger.info("login.do : " + member);
			
			//암호화 처리된 패스워드 일치 조회는 select 해 온 값으로 비교함
			//전달온 회원 아이디로 먼저 회원정보 조회해 옴
			Member loginMember = memberService.selectMember(
											member.getM_id());
			
			//2. 서비스 모델로 전달하고 결과 받기
			//Member loginMember = memberService.selectLogin(member);
			//logger.info(loginMember.toString());
			
			//3. 로그인 성공 여부에 따라서 결과 처리
			//암호화된 패스워드와 전달된 글자타입 패스워드를 비교함
			//matches(글자타입패스워드, 암호화된패스워드)
			String viewName = null;
			if(loginMember != null && 
					this.bcryptPasswordEncoder.matches(
						member.getM_pw(), loginMember.getM_pw())
					&& loginMember.getLogin_ok().equals("Y")) {  //로그인 성공
				//로그인 상태 관리 방법 (상태 관리 매커니즘) : 기본 세션 사용
				logger.info("sessionID : " + loginSession.getId());
				
				//필요할 경우 생성된 세션 객체 안에 정보를 저장할 수 있음
				//맵 구조로 저장함 : 키(String), 값(Object)
				loginSession.setAttribute("loginMember", loginMember);
				status.setComplete();  //로그인 요청 성공, 200 전송함
				
				//로그인 성공시 내보낼 뷰파일명 지정
				viewName =  "common/main";
			}else {  //로그인 실패
				model.addAttribute("message", 
						"로그인 실패 : 아이디나 암호 확인하세요.<br>"
						+ "또는 로그인 제한 회원인지 관리자에게 문의하세요.");
				viewName = "common/error";
			}
			
			return viewName;
		}
		
		//로그아웃 처리용
		@RequestMapping("logout.do")
		public String logoutMethod(HttpServletRequest request, 
				Model model) {
			//로그인할 때 생성된 세션객체를 찾아서 없앰
			HttpSession session = request.getSession(false);
			//request 가 가진 세션id 에 대한 세션객체가 있으면 리턴
			//없으면 null 리턴
			
			if(session != null) {
				session.invalidate(); //세션 객체를 없앰
				return "common/main";
			}else {
				model.addAttribute("message", 
						"로그인 세션이 존재하지 않습니다.");
				return "common/error";
			}
		}
		
		@RequestMapping("mlist.do")
		public ModelAndView memberListViewMethod(@RequestParam(name="page", required=false) String page, ModelAndView mv) {
			
			int currentPage = 1;
			if(page != null) {
				currentPage = Integer.parseInt(page);
			}
			
			int limit = 10;  
			int listCount = memberService.selectListCount();
			
			int maxPage = (int)((double)listCount / limit + 0.9);

			int startPage = (currentPage / 10) * 10 + 1;
			int endPage = startPage + 10 - 1;
			
			if(maxPage < endPage) {
				endPage = maxPage;
			}
			
			int startRow = (currentPage - 1) * limit + 1;
			int endRow = startRow + limit - 1;
			Paging paging = new Paging(startRow, endRow);
			
			//페이징 계산 처리 끝 ---------------------------------------
			
			ArrayList<Member> list = memberService.selectList(paging);
			
			if(list != null && list.size() > 0) {
				mv.addObject("list", list);
				mv.addObject("listCount", listCount);
				mv.addObject("maxPage", maxPage);
				mv.addObject("currentPage", currentPage);
				mv.addObject("startPage", startPage);
				mv.addObject("endPage", endPage);
				mv.addObject("limit", limit);
				mv.setViewName("member/admin");
			}else {
				mv.addObject("message", 
						currentPage + " 회원 목록 조회 실패.");
				mv.setViewName("common/error");
			}
			
			return mv;
		}
		
		//이메일 인증
		@ResponseBody
		@GetMapping("mailCheck.do")
		public String mailCheck(String m_email) {
			int mailCount = memberService.selectMailCheck(m_email);
			
			if(mailCount == 0 ) {
				return mailService.mailMessage(m_email);
			} else {
				String failureMessage = "failure";
				return failureMessage;
			}
		}
		
		//회원 정보 보기
		//리턴 타입으로 String, ModelAndView 를 사용할 수 있음
		@RequestMapping("myinfo.do")
		//public String myinfoMethod() {  return "폴더명/뷰파일명"; }
		public ModelAndView myinfoMethod(
				@RequestParam("m_id") String m_id, 
				ModelAndView mv) {
			//서비스로 전송온 값 전달해서, 실행 결과 받기
			Member member = memberService.selectMember(m_id);
			
			if(member != null) {
				mv.addObject("member", member);
				mv.setViewName("member/myinfo");
			}else {
				mv.addObject("message", m_id + " : 회원 정보 조회 실패!");
				mv.setViewName("common/error");
			}
			
			return mv;		
		}
		
		//회원 정보 수정용 : 수정 성공시 myinfoPage.jsp 로 이동함
		@RequestMapping(value="mupdate.do", method=RequestMethod.POST)
		public String memberUpdateMethod(Member member, Model model, 
				@RequestParam("origin_userpwd") String originUserpwd) {
			logger.info("mupdate.do : " + member);
			logger.info("origin_userpwd : " + originUserpwd);
			
			//새로운 암호가 전송이 왔다면, 패스워드 암호화 처리함
			String m_pw = member.getM_pw().trim();
			if(m_pw != null && m_pw.length() > 0) {
				//기존 암호와 다른 값이면
				if(!this.bcryptPasswordEncoder.matches(m_pw, originUserpwd)) {
					//member 에 새로운 패스워드를 암호화해서 기록함
					member.setM_pw(this.bcryptPasswordEncoder.encode(m_pw));
				}
			}else {
				//새로운 패스워드 값이 없다면, member 에 원래 패스워드 기록
				member.setM_pw(originUserpwd);
			}
			
			logger.info("after : " + member);
			
			if(memberService.updateMember(member) > 0) {
				//수정이 성공했다면, 컨트롤러의 메소드를 직접 호출할 수도 있음
				//즉, 컨트롤러 안에서 다른 컨트롤러를 실행할 수도 있음
				//내정보보기 페이지에 수정된 회원정보를 다시 조회해서 내보냄
				//쿼리스트링 : ?이름=값&이름=값
				return "redirect:myinfo.do?m_id=" + member.getM_id();
			}else {
				model.addAttribute("message", 
						member.getM_id() + " : 회원 정보 수정 실패!");
				return "common/error";
			}
			
		}
		
		//회원 탈퇴
		// 삭제되면 자동 로그아웃함
		@RequestMapping("mdel.do")
		public String memberDeleteMethod(@RequestParam("m_id") String m_id, Model model) {
			if(memberService.deleteMember(m_id) > 0) {
				return "redirect:logout.do";
			} else {
				model.addAttribute("message", m_id + " : 회원 삭제 요청 실패!");
				return "common/error";
			}
		}
		
		//아이디 찾기
		@RequestMapping("idRecovery.do")
		public ModelAndView idRecovery(@RequestParam("m_email") String m_email, ModelAndView mv) {
			Member loginMember = memberService.selectByMail(m_email);
			
			if(loginMember != null) {
				mv.addObject("find_id", loginMember.getM_id());
				mv.setViewName("member/showUid");
			}else {
				mv.addObject("message", "아이디 찾기 실패!");
				mv.setViewName("common/error");
			}
			
			return mv;
			
		}
		
		//비밀번호 찾기 : 임시비밀번호 발급
		@PostMapping("findPwd.do")
		public void passRecovery(Member loginMember, 
				HttpServletResponse response) throws IOException {
			response.setContentType("text/html;charset=utf-8");
			PrintWriter out = response.getWriter();
			String userid = loginMember.getM_id();
			String email = loginMember.getM_email();
			//아이디 조회에 실패하면, 오류메세지 출력
			if(memberService.chkSelectForPwd(loginMember) == 0) {
				out.print("등록된 아이디 또는 이메일이 없습니다.");
				out.close();
			}else {
				String tempKey = mailService.sendTempPwd(userid, email);
				loginMember.setM_pw(bcryptPasswordEncoder.encode(tempKey));
				memberService.findPwd(loginMember);
				out.print("인증번호가 발송되었습니다. <br>");
				out.print("<a href=\"main.do\">홈으로 이동</a>");
				out.close();
			}
			
		}
		
		//카카오 로그인 
		
		
		
		
}
