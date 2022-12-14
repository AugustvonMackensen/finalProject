package com.andamiro.gammi.member.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.andamiro.gammi.common.Paging;
import com.andamiro.gammi.common.SearchPaging;
import com.andamiro.gammi.member.vo.Member;
import com.andamiro.gammi.notice.vo.Notice;

@Repository("memberDao")
public class MemberDao {
	
	@Autowired
	private SqlSessionTemplate session;

	public int insertMember(Member member) {
		try {
		return session.insert("memberMapper.insertMember",member);
		}catch(Exception e) {
			return -1;
		}
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
	
	public int selectDupCheckNick(String m_nickname) {
		return session.selectOne("memberMapper.selectCheckNick", m_nickname);
	}

	public int selectMailCheck(String m_email) {
		return session.selectOne("memberMapper.selectMailCheck", m_email);
	}

	

	public int updateMember(Member member) {
		return session.update("memberMapper.updateMember", member);
	}

	public int deleteMember(String m_id) {
		return session.delete("memberMapper.deleteMember", m_id);
	}


	public Member selectByMail(String m_email) {
		return session.selectOne("memberMapper.selectByMail", m_email);
	}

	public int chkSelectForPwd(Member loginMember) {
		return session.selectOne("memberMapper.chkSelectForPwd", loginMember);
	}

	public int findPwd(Member member) {
		return session.update("memberMapper.findPwd", member);
	}

	public int updateLoginok(Member member) {
		return session.update("memberMapper.updateLoginOK", member);
	}

	public int aupdateMember(Member member) {
		return session.update("memberMapper.aupdateMember", member);
	}

	public ArrayList<Member> userIDSearch(SearchPaging searchpaging) {
		List<Member> list = session.selectList("memberMapper.userIDSearch",searchpaging);
		return (ArrayList<Member>)list;
	}

	public int userIDSearchCount(String keyword) {
		return session.selectOne("memberMapper.userIDSearchCount",keyword);
	}

	public int loginOKCount(String keyword) {
		return session.selectOne("memberMapper.loginOKCount",keyword);
	}

	public ArrayList<Member> loginOKSearch(SearchPaging searchpaging) {
		List<Member> list = session.selectList("memberMapper.loginOKSearch",searchpaging);
		return (ArrayList<Member>)list;
	}

	 
}
