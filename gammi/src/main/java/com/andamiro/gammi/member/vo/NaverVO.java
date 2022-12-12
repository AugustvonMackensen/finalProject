package com.andamiro.gammi.member.vo;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class NaverVO implements java.io.Serializable{
	
	private static final long serialVersionUID = -2027767816623829633L;
	private String username;
	private String email;
	private String userid;
	
	public NaverVO() {}
	
	public NaverVO(String username, String email, String userid) {
		super();
		this.username = username;
		this.email = email;
		this.userid = userid;
	}

	@Override
	public String toString() {
		return "NaverVO [username=" + username + ", email=" + email + ", userid=" + userid + "]";
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
}
