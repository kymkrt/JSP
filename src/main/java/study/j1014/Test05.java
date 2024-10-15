package study.j1014;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/Test5")
public class Test05 extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html; charset=utf-8");
		//출력하는건 리스폰스객체에 있는 겟라이터에의해서 출력을 한다
		PrintWriter out = response.getWriter();
		out.println("<h2>이곳은 Test5서블릿입니다</h2>");
		out.println("<div><a href='/javaGroup/study/1014/test3.jsp'>test3.jsp로</a></div>");
		
	}
}
