package study2.mapping;

import java.io.IOException;
import java.rmi.ServerException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class DoListCommand implements DoInterface {
	//서비스객체=커맨드 객체(커맨드 패턴으로 만든 객체)
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServerException, IOException {
		System.out.println("이곳은 DoListCommand 입니다");
		//이렇게 보낸걸 컨트롤러의 response가 받는다
		request.setAttribute("msg2", "DoListCommand");
	}

}
