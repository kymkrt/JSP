package study.j1021;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/1021/T3_initOut")
public class T3_initOut extends HttpServlet{
	
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("이곳은 /1021/T3_initOut 서비스 객체");
		
		//인터페이스고 리퀘스트 객체에 들어있음
		HttpSession session = request.getSession();
		
		//지우는거라 값이 필요없음 변수만 있으면 된다
		session.removeAttribute("sLogoName");
		session.removeAttribute("sHomeAddress");
		
		
		//get 방식 URL 타고 들어가는거라 콘텍스트가 무조건 들어가야한다
		response.sendRedirect(request.getContextPath()+"/study/1021_xml/t3_init.jsp");
		
	}
}
