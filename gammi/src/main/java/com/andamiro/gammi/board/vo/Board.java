package com.andamiro.gammi.board.vo;

import java.sql.Date;

public class Board implements java.io.Serializable {
	private static final long serialVersionUID = 1365978153616705231L; 
	
	private int b_no;
	private String b_writer;
	private String  b_title;
	private Date b_date;
	private String b_content;
	private String b_upfile;
	private int b_readcount;
	private String b_original_image;
	private String b_rename_image;
	
	public Board() {
		super();
	}
	
	
	@Override
	public String toString() {
		return "Board [b_no=" + b_no + ", b_writer=" + b_writer + ", b_title=" + b_title + ", b_date=" + b_date
				+ ", b_content=" + b_content + ", b_upfile=" + b_upfile + ", b_readcount=" + b_readcount
				+ ", b_original_image=" + b_original_image + ", b_rename_image=" + b_rename_image + "]";
	}

	public Board(int b_no, String b_writer, String b_title, Date b_date, String b_content, String b_upfile,
			int b_readcount, String b_original_image, String b_rename_image) {
		super();
		this.b_no = b_no;
		this.b_writer = b_writer;
		this.b_title = b_title;
		this.b_date = b_date;
		this.b_content = b_content;
		this.b_upfile = b_upfile;
		this.b_readcount = b_readcount;
		this.b_original_image = b_original_image;
		this.b_rename_image = b_rename_image;
	}

	public int getB_no() {
		return b_no;
	}

	public void setB_no(int b_no) {
		this.b_no = b_no;
	}

	public String getB_writer() {
		return b_writer;
	}

	public void setB_writer(String b_writer) {
		this.b_writer = b_writer;
	}

	public String getB_title() {
		return b_title;
	}

	public void setB_title(String b_title) {
		this.b_title = b_title;
	}

	public Date getB_date() {
		return b_date;
	}

	public void setB_date(Date b_date) {
		this.b_date = b_date;
	}

	public String getB_content() {
		return b_content;
	}

	public void setB_content(String b_content) {
		this.b_content = b_content;
	}

	public String getB_upfile() {
		return b_upfile;
	}

	public void setB_upfile(String b_upfile) {
		this.b_upfile = b_upfile;
	}

	public int getB_readcount() {
		return b_readcount;
	}

	public void setB_readcount(int b_readcount) {
		this.b_readcount = b_readcount;
	}

	public String getB_original_image() {
		return b_original_image;
	}

	public void setB_original_image(String b_original_image) {
		this.b_original_image = b_original_image;
	}

	public String getB_rename_image() {
		return b_rename_image;
	}

	public void setB_rename_image(String b_rename_image) {
		this.b_rename_image = b_rename_image;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}
}