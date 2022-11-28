package com.andamiro.gammi.chatting.vo;

import java.io.Serializable;
import java.sql.Date;

public class ChatRoomJoin implements Serializable{
	private static final long serialVersionUID = 5949110297558100466L;
	private int join_no;
	private String m_id;
	private int chatroom_no;
	private Date chatjoin_date;
	public ChatRoomJoin() {
		super();
	}
	public ChatRoomJoin(int join_no, String m_id, int chatroom_no, Date chatjoin_date) {
		super();
		this.join_no = join_no;
		this.m_id = m_id;
		this.chatroom_no = chatroom_no;
		this.chatjoin_date = chatjoin_date;
	}
	public int getJoin_no() {
		return join_no;
	}
	public void setJoin_no(int join_no) {
		this.join_no = join_no;
	}
	public String getM_id() {
		return m_id;
	}
	public void setM_id(String m_id) {
		this.m_id = m_id;
	}
	public int getChatroom_no() {
		return chatroom_no;
	}
	public void setChatroom_no(int chatroom_no) {
		this.chatroom_no = chatroom_no;
	}
	public Date getChatjoin_date() {
		return chatjoin_date;
	}
	public void setChatjoin_date(Date chatjoin_date) {
		this.chatjoin_date = chatjoin_date;
	}
	@Override
	public String toString() {
		return "ChatRoomJoin [join_no=" + join_no + ", m_id=" + m_id + ", chatroom_no=" + chatroom_no
				+ ", chatjoin_date=" + chatjoin_date + "]";
	}
   
}
