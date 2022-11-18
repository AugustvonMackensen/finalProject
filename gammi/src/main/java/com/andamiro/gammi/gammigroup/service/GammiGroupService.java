package com.andamiro.gammi.gammigroup.service;

import java.util.ArrayList;

import com.andamiro.gammi.gammigroup.vo.GammiGroup;
import com.andamiro.gammi.gammigroup.vo.GroupMember;

public interface GammiGroupService {
		//그룹 전체목록 조회
		public ArrayList<GammiGroup> groupAllList();
		//그룹 신규 생성
		public int insertNewGroup(GammiGroup gammiGroup);
		//가입되어있는 그룹 접속
		public GammiGroup selectOneGroup(int selectGroupNo);
		//그룹에 가입 되어있는지 확인
		public GroupMember getGroupMember(GroupMember gm);
		//가입하려는 그룹에 가입된 인원이 몇명인지 확인
		public int getMemberCount(int gno); 
		//모임 신규가입
		public int createApplication(GroupMember gm);
		//모임에 가입된 전체 유저(가입 목록 보기)
		public ArrayList<GroupMember> getAllGM(int gno);
		//모임 유저 탈퇴/ 추방처리
		public int deleteGroupMember(GroupMember gm);
		//모임 유저 가입 승인
		public int updateGroupMember(GroupMember gm); 
}
