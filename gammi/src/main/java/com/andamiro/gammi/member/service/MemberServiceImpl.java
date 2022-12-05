package com.andamiro.gammi.member.service;

import java.util.ArrayList;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.andamiro.gammi.common.Paging;
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

	@Override
	public ArrayList<Member> selectList(Paging page) {
		return memberDao.selectList(page);
	}

	@Override
	public int selectListCount() {
		return memberDao.selectListCount();
	}
	
	@Override
	public int selectDupCheckNickName(String m_nickname) {
		return memberDao.selectDupCheckNick(m_nickname);
	}

	@Override
	public int selectMailCheck(String m_email) {
		return memberDao.selectMailCheck(m_email);
	}

	@Override
	public int updateMember(Member member) {
		return memberDao.updateMember(member);
	}

	@Override
	public int deleteMember(String m_id) {
		return memberDao.deleteMember(m_id);
	}

	@Override
	public Member selectByMail(String m_email) {
		return memberDao.selectByMail(m_email);
	}

	@Override
	public int chkSelectForPwd(Member loginMember) {
		return memberDao.chkSelectForPwd(loginMember);
	}

	@Override
	public int findPwd(Member member) {
		return memberDao.findPwd(member);
	}



	

	
	
}
