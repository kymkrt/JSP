package study2.mapping;

import java.io.IOException;
import java.rmi.ServerException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class DoInputOkCommand implements DoInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServerException, IOException {
		System.out.println("이곳은 DoInputOkCommand 입니다 ");
		
		//앞의 회원가입시 등록된 자료를 모두 받아서 유효성 검사후 DB에 저장완료시킨다
		
		request.setAttribute("message", "회원가입에 성공하셨습니다");
		request.setAttribute("msg", "DoInputOkCommand");
	}

}
