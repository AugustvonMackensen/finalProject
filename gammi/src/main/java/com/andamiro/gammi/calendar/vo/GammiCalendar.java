package com.andamiro.gammi.calendar.vo;

import java.io.Serializable;
import java.sql.Date;

public class GammiCalendar implements Serializable{
	private static final long serialVersionUID = 3760415508168295813L;

	private int cal_id;
	private int group_no;
	private String cal_writer;
	private String cal_title;
	private String cal_content;
	private Date start_date;
	private Date end_date;
	private int allday;
	public GammiCalendar() {
		super();
	}
	public GammiCalendar(int cal_id, int group_no, String cal_writer, String cal_title, String cal_content,
			Date start_date, Date end_date, int allday) {
		super();
		this.cal_id = cal_id;
		this.group_no = group_no;
		this.cal_writer = cal_writer;
		this.cal_title = cal_title;
		this.cal_content = cal_content;
		this.start_date = start_date;
		this.end_date = end_date;
		this.allday = allday;
	}
	public int getCal_id() {
		return cal_id;
	}
	public void setCal_id(int cal_id) {
		this.cal_id = cal_id;
	}
	public int getGroup_no() {
		return group_no;
	}
	public void setGroup_no(int group_no) {
		this.group_no = group_no;
	}
	public String getCal_writer() {
		return cal_writer;
	}
	public void setCal_writer(String cal_writer) {
		this.cal_writer = cal_writer;
	}
	public String getCal_title() {
		return cal_title;
	}
	public void setCal_title(String cal_title) {
		this.cal_title = cal_title;
	}
	public String getCal_content() {
		return cal_content;
	}
	public void setCal_content(String cal_content) {
		this.cal_content = cal_content;
	}
	public Date getStart_date() {
		return start_date;
	}
	public void setStart_date(Date start_date) {
		this.start_date = start_date;
	}
	public Date getEnd_date() {
		return end_date;
	}
	public void setEnd_date(Date end_date) {
		this.end_date = end_date;
	}
	public int getAllday() {
		return allday;
	}
	public void setAllday(int allday) {
		this.allday = allday;
	}
	@Override
	public String toString() {
		return "GammiCalendar [cal_id=" + cal_id + ", group_no=" + group_no + ", cal_writer=" + cal_writer
				+ ", cal_title=" + cal_title + ", cal_content=" + cal_content + ", start_date=" + start_date
				+ ", end_date=" + end_date + ", allday=" + allday + "]";
	}
}