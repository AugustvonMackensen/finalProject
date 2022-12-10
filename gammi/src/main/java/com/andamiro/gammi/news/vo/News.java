package com.andamiro.gammi.news.vo;

import java.io.Serializable;

public class News implements Serializable{
	private static final long serialVersionUID = 7580320034342665898L;
	
	private int news_no;
	private String news_title;
	private String news_date;
	private String news_link;
	public News() {
		super();
	}
	public News(int news_no, String news_title, String news_date, String news_link) {
		super();
		this.news_no = news_no;
		this.news_title = news_title;
		this.news_date = news_date;
		this.news_link = news_link;
	}
	public int getNews_no() {
		return news_no;
	}
	public void setNews_no(int news_no) {
		this.news_no = news_no;
	}
	public String getNews_title() {
		return news_title;
	}
	public void setNews_title(String news_title) {
		this.news_title = news_title;
	}
	public String getNews_date() {
		return news_date;
	}
	public void setNews_date(String news_date) {
		this.news_date = news_date;
	}
	public String getNews_link() {
		return news_link;
	}
	public void setNews_link(String news_link) {
		this.news_link = news_link;
	}
	@Override
	public String toString() {
		return "News [news_no=" + news_no + ", news_title=" + news_title + ", news_date=" + news_date + ", news_link="
				+ news_link + "]";
	}
}
