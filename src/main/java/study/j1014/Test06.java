package study.j1014;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@SuppressWarnings("serial")
//여러개면 {}
//webxml로 환경설정해서 웹서블릿 없이도 갈수있다
//@WebServlet({"/Test06", "/T06"})  //컨트롤러를 어노테이션으로 쓰는법
public class Test06 extends HttpServlet{ //컨트롤러
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html; charset=utf-8");
		System.out.println("이곳은 Test06 서블릿의 Get");
		
		PrintWriter out = response.getWriter();
		
		out.println("<p><a href='/javaGroup/study/1014/test06.jsp'>돌아가기(test06.jsp)</a></p>");
	}
	
	@Override
		protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			System.out.println("이곳은 Test06 서블릿의 Post");
			doGet(request, response);
		}
	
}
