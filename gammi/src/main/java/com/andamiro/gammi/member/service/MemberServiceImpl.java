package com.andamiro.gammi.member.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.andamiro.gammi.member.dao.MemberDao;
import com.andamiro.gammi.member.vo.Member;

@Service("memberService")
public class MemberServiceImpl implements MemberService{
	
	@Autowired
	private MemberDao memberDao;
 
	@Override
	public int insertMember(Member member) {
		return memberDao.insertMember(member);
	}

	@Override
	public int selectDupCheckId(String m_id) {
		return memberDao.selectDupCheckId(m_id); 
	}

	@Override
	public Member selectMember(String m_id) {
		return memberDao.selectMember(m_id);
	}
	
	
}
