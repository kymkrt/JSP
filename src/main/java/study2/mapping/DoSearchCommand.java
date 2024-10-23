package study2.mapping;

import java.io.IOException;
import java.rmi.ServerException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class DoSearchCommand implements DoInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServerException, IOException {
		
		System.out.println("이곳은 DoSearchCommand 입니다");
		//이렇게 보낸걸 컨트롤러의 response가 받는다
		request.setAttribute("msg2", "DoSearchCommand");
	}

}
