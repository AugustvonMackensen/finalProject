package com.andamiro.gammi.chatting.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.andamiro.gammi.chatting.vo.ChatMessage;
import com.andamiro.gammi.chatting.vo.ChatRoom;
import com.andamiro.gammi.chatting.vo.ChatRoomJoin;

@Repository("chattingDao")
public class ChattingDao {
	
	@Autowired
	private SqlSessionTemplate session;
	
	public ArrayList<ChatRoom> allList(int gno) {
		List<ChatRoom> list =session.selectList("chattingMapper.selectAllList",gno); 
		return (ArrayList<ChatRoom>)list;
	}

	public int createChatRoom(ChatRoom room) {
		return session.insert("chattingMapper.createChatRoom",room);
	}
	
	public int createChatJoin(ChatRoomJoin room) {
		return session.insert("chattingMapper.createChatRoomJoin",room);
	}
	
	public ChatRoomJoin findRoomMember(ChatRoomJoin chatroom) {
		return session.selectOne("chattingMapper.findRoomMember",chatroom);
	}

	public ArrayList<ChatMessage> findRoomMessages(ChatRoomJoin chatroom) {
		List<ChatMessage> list =session.selectList("chattingMapper.selectAllMessage",chatroom); 
		return (ArrayList<ChatMessage>)list;
	}

	public ChatRoom findRoom(ChatRoom chatroom) {
		return session.selectOne("chattingMapper.findRoom",chatroom);
	}

	public int setMsgDB(ChatMessage message) {
		return session.insert("chattingMapper.setMsgDb",message);
	}

	public int selectChatNo() {
		if(session.selectOne("chattingMapper.selectChatNo")==null) {
			return 0;
		}else
			return session.selectOne("chattingMapper.selectChatNo");
	}

	public int roomDelete(int group_no) {
		return session.delete("chattingMapper.roomDelete", group_no);
	}


}