package com.andamiro.gammi.chatting.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.andamiro.gammi.chatting.dao.ChattingDao;
import com.andamiro.gammi.chatting.vo.ChatMessage;
import com.andamiro.gammi.chatting.vo.ChatRoom;
import com.andamiro.gammi.chatting.vo.ChatRoomJoin;

@Service("chattingService")
public class ChattingServiceImpl implements ChattingService{
	
	@Autowired
	private ChattingDao dao;

	@Override
	public ArrayList<ChatRoom> allList(int gno) {
		return dao.allList(gno);
	}
	
	@Override
	public int createChatRoom(ChatRoom room) {
		return dao.createChatRoom(room);
	}
	
	@Override
	public int createChatJoin(ChatRoomJoin room) {
		return dao.createChatJoin(room);
	}
	
	@Override
	public ChatRoomJoin findRoomMember(ChatRoomJoin chatroom) {
		return dao.findRoomMember(chatroom);
	}

	@Override
	public ArrayList<ChatMessage> findRoomMessages(ChatRoomJoin chatroom) {
		return dao.findRoomMessages(chatroom);
	}

	@Override
	public ChatRoom findRoom(ChatRoom chatroom) {
		return dao.findRoom(chatroom);
	}

	@Override
	public int setMsgDB(ChatMessage message) {
		return dao.setMsgDB(message);
	}

	@Override
	public int selectChatNo() {
		return dao.selectChatNo();
	}

	@Override
	public int roomDelete(int group_no) {
		return dao.roomDelete(group_no);
	}

	@Override
	public ArrayList<ChatRoom> joinRoomsList(ChatRoom selRoom) {
		return dao.joinRoomsList(selRoom);
	}

	@Override
	public int secessionRoomJoin(ChatRoomJoin member) {
		return dao.secessionRoomJoin(member);
	}

	
}
