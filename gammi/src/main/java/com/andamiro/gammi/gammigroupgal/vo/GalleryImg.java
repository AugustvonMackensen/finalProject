package com.andamiro.gammi.gammigroupgal.vo;

import java.io.Serializable;

public class GalleryImg implements Serializable{
	private static final long serialVersionUID = -7826407514487556982L;
	
	private int galimg_no;
	private int gal_no;
	private String gal_ori_image;
	private String gal_rename_image;
	public GalleryImg() {
		super();
	}
	public GalleryImg(int galimg_no, int gal_no, String gal_ori_image, String gal_rename_image) {
		super();
		this.galimg_no = galimg_no;
		this.gal_no = gal_no;
		this.gal_ori_image = gal_ori_image;
		this.gal_rename_image = gal_rename_image;
	}
	public int getGalimg_no() {
		return galimg_no;
	}
	public void setGalimg_no(int galimg_no) {
		this.galimg_no = galimg_no;
	}
	public int getGal_no() {
		return gal_no;
	}
	public void setGal_no(int gal_no) {
		this.gal_no = gal_no;
	}
	public String getGal_ori_image() {
		return gal_ori_image;
	}
	public void setGal_ori_image(String gal_ori_image) {
		this.gal_ori_image = gal_ori_image;
	}
	public String getGal_rename_image() {
		return gal_rename_image;
	}
	public void setGal_rename_image(String rename_image) {
		this.gal_rename_image = rename_image;
	}
	@Override
	public String toString() {
		return "GalleryImg [galimg_no=" + galimg_no + ", gal_no=" + gal_no + ", gal_ori_image=" + gal_ori_image
				+ ", gal_rename_image=" + gal_rename_image + "]";
	}
}
