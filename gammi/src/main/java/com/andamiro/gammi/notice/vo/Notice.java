package com.andamiro.gammi.notice.vo;

import java.sql.Date;

public class Notice implements java.io.Serializable {
	private static final long serialVersionUID = 1365978153616705231L;

	private int notice_num;
	private String notice_writer;
	private String notice_title;
	private String notice_content;
	private String notice_original_filename;
	private String notice_rename_filename;
	private int notice_readcount;
	private Date notice_date;
	
	public Notice() {}

	public Notice(int notice_num, String notice_writer, String notice_title, String notice_content,
			String notice_original_filename, String notice_rename_filename, int notice_readcount, Date notice_date) {
		super();
		this.notice_num = notice_num;
		this.notice_writer = notice_writer;
		this.notice_title = notice_title;
		this.notice_content = notice_content;
		this.notice_original_filename = notice_original_filename;
		this.notice_rename_filename = notice_rename_filename;
		this.notice_readcount = notice_readcount;
		this.notice_date = notice_date;
	}

	public int getNotice_num() {
		return notice_num;
	}

	public void setNotice_num(int notice_num) {
		this.notice_num = notice_num;
	}

	public String getNotice_writer() {
		return notice_writer;
	}

	public void setNotice_writer(String notice_writer) {
		this.notice_writer = notice_writer;
	}

	public String getNotice_title() {
		return notice_title;
	}

	public void setNotice_title(String notice_title) {
		this.notice_title = notice_title;
	}

	public String getNotice_content() {
		return notice_content;
	}

	public void setNotice_content(String notice_content) {
		this.notice_content = notice_content;
	}

	public String getNotice_original_filename() {
		return notice_original_filename;
	}

	public void setNotice_original_filename(String notice_original_filename) {
		this.notice_original_filename = notice_original_filename;
	}

	public String getNotice_rename_filename() {
		return notice_rename_filename;
	}

	public void setNotice_rename_filename(String notice_rename_filename) {
		this.notice_rename_filename = notice_rename_filename;
	}

	public int getNotice_readcount() {
		return notice_readcount;
	}

	public void setNotice_readcount(int notice_readcount) {
		this.notice_readcount = notice_readcount;
	}

	public Date getNotice_date() {
		return notice_date;
	}

	public void setNotice_date(Date notice_date) {
		this.notice_date = notice_date;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	@Override
	public String toString() {
		return "Notice [notice_num=" + notice_num + ", notice_writer=" + notice_writer + ", notice_title="
				+ notice_title + ", notice_content=" + notice_content + ", notice_original_filename="
				+ notice_original_filename + ", notice_rename_filename=" + notice_rename_filename
				+ ", notice_readcount=" + notice_readcount + ", notice_date=" + notice_date + "]";
	}

	
	
	
	
}