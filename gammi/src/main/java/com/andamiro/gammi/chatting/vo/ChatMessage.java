package com.andamiro.gammi.chatting.vo;

import java.io.Serializable;
import java.sql.Date;

public class ChatMessage implements Serializable{
	private static final long serialVersionUID = -1601393392366526568L;
	private int cm_no;
    private String m_id;
    private int chatroom_no;
    private String message;
    private Date cm_time ;
	public ChatMessage() {
		super();
	}
	public ChatMessage(int cm_no, String m_id, int chatroom_no, String message, Date cm_time) {
		super();
		this.cm_no = cm_no;
		this.m_id = m_id;
		this.chatroom_no = chatroom_no;
		this.message = message;
		this.cm_time = cm_time;
	}
	public int getCm_no() {
		return cm_no;
	}
	public void setCm_no(int cm_no) {
		this.cm_no = cm_no;
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
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public Date getCm_time() {
		return cm_time;
	}
	public void setCm_time(Date cm_time) {
		this.cm_time = cm_time;
	}
	@Override
	public String toString() {
		return "ChatMessage [cm_no=" + cm_no + ", m_id=" + m_id + ", chatroom_no=" + chatroom_no + ", message="
				+ message + ", cm_time=" + cm_time + "]";
	}
}