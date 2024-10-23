package study2.mapping;

import java.io.IOException;
import java.rmi.ServerException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class DoUpdateOkCommand implements DoInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServerException, IOException {
		System.out.println("이곳은 DoUpdateOkCommand 입니다");
		
		//수정처리한 정보들을 DB에 다시 업데이트 처리하고 돌아온다
		
		//이건 기차가 멈춘게 아니라 계속 가고 있는거다
		request.setAttribute("message", "회원정보가 수정되었습니다");
		request.setAttribute("url", "/study2/mapping/Test2"); //이제는 무조건 컨트롤러로 보내야한다 
		
	}

}
