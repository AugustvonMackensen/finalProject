package com.andamiro.gammi.recipe.vo;

import java.sql.Date;

public class Recipe implements java.io.Serializable {

	private static final long serialVersionUID = -7496705597809817558L;

	private int recipe_num; // 레시피 번호
	private String recipe_title; // 레시피 제목
	private String recipe_img; // 레시피 이미지 URL
	private String recipe_url; // 레시피경로
	private int recipe_readcount; // 조회수
	private int recipe_readcount_week; // 주간 조회수

	public Recipe() {
		super();
	}

	public Recipe(int recipe_num, String recipe_title, String recipe_img, String recipe_url, int recipe_readcount,
			int recipe_readcount_week) {
		super();
		this.recipe_num = recipe_num;
		this.recipe_title = recipe_title;
		this.recipe_img = recipe_img;
		this.recipe_url = recipe_url;
		this.recipe_readcount = recipe_readcount;
		this.recipe_readcount_week = recipe_readcount_week;
	}

	public int getRecipe_num() {
		return recipe_num;
	}

	public void setRecipe_num(int recipe_num) {
		this.recipe_num = recipe_num;
	}

	public String getRecipe_title() {
		return recipe_title;
	}

	public void setRecipe_title(String recipe_title) {
		this.recipe_title = recipe_title;
	}

	public String getRecipe_img() {
		return recipe_img;
	}

	public void setRecipe_img(String recipe_img) {
		this.recipe_img = recipe_img;
	}

	public String getRecipe_url() {
		return recipe_url;
	}

	public void setRecipe_url(String recipe_url) {
		this.recipe_url = recipe_url;
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

	@Override
	public String toString() {
		return "Recipe [recipe_num=" + recipe_num + ", recipe_title=" + recipe_title + ", recipe_img=" + recipe_img
				+ ", recipe_url=" + recipe_url + ", recipe_readcount=" + recipe_readcount + ", recipe_readcount_week="
				+ recipe_readcount_week + "]";
	}

}