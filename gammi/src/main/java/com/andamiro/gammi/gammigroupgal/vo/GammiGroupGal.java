package com.andamiro.gammi.gammigroupgal.vo;

import java.io.Serializable;
import java.sql.Date;

public class GammiGroupGal implements Serializable {
	private static final long serialVersionUID = -7005702887092174747L;
	
	private int gal_no;
	private int group_no;
	private String gal_id;
	private String gal_title;
	private Date gal_date;
	private String gal_content;
	private String gal_original_image;
	private String gal_rename_image;
	
	
	public GammiGroupGal() {
		super();
	}
	
	public GammiGroupGal(int gal_no, int group_no, String gal_id, String gal_title, Date gal_date, String gal_content,
			String gal_original_image, String gal_rename_image) {
		super();
		this.gal_no = gal_no;
		this.group_no = group_no;
		this.gal_id = gal_id;
		this.gal_title = gal_title;
		this.gal_date = gal_date;
		this.gal_content = gal_content;
		this.gal_original_image = gal_original_image;
		this.gal_rename_image = gal_rename_image;
	}





	public int getGal_no() {
		return gal_no;
	}


	public void setGal_no(int gal_no) {
		this.gal_no = gal_no;
	}


	public int getGroup_no() {
		return group_no;
	}


	public void setGroup_no(int group_no) {
		this.group_no = group_no;
	}


	public String getGal_id() {
		return gal_id;
	}


	public void setGal_id(String gal_id) {
		this.gal_id = gal_id;
	}


	public String getGal_title() {
		return gal_title;
	}


	public void setGal_title(String gal_title) {
		this.gal_title = gal_title;
	}


	public Date getGal_date() {
		return gal_date;
	}


	public void setGal_date(Date gal_date) {
		this.gal_date = gal_date;
	}


	public String getGal_content() {
		return gal_content;
	}


	public void setGal_content(String gal_content) {
		this.gal_content = gal_content;
	}


	public String getGal_original_image() {
		return gal_original_image;
	}


	public void setGal_original_image(String gal_original_image) {
		this.gal_original_image = gal_original_image;
	}


	public String getGal_rename_image() {
		return gal_rename_image;
	}


	public void setGal_rename_image(String gal_rename_image) {
		this.gal_rename_image = gal_rename_image;
	}


	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	@Override
	public String toString() {
		return "GammiGroupGal [gal_no=" + gal_no + ", group_no=" + group_no + ", gal_id=" + gal_id + ", gal_title="
				+ gal_title + ", gal_date=" + gal_date + ", gal_content=" + gal_content + ", gal_original_image="
				+ gal_original_image + ", gal_rename_image=" + gal_rename_image + "]";
	}
	
}
