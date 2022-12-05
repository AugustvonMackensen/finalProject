package com.andamiro.gammi.chatting.vo;

import java.io.Serializable;
import java.sql.Date;

public class GroupNotice implements Serializable{
	private static final long serialVersionUID = -1548547285263928352L;
	
	private int gn_no;
	private int group_no;
	private String gn_writer;
	private String gn_content;
	private Date gn_date;
	public GroupNotice() {
		super();
	}
	public GroupNotice(int gn_no, int group_no, String gn_writer, String gn_content, Date gn_date) {
		super();
		this.gn_no = gn_no;
		this.group_no = group_no;
		this.gn_writer = gn_writer;
		this.gn_content = gn_content;
		this.gn_date = gn_date;
	}
	public int getGn_no() {
		return gn_no;
	}
	public void setGn_no(int gn_no) {
		this.gn_no = gn_no;
	}
	public int getGroup_no() {
		return group_no;
	}
	public void setGroup_no(int group_no) {
		this.group_no = group_no;
	}
	public String getGn_writer() {
		return gn_writer;
	}
	public void setGn_writer(String gn_writer) {
		this.gn_writer = gn_writer;
	}
	public String getGn_content() {
		return gn_content;
	}
	public void setGn_content(String gn_content) {
		this.gn_content = gn_content;
	}
	public Date getGn_date() {
		return gn_date;
	}
	public void setGn_date(Date gn_date) {
		this.gn_date = gn_date;
	}
	@Override
	public String toString() {
		return "GroupNotice [gn_no=" + gn_no + ", group_no=" + group_no + ", gn_writer=" + gn_writer + ", gn_content="
				+ gn_content + ", gn_date=" + gn_date + "]";
	}
	
}
