package com.andamiro.gammi.member.vo;

import java.sql.Date;

public class Member implements java.io.Serializable{ 
	
	private static final long serialVersionUID = -6334101746276490233L;
	public String m_name;
	public String m_id;
	public String m_nickname;
	public String m_pw;
	public String m_email;
	public String m_birth;
	public String admin;
	public String login_ok;
	
	public Member() {}

	public Member(String m_name, String m_id, String m_nickname, String m_pw, String m_email, String m_birth,
			String admin, String login_ok) {
		super();
		this.m_name = m_name;
		this.m_id = m_id;
		this.m_nickname = m_nickname;
		this.m_pw = m_pw;
		this.m_email = m_email;
		this.m_birth = m_birth;
		this.admin = admin;
		this.login_ok = login_ok;
	}

	public String getM_name() {
		return m_name;
	}

	public void setM_name(String m_name) {
		this.m_name = m_name;
	}

	public String getM_id() {
		return m_id;
	}

	public void setM_id(String m_id) {
		this.m_id = m_id;
	}

	public String getM_nickname() {
		return m_nickname;
	}

	public void setM_nickname(String m_nickname) {
		this.m_nickname = m_nickname;
	}

	public String getM_pw() {
		return m_pw;
	}

	public void setM_pw(String m_pw) {
		this.m_pw = m_pw;
	}

	public String getM_email() {
		return m_email;
	}

	public void setM_email(String m_email) {
		this.m_email = m_email;
	}

	public String getM_birth() {
		return m_birth;
	}

	public void setM_birth(String m_birth) {
		this.m_birth = m_birth;
	}

	public String getAdmin() {
		return admin;
	}

	public void setAdmin(String admin) {
		this.admin = admin;
	}

	public String getLogin_ok() {
		return login_ok;
	}

	public void setLogin_ok(String login_ok) {
		this.login_ok = login_ok;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	@Override
	public String toString() {
		return "Member [m_name=" + m_name + ", m_id=" + m_id + ", m_nickname=" + m_nickname + ", m_pw=" + m_pw
				+ ", m_email=" + m_email + ", m_birth=" + m_birth + ", admin=" + admin + ", login_ok=" + login_ok + "]";
	}

	

	


	
	
	
	
	
	
	
	
	
}
