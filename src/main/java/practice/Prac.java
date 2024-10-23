package practice;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/Prac")
public class Prac extends HttpServlet{
	
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("서블릿 진입");
		String an = request.getParameter("an")==null ? "NULL값" : request.getParameter("an");
		int su = request.getParameter("su")==null ? 0 : Integer.parseInt(request.getParameter("su"));
		String action = request.getParameter("action")==null ? "오류" : request.getParameter("action");
		
		if(action.equals("pomni")) {
			
		}else if(action.equals("kinger")) {
			
		}else if(action.equals("jax")) {
			
		}
		
		request.setAttribute("an", an);
		request.setAttribute("su", su);
		
		String viewPage = "";
		
		viewPage = "/study/practice/prac.jsp";
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
	}
	
}
