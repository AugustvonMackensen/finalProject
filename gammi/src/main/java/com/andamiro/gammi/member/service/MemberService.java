package com.andamiro.gammi.member.service;

import java.util.ArrayList;

import javax.servlet.http.HttpServletResponse;

import com.andamiro.gammi.common.Paging;
import com.andamiro.gammi.common.SearchPaging;
import com.andamiro.gammi.member.vo.Member;
import com.andamiro.gammi.notice.vo.Notice;

public interface MemberService {
 
	int insertMember(Member member);

	int selectDupCheckId(String m_id);

	Member selectMember(String m_id);
	
	ArrayList<Member> selectList(Paging page);

	int selectListCount();
	
	int selectDupCheckNickName(String m_nickname);

	int selectMailCheck(String m_email);

	int updateMember(Member member);

	int deleteMember(String m_id);

	Member selectByMail(String m_email);

	int chkSelectForPwd(Member loginMember);

	int findPwd(Member member);

	int updateLoginok(Member member);

	int aupdateMember(Member member);

	int userIDSearchCount(String keyword);

	ArrayList<Member> userIDSearch(SearchPaging searchpaging);

	int loginOKCount(String keyword);

	ArrayList<Member> loginOKSearch(SearchPaging searchpaging);



}
