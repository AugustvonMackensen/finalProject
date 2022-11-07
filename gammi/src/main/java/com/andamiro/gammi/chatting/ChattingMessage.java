package com.andamiro.gammi.chatting;

public class ChattingMessage {
	private String from;
	private String text;
	public ChattingMessage() {
		super();
	}
	public ChattingMessage(String from, String text) {
		super();
		this.from = from;
		this.text = text;
	}
	public String getFrom() {
		return from;
	}
	public void setFrom(String from) {
		this.from = from;
	}
	public String getText() {
		return text;
	}
	public void setText(String text) {
		this.text = text;
	}
	@Override
	public String toString() {
		return "ChattingMessage [from=" + from + ", text=" + text + "]";
	}
	
}
