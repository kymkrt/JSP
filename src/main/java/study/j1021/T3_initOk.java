package study.j1021;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

//xml에 서블릿 매핑이 있으면 에러남 그럴때만 여기 안씀
//@WebServlet("/1021/T3_initOk")
@WebServlet("/1021/T3_initOk")
public class T3_initOk extends HttpServlet{
	
	
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("이곳은 /1021/T3_initOk의 서비스 객체");
		
		//넘긴걸 받아야 한다 
		//xml파일을 서블릿으로 생각하면됨 서블릿컨텍스트 (xml파일은 컨텍스트 파일이라고 한다)
		String logoName = getServletContext().getInitParameter("logoName");
		String homeAddress = getServletContext().getInitParameter("homeAddress");
		
		//인터페이스고 리퀘스트 객체에 들어있음
		HttpSession session = request.getSession();
		
		//session.setAttribute("sLogoName", "그린 주식 회사");
		//session.setAttribute("sHomeAddress", "www.green.com");
		
		session.setAttribute("sLogoName", logoName);
		session.setAttribute("sHomeAddress", homeAddress);
		
		
		//get 방식 URL 타고 들어가는거라 콘텍스트가 무조건 들어가야한다
		response.sendRedirect(request.getContextPath()+"/study/1021_xml/t3_init.jsp");
		
	}
}
