package com.andamiro.gammi.board.vo;

import java.sql.Date;

public class BoardReply implements java.io.Serializable {
	private static final long serialVersionUID = 1365978153616705231L; 
	
	
	private int br_no;
	private int b_no;
	private String br_id;
	private Date br_date;
	private String br_content;

    public BoardReply(){}

	public BoardReply(int br_no, int b_no, String br_id, Date br_date, String br_content) {
		super();
		this.br_no = br_no;
		this.b_no = b_no;
		this.br_id = br_id;
		this.br_date = br_date;
		this.br_content = br_content;
	}

	public int getBr_no() {
		return br_no;
	}

	public void setBr_no(int br_no) {
		this.br_no = br_no;
	}

	public int getB_no() {
		return b_no;
	}

	public void setB_no(int b_no) {
		this.b_no = b_no;
	}

	public String getBr_id() {
		return br_id;
	}

	public void setBr_id(String br_id) {
		this.br_id = br_id;
	}

	public Date getBr_date() {
		return br_date;
	}

	public void setBr_date(Date br_date) {
		this.br_date = br_date;
	}

	public String getBr_content() {
		return br_content;
	}

	public void setBr_content(String br_content) {
		this.br_content = br_content;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	@Override
	public String toString() {
		return "BoardReply [br_no=" + br_no + ", b_no=" + b_no + ", br_id=" + br_id + ", br_date=" + br_date
				+ ", br_content=" + br_content + "]";
	}

	
}