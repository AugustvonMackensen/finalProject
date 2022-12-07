package com.andamiro.gammi.gammigroupgal.vo;

import java.io.Serializable;
import java.sql.Date;

public class GammiGroupGalReply implements Serializable {
	private static final long serialVersionUID = 7599926347042609805L;
	
	private int reply_no;
	private int gal_no;
	private String reply_id;
	private Date reply_date;
	private String reply_content;
	
	public GammiGroupGalReply() {
		super();
	}

	public GammiGroupGalReply(int reply_no, int gal_no, String reply_id, Date reply_date, String reply_content) {
		super();
		this.reply_no = reply_no;
		this.gal_no = gal_no;
		this.reply_id = reply_id;
		this.reply_date = reply_date;
		this.reply_content = reply_content;
	}

	public int getReply_no() {
		return reply_no;
	}

	public void setReply_no(int reply_no) {
		this.reply_no = reply_no;
	}

	public int getGal_no() {
		return gal_no;
	}

	public void setGal_no(int gal_no) {
		this.gal_no = gal_no;
	}

	public String getReply_id() {
		return reply_id;
	}

	public void setReply_id(String reply_id) {
		this.reply_id = reply_id;
	}

	public Date getReply_date() {
		return reply_date;
	}

	public void setReply_date(Date reply_date) {
		this.reply_date = reply_date;
	}

	public String getReply_content() {
		return reply_content;
	}

	public void setReply_content(String reply_content) {
		this.reply_content = reply_content;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	@Override
	public String toString() {
		return "GammiGroupReply [reply_no=" + reply_no + ", gal_no=" + gal_no + ", reply_id=" + reply_id
				+ ", reply_date=" + reply_date + ", reply_content=" + reply_content + "]";
	}
}
