package com.andamiro.gammi.gammigroup.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.andamiro.gammi.gammigroup.vo.GammiGroup;
import com.andamiro.gammi.member.vo.Member;

@Repository("groupDao")
public class GammiGroupDao {
	@Autowired
	private SqlSessionTemplate session;

	public ArrayList<GammiGroup> groupAllList() {
		List<GammiGroup> list =session.selectList("groupMapper.selectAllList"); 
		return (ArrayList<GammiGroup>)list;
	}

	public int insertNewGroup(GammiGroup gammiGroup) {
		System.out.println(gammiGroup);
		return session.insert("groupMapper.insertGroup",gammiGroup);
	}

}
