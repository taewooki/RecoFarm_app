package com.springlec.base.dao;

import java.util.List;
import com.springlec.base.model.usersDto;

/*
 * Description	: Recofarm service users DB table 정보 가져오기 위한 DAO mapper interface 
 *    Detail 	:
 *    
 *    Date		: 2024.04.19
 *    Author	: Forrest Park (pdg)
 *    Update	: 2024.04.19

 */
public interface usersDao {
	// user 조회  DAO 
	public List<usersDto> listDao() throws Exception;
	
	// user 회원가입 dao 
	public void userSignUpDao(
			String userId,
			String userPw,
			String userName,
			String userEmail,
			String userNickname,
			String userMobile
			) throws Exception ;
	
	
	// list.jsp 에서 글쓰기 버튼을 눌렀을때 게시글(insert ). 
	//public void writeDao(String bName, String bTitle, String bContent) throws Exception;

	// list.jsp 에서 클릭된 게시물의 bId 를 받아서 해당하는 내용(bTitle, bContent) 보여주어야하므로 return 값이 필요함. 
	//public BDto content_view(int bId) throws Exception; 
	
	// content_view.jsp 에서 수정 버튼을 눌렀을 때 DB 에서 해당 bId 를 찾아 update 되는 기능
	//public void updateDao(int bId,String bName, String bTitle, String bContent) throws Exception;
	
}