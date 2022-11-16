package com.andamiro.gammi.gammigroup.vo;

import java.io.Serializable;
import java.sql.Date;

public class GammiGroup implements Serializable{
	private static final long serialVersionUID = -7183350549570502661L;
	
	private int group_no;
	private String group_owner;
	private String group_name;
	private Date group_date;
	private String group_info;
	private String group_img;
	public GammiGroup() {
		super();
	}
	public GammiGroup(int group_no, String group_owner, String group_name, Date group_date, String group_info,
			String group_img) {
		super();
		this.group_no = group_no;
		this.group_owner = group_owner;
		this.group_name = group_name;
		this.group_date = group_date;
		this.group_info = group_info;
		this.group_img = group_img;
	}
	public int getGroup_no() {
		return group_no;
	}
	public void setGroup_no(int group_no) {
		this.group_no = group_no;
	}
	public String getgroup_owner() {
		return group_owner;
	}
	public void setgroup_owner(String group_owner) {
		this.group_owner = group_owner;
	}
	public String getGroup_name() {
		return group_name;
	}
	public void setGroup_name(String group_name) {
		this.group_name = group_name;
	}
	public Date getGroup_date() {
		return group_date;
	}
	public void setGroup_date(Date group_date) {
		this.group_date = group_date;
	}
	public String getGroup_info() {
		return group_info;
	}
	public void setGroup_info(String group_info) {
		this.group_info = group_info;
	}
	public String getGroup_img() {
		return group_img;
	}
	public void setGroup_img(String group_img) {
		this.group_img = group_img;
	}
	@Override
	public String toString() {
		return "GammiGroup [group_no=" + group_no + ", group_owner=" + group_owner + ", group_name=" + group_name
				+ ", group_date=" + group_date + ", group_info=" + group_info + ", group_img=" + group_img + "]";
	}
	
}
