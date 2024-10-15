package study.j1014;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet({ "/Test4", "/T4", "/T04" })
public class Test04 extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		문서형식을 텍스트 html로 한다  명령어가 이어질때는 ; 하나 하고 해야함 웹에서 ;는 연결어라고 생각
		response.setContentType("text/html; charset=utf-8");
		System.out.println("이곳은 Test4 서블릿 파일 입니다.(Get)");
		//response.getWriter().append("Served at4: ").append(request.getContextPath()).append("<br />: Hello");
		//리스폰스를 받아서 html로 보내주는? 메소드
		PrintWriter out = response.getWriter();
//		브라우서에서 html로 해석해서 뿌린다 콘텍스트 명
		out.println("<p><a href='/javaGroup/study/1014/test02.jsp'>test02.jsp로 복귀</a></p>");
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("이곳은 Test4 서블릿 파일 입니다.(Post)");
		doGet(request, response);
	}

}
