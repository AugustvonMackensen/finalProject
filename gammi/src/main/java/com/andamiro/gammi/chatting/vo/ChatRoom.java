package com.andamiro.gammi.chatting.vo;

import java.io.Serializable;
import java.sql.Date;
import java.util.HashSet;
import java.util.Set;
import java.util.UUID;

import org.springframework.web.socket.WebSocketSession;

public class ChatRoom implements Serializable{
	private static final long serialVersionUID = 3505595206576809954L;
	private int chatroom_no;
	private int group_no;
	private String m_id;
	private String chatroom_name;
	private Date chatrom_date;
    private Set<WebSocketSession> sessions = new HashSet<>();
	public ChatRoom() {
		super();
	}
	public ChatRoom(int chatroom_no, int group_no, String m_id, String chatroom_name, Date chatrom_date) {
		super();
		this.chatroom_no = chatroom_no;
		this.group_no = group_no;
		this.m_id = m_id;
		this.chatroom_name = chatroom_name;
		this.chatrom_date = chatrom_date;
	}
	public int getChatroom_no() {
		return chatroom_no;
	}
	public void setChatroom_no(int chatroom_no) {
		this.chatroom_no = chatroom_no;
	}
	public int getGroup_no() {
		return group_no;
	}
	public void setGroup_no(int group_no) {
		this.group_no = group_no;
	}
	public String getM_id() {
		return m_id;
	}
	public void setM_id(String m_id) {
		this.m_id = m_id;
	}
	public String getChatroom_name() {
		return chatroom_name;
	}
	public void setChatroom_name(String chatroom_name) {
		this.chatroom_name = chatroom_name;
	}
	public Date getChatrom_date() {
		return chatrom_date;
	}
	public void setChatrom_date(Date chatrom_date) {
		this.chatrom_date = chatrom_date;
	}
	public Set<WebSocketSession> getSessions() {
		return sessions;
	}
	public void setSessions(Set<WebSocketSession> sessions) {
		this.sessions = sessions;
	}
	@Override
	public String toString() {
		return "ChatRoom [chatroom_no=" + chatroom_no + ", group_no=" + group_no + ", m_id=" + m_id + ", chatroom_name="
				+ chatroom_name + ", chatrom_date=" + chatrom_date + ", sessions=" + sessions + "]";
	}

	/*
	 * public static ChatRoom create(String name) { ChatRoom chatRoom = new
	 * ChatRoom(); chatRoom.roomId = UUID.randomUUID().toString(); chatRoom.name =
	 * name; return chatRoom; }
	 */

    
}
