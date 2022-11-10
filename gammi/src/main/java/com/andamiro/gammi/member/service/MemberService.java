package com.andamiro.gammi.member.service;

import com.andamiro.gammi.member.vo.Member;

public interface MemberService {
 
	int insertMember(Member member);

	int selectDupCheckId(String m_id);

	Member selectMember(String m_id);
	
}
