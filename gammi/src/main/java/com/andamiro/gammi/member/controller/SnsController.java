package com.andamiro.gammi.member.controller;

import java.io.IOException;

import javax.servlet.http.HttpSession;

import org.codehaus.jackson.JsonNode;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import com.andamiro.gammi.member.service.MemberService;
import com.andamiro.gammi.member.vo.Member;
import com.github.scribejava.core.model.OAuth2AccessToken;
import com.google.gson.JsonObject;

@Controller
public class SnsController {

	private static final Logger logger = 
			LoggerFactory.getLogger(SnsController.class);
	
	@Autowired
	private MemberService memberService;

	@Autowired
	private NaverLoginAuth naverLoginAuth;
	private String apiResult = null;

	/* 네이버 연동 객체 자동 생성 */
	@Autowired
	private void setNaverLoginAuth(NaverLoginAuth naverLoginAuth) {
		this.naverLoginAuth = naverLoginAuth;
	}

	@Autowired
	private GoogleLoginAuth googleLoginAuth;

	@Autowired
	private void setGoogleLoginAuth(GoogleLoginAuth googleLoginAuth) {
		this.googleLoginAuth = googleLoginAuth;
	}

	@Autowired
	private KakaoLoginAuth kakaoLoginAuth;

	@Autowired
	private void setKakaoLoginAuth(KakaoLoginAuth kakaoLoginAuth) {
		this.kakaoLoginAuth = kakaoLoginAuth;
	}

	// 로그인페이지로 이동-(+ 네이버 버튼에 연결url전송 , + 카카오톡 버튼에 연결url전송)
	@RequestMapping(value = "loginPage.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String moveLoginPage(Model model, HttpSession session) {

		// 네이버 로그인 접속을 위한 인증 url 정보 생성
		String naverAuthUrl = naverLoginAuth.getAuthorizationUrl(session);

		// 구글 로그인 접속을 위한 인증 url 정보 생성
//					String googleAuthUrl = googleLoginAuth.getAuthorizationUrl(session);

		// 카카오 로그인 접속을 위한 인증 url 정보 생성
		String kakaoAuthUrl = kakaoLoginAuth.getAuthorizationUrl(session);

		// 모델에 각각의 url 정보 저장
		model.addAttribute("naverUrl", naverAuthUrl);

//					 model.addAttribute("googleUrl", googleAuthUrl);
		model.addAttribute("kakaoUrl", kakaoAuthUrl);

		return "member/loginPage";
	}

	@RequestMapping(value = "/ncallback.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String naverCallback(Model model, @RequestParam String code, @RequestParam String state, HttpSession session)
			throws IOException, ParseException {
		System.out.println("네이버 로그인성공!");
		OAuth2AccessToken oauthToken;
		oauthToken = naverLoginAuth.getAccessToken(session, code, state);
		// 1. 로그인 사용자 정보를 읽어온다.
		apiResult = naverLoginAuth.getUserProfile(oauthToken); // String형식의 json데이터

		// 2. String형식인 apiResult를 json형태로 바꿈
		JSONParser parser = new JSONParser();
		Object obj = parser.parse(apiResult);
		JSONObject jsonObj = (JSONObject) obj;
		
		logger.info(parser + "파서");
		logger.info(obj + "오비제");
		logger.info(jsonObj + "제이슨 오비제");
		// 3. 데이터 파싱
		JSONObject response_obj = (JSONObject) jsonObj.get("response");

		Member member = new Member();

		member.setM_email((String) response_obj.get("email"));
		member.setM_name((String) response_obj.get("nickname"));
		member.setM_id((String) response_obj.get("id"));

		Member loginMember = memberService.selectMember(member.getM_id());
		if (loginMember == null) {
			int result = memberService.insertMember(member);
			if(result<0){
				model.addAttribute("message", "이미 존재하는 아이디입니다.");
				return "common/error";
			}
		} else {
			loginMember = member;
		}

		session.setAttribute("sns", "naver");
		session.setAttribute("loginMember", loginMember);

		return "../../index";
	}

	// 카카오
	@RequestMapping(value = "/kcallback.do", produces = "application/json", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String kakaoLogin(@RequestParam String code, Model model, HttpSession session) throws Exception {

		// JsonNode access_Token = kakaoLoginAuth.getAccessToken(code);
		// HashMap<String, Object> userinfo = kakaoLoginAuth.getUserInfo(access_Token);

		JsonNode node = kakaoLoginAuth.getAccessToken(code); // accessToken에 사용자의 로그인한 모든 정보가 들어있음
		JsonNode accessToken = node.get("access_token"); // 사용자의 정보
		JsonNode userInfo = KakaoLoginAuth.getKakaoUserInfo(accessToken);

		// 회원가입시 사용
		logger.info(node+"노드");
		logger.info(accessToken+"토큰");
		logger.info(userInfo+"userInfo");
		// 유저정보 카카오에서 가져오기 Get properties
		JsonNode properties = userInfo.path("properties");
		JsonNode kakao_account = userInfo.path("kakao_account");// 값 가져올 수 있지만 사용은 안함
		String kid = userInfo.path("id").asText();
        
		// *값 받아온 것을 회원 정보와 확인해야함*//
		Member member = new Member();
		logger.info(properties+ "");
		member.setM_name((String) properties.get("nickname").asText());
		member.setM_email((String) kakao_account.get("email").asText());
		member.setM_id(kid);
		
		
		Member loginMember = memberService.selectMember(member.getM_id());
		if (loginMember == null) {
			int result = memberService.insertMember(member);
			if (result <= 0) {
				model.addAttribute("message", "카카오 로그인 등록실패");
				return "common/error";
			}else {
				loginMember = memberService.selectMember(member.getM_id());
			}
		} else {
			loginMember = member;
		}
		
		
		session.setAttribute("access_Token", node);
		session.setAttribute("loginMember", loginMember);
		return "../../index";

	}// end kakaoLogin()

	@RequestMapping(value = "/gcallback.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String googleCallback(Model model, @RequestParam String code, @RequestParam String state,
			HttpSession session) throws Exception {
		System.out.println("구글 로그인성공!");
		OAuth2AccessToken oauthToken;
		oauthToken = googleLoginAuth.getAccessToken(session, code, state);
		// 1. 로그인 사용자 정보를 읽어온다.
		apiResult = googleLoginAuth.getUserProfile(oauthToken); // String형식의 json데이터
		System.out.println("api" + apiResult);
		// 2. String형식인 apiResult를 json형태로 바꿈
		JSONParser parser = new JSONParser();
		Object obj = parser.parse(apiResult);
		JSONObject jsonObj = (JSONObject) obj;
		// 3. 데이터 파싱

//		GoogleVO googlevo = new GoogleVO();
//
//		googlevo.setEmail((String) jsonObj.get("email"));
//		googlevo.setUsername((String) jsonObj.get("name"));
//		googlevo.setUserid((String) jsonObj.get("id"));
//
//		GoogleVO loginvo = snsService.selectGoogleVO(googlevo.getUsername());
//		if (loginvo == null) {
//			int result1 = snsService.insertGoogleVO(googlevo);
//		} else {
//			googlevo = loginvo;
//		}

//		session.setAttribute("sns", "google");
//		session.setAttribute("loginMember", googlevo);

		return "redirect:/main.do";
	}

}
