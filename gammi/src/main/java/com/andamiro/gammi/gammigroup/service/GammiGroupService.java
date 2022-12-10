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
		//가입된 페이지 목록 갯수 조회
		public int selectJoinListCount(String m_id);
		//가입된 모임 조회
		public ArrayList<GammiGroup> groupJoinAllList(Paging paging);
		//모임장으로 검색
		public int selectSearchOListCount(String keyword);
		public ArrayList<GammiGroup> selectSearchOwner(SearchPaging searchpaging);
		//그룹 삭제
		public int deleteGroup(GammiGroup group);
		//모임 제한
		public int updateGroupok(GammiGroup group);
		
		//admin 모임관리 전체 페이징처리
		public int admin_groupListCount();
		public ArrayList<GammiGroup> admin_groupList(Paging paging);
		
		//모임제한여부 페이징처리
		public int groupOKCount(String upperCase);
		public ArrayList<GammiGroup> groupOKSearch(SearchPaging searchpaging);
		
		//admin 그룹장 검색 페이징처리
		public int admin_ownerCount(String keyword);
		public ArrayList<GammiGroup> admin_ownerSearch(SearchPaging searchpaging);
		
		
}
