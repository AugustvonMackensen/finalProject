package com.andamiro.gammi.foodinfo.vo;

import java.io.Serializable;

public class FoodInfo implements Serializable{
	
	private static final long serialVersionUID = -8413091150741850513L;
	private int food_no;
	private String food_name;
	private String food_content;
	
	public FoodInfo() {
		super();
	}

	public FoodInfo(int food_no, String food_name, String food_content) {
		super();
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
		return "FoodInfo [food_no=" + food_no + ", food_name=" + food_name + ", food_content=" + food_content + "]";
	}
	
	
	
}
