package practice.hw;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/hw2")
public class hw2 extends HttpServlet {
	
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		System.out.println("hw2");
		
		String selec = request.getParameter("selec")==null ? "" : request.getParameter("selec");
		System.out.println("img2 : "+selec);
		request.setAttribute("img", selec);
		request.setAttribute("img2", "2323");
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("/study/practice/hw2.jsp");
		dispatcher.forward(request, response);
	}
	
}
