package com.andamiro.gammi.member.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.andamiro.gammi.member.vo.Member;

@Repository("memberDao")
public class MemberDao {
	
	@Autowired
	private SqlSessionTemplate session;

	public int insertMember(Member member) {
		return session.insert("memberMapper.insertMember",member);
	}

	public int selectDupCheckId(String m_id) {
		return session.selectOne("memberMapper.selectCheckId", m_id);
	}

	public Member selectMember(String m_id) {
		return session.selectOne("memberMapper.selectMember", m_id);
	}
	
	 
}
