package com.andamiro.gammi.gammigroup.service;

import java.util.ArrayList;

import com.andamiro.gammi.common.Paging;
import com.andamiro.gammi.common.SearchPaging;
import com.andamiro.gammi.gammigroup.vo.GammiGroup;
import com.andamiro.gammi.gammigroup.vo.GroupMember;

public interface GammiGroupService {
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
		public int acceptGroupMember(GroupMember gm);
		//모임 유저 가입 거절
		public int refuseGroupMember(GroupMember gm);
		//전체 그룹 갯수 조회
		public int selectListCount();
		//전체 그룹 페이징
		public ArrayList<GammiGroup> groupAllList(Paging paging); 
		//전체 검색 키워드 갯수 계산을 위해 총 목록 갯수 조회해 옴
		public int selectSearchTListCount(String keyword);
		//키워드 가지고 서칭 페이징용 조회
		public ArrayList<GammiGroup> selectSearchTitle(SearchPaging searchpaging);
		
}
