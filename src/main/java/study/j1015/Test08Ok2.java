package study.j1015;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/1015/Test08Ok2") //이게 경로명이다 아래가 파일명이고
public class Test08Ok2 extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html; charset=utf-8");
		
//		String mid = request.getParameter("mid");
//		if(mid == null) mid ="";
//		
//		String pwd = request.getParameter("pwd");
//		if(pwd == null) pwd ="";
		
		//db에 널이 들어가면 안되는 경우(notnull) 를 막기 위해서 위나 아래 같은 방법을 사용한다 
		String mid = request.getParameter("mid")==null ? "" : request.getParameter("mid");
		String pwd = request.getParameter("pwd")==null ? "" : request.getParameter("pwd");
		
		System.out.println("아이디 : " + mid);
		System.out.println("비밀번호 : " + pwd);
		
		if(mid.equals("admin") && pwd.equals("1234")) {
			response.sendRedirect("/javaGroup/study/1015/test08Admin.jsp");
		}
		else if(mid.equals("hkd1234") && pwd.equals("1234")) {
			response.sendRedirect("/javaGroup/study/1015/test08Member.jsp");
		}
		else {
			//백엔드 체크 프론트에 없어도 백에서 체크가 있어야 한다
			response.sendRedirect("/javaGroup/study/1015/test08.jsp?flag=no");  
		}
	}
}
