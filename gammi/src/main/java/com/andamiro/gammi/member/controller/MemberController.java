package com.andamiro.gammi.member.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.support.SessionStatus;

import com.andamiro.gammi.member.service.MemberService;
import com.andamiro.gammi.member.vo.Member;

@Controller
public class MemberController {
	
	private static final Logger logger = 
						LoggerFactory.getLogger(MemberController.class);
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private BCryptPasswordEncoder bcryptPasswordEncoder;
	
	@RequestMapping("enrollPage.do")
	public String moveEnrollPage() {
		return "member/enrollPage";
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
		
		// 로그인 페이지 이동 
		@RequestMapping("loginPage.do")
		public String moveLoginPage() {
			return "member/loginPage";
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
				viewName =  "group/groupSearch";//"common/main";
			}else {  //로그인 실패
				model.addAttribute("message", 
						"로그인 실패 : 아이디나 암호 확인하세요.<br>"
						+ "또는 로그인 제한 회원인지 관리자에게 문의하세요.");
				viewName = "common/error";
			}
			
			return viewName;
		}
		
		
}
