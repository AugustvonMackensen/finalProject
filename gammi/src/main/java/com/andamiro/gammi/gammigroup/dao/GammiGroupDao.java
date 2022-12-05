package com.andamiro.gammi.gammigroup.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.andamiro.gammi.common.Paging;
import com.andamiro.gammi.common.SearchPaging;
import com.andamiro.gammi.gammigroup.vo.GammiGroup;
import com.andamiro.gammi.gammigroup.vo.GroupMember;

@Repository("groupDao")
public class GammiGroupDao {
	@Autowired
	private SqlSessionTemplate session;

	public ArrayList<GammiGroup> groupAllList(Paging paging) {
		List<GammiGroup> list =session.selectList("groupMapper.selectAllList",paging); 
		return (ArrayList<GammiGroup>)list;
	}

	public int insertNewGroup(GammiGroup gammiGroup) {
		int result=-1, result2=0, result3=0;
		try {
		result = session.insert("groupMapper.insertGroup",gammiGroup);
		result2 = session.insert("groupMapper.insertGoupMember",gammiGroup);
		result3 = session.insert("groupMapper.insertGroupNotice",gammiGroup);
		}catch (Exception e) {
			result=-1;
		}
		finally {
		return result;
		}
	}

	public GammiGroup selectOneGroup(int selectGroupNo) {
		return session.selectOne("groupMapper.selectOneGroup",selectGroupNo);
	}

	public GroupMember getGroupMember(GroupMember gm) {
		return session.selectOne("groupMapper.getGroupMember",gm);
	}

	public int getMemberCount(int gno) {
		return session.selectOne("groupMapper.getmemberCount",gno);
	}

	public int createApplication(GroupMember gm) {
		return session.insert("groupMapper.createApplication",gm);
	}

	public ArrayList<GroupMember> getAllGM(int gno) {
		try {
			List<GroupMember> list = session.selectList("groupMapper.getAllGM",gno);
			return (ArrayList<GroupMember>)list;
		} catch (Exception e) {
			return null;
		}
	}

	public int deleteGroupMember(GroupMember gm) {
		return session.delete("groupMapper.deleteGroupMember",gm);
	}

	public int acceptGroupMember(GroupMember gm) {
		return session.update("groupMapper.acceptGroupMember",gm);
	}

	public int refuseGroupMember(GroupMember gm) {
		return session.update("groupMapper.refuseGroupMember",gm);
	}
	public int selectSearchTListCount(String keyword) {
		return session.selectOne("groupMapper.selectSearchTListCount", keyword);
	}

	public ArrayList<GammiGroup> selectSearchTitle(SearchPaging searchpaging) {
		List<GammiGroup> list =session.selectList("groupMapper.selectSearchTitle", searchpaging); 
		return (ArrayList<GammiGroup>)list;
	}

	public int selectListCount() {
		return session.selectOne("groupMapper.selectListCount");
	}

	public int selectJoinListCount(String m_id) {
		return session.selectOne("groupMapper.selectJoinListCount", m_id);
	}

	public ArrayList<GammiGroup> groupJoinAllList(Paging paging) {
		List<GammiGroup> list = session.selectList("groupMapper.selectAllList", paging);
		return (ArrayList<GammiGroup>)list;
	}

	public int selectSearchOListCount(String keyword) {
		return session.selectOne("groupMapper.selectSearchOListCount", keyword);
	}

	public ArrayList<GammiGroup> selectSearchOwner(SearchPaging searchpaging) {
		List<GammiGroup> list =session.selectList("groupMapper.selectSearchOwner", searchpaging); 
		return (ArrayList<GammiGroup>)list;
	}

	public int deleteGroup(GammiGroup group) {
		return session.delete("groupMapper.deleteGroup",group);
	}

}
