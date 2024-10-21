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
		
		String text = request.getParameter("text")==null ? "기본값" : request.getParameter("text");
		String checkBox = request.getParameter("checkBox")==null ? "on" : request.getParameter("checkBox");
		String hidden = request.getParameter("hidden")==null ? "" : request.getParameter("hidden");
		String range = request.getParameter("range")==null ? "" : request.getParameter("range");
		
		request.setAttribute("text", text);
		request.setAttribute("checkBox", checkBox);
		request.setAttribute("hidden", hidden);
		request.setAttribute("range", range);
		
		String viewPage = "";
		
		
		if(hidden.equals("1")) {
			System.out.println("send 진입");
			viewPage += request.getContextPath()+"/study/practice/prac1.jsp"+"?text="+text+"&checkBox="+checkBox+"&hidden="+hidden+"&range="+range;
			response.sendRedirect(viewPage);
		}
		else {
			System.out.println("디스패처 진입");
			viewPage = "/study/practice/prac2.jsp";
			RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
			dispatcher.forward(request, response);
		}
	
	}
	
}
