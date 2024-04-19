package com.springlec.base.model;

public class usersDto {

	/*
	 * Description : Dto model for users Author : pdg
	 * 
	 */
	// Field
	String userId;
	String userPw;
	String userName;
	String userEmail;
	String userNickname;
	String userMobile;
	String create_date;
	String modify_date;

	// Constructor
	public usersDto() {
		// TODO Auto-generated method stub

	}

	public usersDto(String userId, String userPw, String userName, String userEmail, String userNickname,
			String userMobile, String create_date, String modify_date) {
		super();
		this.userId = userId;
		this.userPw = userPw;
		this.userName = userName;
		this.userEmail = userEmail;
		this.userNickname = userNickname;
		this.userMobile = userMobile;
		this.create_date = create_date;
		this.modify_date = modify_date;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getUserPw() {
		return userPw;
	}

	public void setUserPw(String userPw) {
		this.userPw = userPw;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getUserEmail() {
		return userEmail;
	}

	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}

	public String getUserNickname() {
		return userNickname;
	}

	public void setUserNickname(String userNickname) {
		this.userNickname = userNickname;
	}

	public String getUserMobile() {
		return userMobile;
	}

	public void setUserMobile(String userMobile) {
		this.userMobile = userMobile;
	}

	public String getCreate_date() {
		return create_date;
	}

	public void setCreate_date(String create_date) {
		this.create_date = create_date;
	}

	public String getModify_date() {
		return modify_date;
	}

	public void setModify_date(String modify_date) {
		this.modify_date = modify_date;
	}

}
