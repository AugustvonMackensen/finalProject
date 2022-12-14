package com.andamiro.gammi.gammigroup.vo;

import java.io.Serializable;
import java.sql.Date;

public class GroupMember implements Serializable{
	private static final long serialVersionUID = 5109671732413668689L;

	private int join_no;
	private int group_no;
	private String m_id;
	private int member_grade;		//1신청 2거절 3일반회원 4모임장
	private Date member_grade_date;
	public GroupMember() {
		super();
	}
	public GroupMember(int join_no, int group_no, String m_id, int member_grade, Date member_grade_date) {
		super();
		this.join_no = join_no;
		this.group_no = group_no;
		this.m_id = m_id;
		this.member_grade = member_grade;
		this.member_grade_date = member_grade_date;
	}
	public int getJoin_no() {
		return join_no;
	}
	public void setJoin_no(int join_no) {
		this.join_no = join_no;
	}
	public int getGroup_no() {
		return group_no;
	}
	public void setGroup_no(int group_no) {
		this.group_no = group_no;
	}
	public String getM_id() {
		return m_id;
	}
	public void setM_id(String m_id) {
		this.m_id = m_id;
	}
	public int getMember_grade() {
		return member_grade;
	}
	public void setMember_grade(int member_grade) {
		this.member_grade = member_grade;
	}
	public Date getMember_grade_date() {
		return member_grade_date;
	}
	public void setMember_grade_date(Date member_grade_date) {
		this.member_grade_date = member_grade_date;
	}
	@Override
	public String toString() {
		return "GroupMember [join_no=" + join_no + ", group_no=" + group_no + ", m_id=" + m_id + ", member_grade="
				+ member_grade + ", member_grade_date=" + member_grade_date + "]";
	}
}
