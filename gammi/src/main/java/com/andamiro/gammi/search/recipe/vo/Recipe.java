package com.andamiro.gammi.search.recipe.vo;

import java.io.Serializable;
import java.sql.Date;

public class Recipe implements Serializable{
	private static final long serialVersionUID = -2066891851310066505L;
	
	private int recipe_num; // 레시피 번호
	private String recipe_writer; // 레시피 작성자 아이디
	private String recipe_title; // 레시피 제목
	private String recipe_content; // 레시피 내용
	private String recipe_original_imgname; // 이미지파일 원래이름
	private String recipe_rename_imgname; // 이미지파일 바뀐이름
	private int recipe_readcount; // 조회수 (상세보기한 횟수)
	private int recipe_readcount_week; // 주간 조회수
	private Date recipe_date; // 레시피 등록날짜a
	
	public Recipe() {
		super();
	}
	public Recipe(int recipe_num, String recipe_writer, String recipe_title, String recipe_content,
			String recipe_original_imgname, String recipe_rename_imgname, int recipe_readcount,
			int recipe_readcount_week, Date recipe_date) {
		super();
		this.recipe_num = recipe_num;
		this.recipe_writer = recipe_writer;
		this.recipe_title = recipe_title;
		this.recipe_content = recipe_content;
		this.recipe_original_imgname = recipe_original_imgname;
		this.recipe_rename_imgname = recipe_rename_imgname;
		this.recipe_readcount = recipe_readcount;
		this.recipe_readcount_week = recipe_readcount_week;
		this.recipe_date = recipe_date;
	}
	public int getRecipe_num() {
		return recipe_num;
	}
	public void setRecipe_num(int recipe_num) {
		this.recipe_num = recipe_num;
	}
	public String getRecipe_writer() {
		return recipe_writer;
	}
	public void setRecipe_writer(String recipe_writer) {
		this.recipe_writer = recipe_writer;
	}
	public String getRecipe_title() {
		return recipe_title;
	}
	public void setRecipe_title(String recipe_title) {
		this.recipe_title = recipe_title;
	}
	public String getRecipe_content() {
		return recipe_content;
	}
	public void setRecipe_content(String recipe_content) {
		this.recipe_content = recipe_content;
	}
	public String getRecipe_original_imgname() {
		return recipe_original_imgname;
	}
	public void setRecipe_original_imgname(String recipe_original_imgname) {
		this.recipe_original_imgname = recipe_original_imgname;
	}
	public String getRecipe_rename_imgname() {
		return recipe_rename_imgname;
	}
	public void setRecipe_rename_imgname(String recipe_rename_imgname) {
		this.recipe_rename_imgname = recipe_rename_imgname;
	}
	public int getRecipe_readcount() {
		return recipe_readcount;
	}
	public void setRecipe_readcount(int recipe_readcount) {
		this.recipe_readcount = recipe_readcount;
	}
	public int getRecipe_readcount_week() {
		return recipe_readcount_week;
	}
	public void setRecipe_readcount_week(int recipe_readcount_week) {
		this.recipe_readcount_week = recipe_readcount_week;
	}
	public Date getRecipe_date() {
		return recipe_date;
	}
	public void setRecipe_date(Date recipe_date) {
		this.recipe_date = recipe_date;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	@Override
	public String toString() {
		return "Recipe [recipe_num=" + recipe_num + ", recipe_writer=" + recipe_writer + ", recipe_title="
				+ recipe_title + ", recipe_content=" + recipe_content + ", recipe_original_imgname="
				+ recipe_original_imgname + ", recipe_rename_imgname=" + recipe_rename_imgname + ", recipe_readcount="
				+ recipe_readcount + ", recipe_readcount_week=" + recipe_readcount_week + ", recipe_date=" + recipe_date
				+ "]";
	}
	
	
	
}
