package com.springlec.base.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.springlec.base.dao.usersDao;
import com.springlec.base.model.usersDto;
/*
 * Description 	: user sign up dao service interface
 * 		Detail 	:  
 * 		Date	: 2024.04.19
 * 		Author 	: pdg
 * 		Update	:
 * 			2024.04.19 by pdg
 * 				- user sign up dao 

 */
@Service
public class usersDaoServiceImpl implements usersDaoService{
	 	
	@Autowired
	usersDao dao;
	
	@Override
	public List<usersDto> listDao() throws Exception {
		System.out.println(">> listDao(impl) 실행");
		return dao.listDao(); // Select 조회 결과물을 반환
		
	}

	// 회원 가입 -> Insert action  
	@Override
	public void signUpDao(
			
			String userId,
			String userPw,
			String userName,
			String userEmail,
			String userNickname,
			String userMobile
			) throws Exception {
		System.out.println(">> userDaoService Implement 실행");
		
		dao.userSignUpDao(
			userId,
			userPw,
			userName,
			userEmail,
			userNickname,
			userMobile
				);
		
	}
} // END



