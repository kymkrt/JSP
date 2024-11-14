package study2.uuid;

import java.io.IOException;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import study2.StudyInterface;

public class UuidFormOkCommand implements StudyInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//랜덤하게 생성
		UUID uid = UUID.randomUUID();//워낙 많이 쓰는거라 생성하지 않고 클래스명으로 가져다 쓴다
		response.getWriter().write(uid.toString()); //객체 형식이라 문자로 바꿔줌
	}

}
