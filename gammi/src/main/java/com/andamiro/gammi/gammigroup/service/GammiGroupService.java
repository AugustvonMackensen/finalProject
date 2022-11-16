package com.andamiro.gammi.gammigroup.service;

import java.util.ArrayList;

import com.andamiro.gammi.gammigroup.vo.GammiGroup;
import com.andamiro.gammi.gammigroup.vo.GroupMember;

public interface GammiGroupService {
	//�׷� ��ü��� ��ȸ
	public ArrayList<GammiGroup> groupAllList();
	//�׷� �ű� ����
	public int insertNewGroup(GammiGroup gammiGroup);
	//���ԵǾ��ִ� �׷� ����
	public GammiGroup selectOneGroup(int selectGroupNo);
	//�׷쿡 ���� �Ǿ��ִ��� Ȯ��
	public int getGroupMember(GroupMember gm);
	//�����Ϸ��� �׷쿡 ���Ե� �ο��� ������� Ȯ��
	public int getMemberCount(int gno); 
}
