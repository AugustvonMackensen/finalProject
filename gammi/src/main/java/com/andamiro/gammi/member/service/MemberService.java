package com.andamiro.gammi.member.service;

import java.util.ArrayList;

import com.andamiro.gammi.common.Paging;
import com.andamiro.gammi.member.vo.Member;

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
}
