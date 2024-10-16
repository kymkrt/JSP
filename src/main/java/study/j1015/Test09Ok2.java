package study.j1015;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/1015/Test09Ok2") //이게 경로명이다 아래가 파일명이고
public class Test09Ok2 extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html; charset=utf-8");
		
		String mid = request.getParameter("mid")==null ? "" : request.getParameter("mid");
		String pwd = request.getParameter("pwd")==null ? "" : request.getParameter("pwd");
		
		System.out.println("아이디 : " + mid);
		System.out.println("비밀번호 : " + pwd);
		
		//하드코딩
		if(mid.equals("admin") && pwd.equals("1234")) {
			/* response.sendRedirect("/javaGroup/study/1015/test09Admin.jsp"); */
//			내가 들어간 컨텍스트 명
			response.sendRedirect(request.getContextPath() + "/study/1015/test09Admin.jsp?mid="+mid);
		}
		else if((mid.equals("hkd1234") && pwd.equals("1234")) || (mid.equals("kms1234") && pwd.equals("1234"))) {
			response.sendRedirect(request.getContextPath() + "/study/1015/test09Member.jsp?mid="+mid); //안에 있는 mid는 받는?  밖에있는mid는 프로그램에서 쓰는 자바 mid
		}
		else {
			response.sendRedirect("/javaGroup/study/1015/test09.jsp?flag=no");  
		}
	}
	
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}
}
