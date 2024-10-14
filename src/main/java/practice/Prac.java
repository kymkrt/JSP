package practice;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/Prac")
public class Prac extends HttpServlet{
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setContentType("text/html; charset=utf-8");
		resp.getWriter().append("안녕");
		PrintWriter out = resp.getWriter();
		out.println("<h2>확인중</h2>");
		out.println("<div><input type=number class='form-control' autofocus></div>");
		out.println("<div><a href='/javaGroup/study/practice/prac.jsp' class=btn btn-info>여기인거 같음</a></div>");
		
	}
  @Override
  protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
  	doPost(req, resp);
  }
	
}
