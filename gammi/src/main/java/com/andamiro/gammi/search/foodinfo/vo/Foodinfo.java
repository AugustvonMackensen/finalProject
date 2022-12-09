package com.andamiro.gammi.search.foodinfo.vo;

import java.io.Serializable;

public class Foodinfo implements Serializable{
	private static final long serialVersionUID = 4022987722398720486L;
	
	private int food_no;
	private String food_name;
	private String food_content;
	private String recipe_img;
	
	public Foodinfo() {}

	public String getRecipe_img() {
		return recipe_img;
	}

	public void setRecipe_img(String recipe_img) {
		this.recipe_img = recipe_img;
	}

	public Foodinfo(int food_no, String food_name, String food_content, String recipe_img) {
		super();
		this.food_no = food_no;
		this.food_name = food_name;
		this.food_content = food_content;
		this.recipe_img = recipe_img;
	}

	public Foodinfo(int food_no, String food_name, String food_content) {
		this.food_no = food_no;
		this.food_name = food_name;
		this.food_content = food_content;
	}

	public int getFood_no() {
		return food_no;
	}

	public void setFood_no(int food_no) {
		this.food_no = food_no;
	}

	public String getFood_name() {
		return food_name;
	}

	public void setFood_name(String food_name) {
		this.food_name = food_name;
	}

	public String getFood_content() {
		return food_content;
	}

	public void setFood_content(String food_content) {
		this.food_content = food_content;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	@Override
	public String toString() {
		return "Foodinfo [food_no=" + food_no + ", food_name=" + food_name + ", food_content=" + food_content
				+ ", recipe_img=" + recipe_img + "]";
	}

	
}
