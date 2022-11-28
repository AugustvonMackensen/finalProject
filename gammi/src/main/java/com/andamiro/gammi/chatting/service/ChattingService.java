package com.andamiro.gammi.chatting.service;

import java.util.ArrayList;

import com.andamiro.gammi.chatting.vo.ChatMessage;
import com.andamiro.gammi.chatting.vo.ChatRoom;
import com.andamiro.gammi.chatting.vo.ChatRoomJoin;

public interface ChattingService {
	//모임에 존재하는 모든 채팅방목록 가져옴
	public ArrayList<ChatRoom> allList(int gno);
	//마지막 생성된 채팅방번호 검색
	public int selectChatNo();
	//신규 채팅방 생성(접속자 아이디 기준으로 새로 생성) group_no, m_id(접속자)
	public int createChatRoom(ChatRoom room);
	//채팅방 입장 멤버정보(채팅방번호, 접속자)
	public ChatRoomJoin findRoomMember(ChatRoomJoin chatroom);
	//메시지
	public ArrayList<ChatMessage> findRoomMessages(ChatRoomJoin room);
	//방정보 가져오기
	public ChatRoom findRoom(ChatRoom chatroom);
	public int createChatJoin(ChatRoomJoin room);
	public int setMsgDB(ChatMessage message);
	//채팅방 삭제
	public int roomDelete(int group_no);

}
