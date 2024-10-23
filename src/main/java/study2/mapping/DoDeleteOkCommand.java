package study2.mapping;

import java.io.IOException;
import java.rmi.ServerException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public record DoDeleteOkCommand() implements DoInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServerException, IOException {
		System.out.println("이곳은 DoDeleteOkCommand 입니다");
		
	//이건 기차가 멈춘게 아니라 계속 가고 있는거다
		//현재 등록된 회원의 정보를 DB에서 삭제 처리한다
		request.setAttribute("message", "회원에서 탈퇴되었습니다");
		request.setAttribute("url", "/study2/mapping/Test2"); //이제는 무조건 컨트롤러로 보내야한다 
	}
	
}
