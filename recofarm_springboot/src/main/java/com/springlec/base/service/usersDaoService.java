package com.springlec.base.service;

import java.util.List;

import com.springlec.base.model.usersDto;

public interface usersDaoService {
	/*
	 * Description : user Dao service 
	 * Detail : 
	 * Date : 2024.04.19
	 * Author : pdg
	 * Update :
	 * 	2024.04.19 by pdg
	 * 	- signUpDao gen.
	 */

	// 회원 조
	public List<usersDto> listDao() throws Exception;
	
	// 회원 가입
	public void signUpDao(
			String userId,
			String userPw,
			String userName,
			String userEmail,
			String userNickname,
			String userMobile
			) throws Exception ;
		
	
}