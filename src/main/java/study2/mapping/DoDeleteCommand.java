package study2.mapping;

import java.io.IOException;
import java.rmi.ServerException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class DoDeleteCommand implements DoInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServerException, IOException {
		System.out.println("이곳은 DoDeleteCommand 입니다");
		request.setAttribute("msg2", "DoDeleteCommand");	}

}
