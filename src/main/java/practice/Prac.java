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

@WebServlet("*.Prac")
public class Prac extends HttpServlet{
	
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("서블릿 진입");
		String an = request.getParameter("an")==null ? "NULL값" : request.getParameter("an");
		int su = request.getParameter("su")==null ? 0 : Integer.parseInt(request.getParameter("su"));
		String action = request.getParameter("action")==null ? "오류" : request.getParameter("action");
		
		PracInter command = null;
		
		request.setAttribute("an", an);
		request.setAttribute("su", su);
		
		String viewPage = "/study/practice/prac.jsp";
		
		if(action.equals("pomni")) {
			command = new Pomni();
			command.execute(request, response);
			viewPage = "/WEB-INF/practice/pomni.jsp";
		}else if(action.equals("kinger")) {
			command = new Kinger();
			command.execute(request, response);
			viewPage = "/WEB-INF/practice/kinger.jsp";
			
		}else if(action.equals("jax")) {
			command = new Jax();
			command.execute(request, response);
			viewPage = "/WEB-INF/practice/jax.jsp";
		}
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
	}
	
}
