package com.andamiro.gammi.chatting.vo;

public class ChatMessage {
	private String roomId;
    private String writer;
    private String message;
	public ChatMessage(String roomId, String writer, String message) {
		super();
		this.roomId = roomId;
		this.writer = writer;
		this.message = message;
	}
	public ChatMessage() {
		super();
	}
	public String getRoomId() {
		return roomId;
	}
	public void setRoomId(String roomId) {
		this.roomId = roomId;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	@Override
	public String toString() {
		return "ChatMessage [roomId=" + roomId + ", writer=" + writer + ", message=" + message + "]";
	}
    
    
}