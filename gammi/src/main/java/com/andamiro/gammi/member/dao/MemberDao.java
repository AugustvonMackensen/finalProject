package com.andamiro.gammi.member.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.andamiro.gammi.common.Paging;
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

	public ArrayList<Member> selectList(Paging page) {
		List<Member> list = session.selectList("memberMapper.selectList", page);
		return (ArrayList<Member>)list;
	}

	public int selectListCount() {
		return session.selectOne("memberMapper.getListCount");
	}
	
	 
}
