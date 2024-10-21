package study.j1018;
import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/1018/Jstl3Ok1")
public class Jstl3Ok1 extends HttpServlet{
	
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		MemberVO vo = null;
		
		vo = new MemberVO();
		//생성법 1생성자(사용자 정의) 2게터 세터 여기는 게터세터
		vo.setName("홍길동");
		vo.setAge(25);
		vo.setGender("남자");
		vo.setJob("학생");
		vo.setAddress("서울");
		
		//넘기는 2가지 1.sendredirct 2.디스패처 보내는 내용이 길면 ?하고 내용이 많아져서 그냥 디스패처가 편하다
		
		//데이서 실어서 보내기
		request.setAttribute("vo", vo);
		
		String viewPage = "/"; //여기서/는 웹앱
		viewPage = "/study/1018_JSTL/jstl3_res1.jsp";
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
	}
}
