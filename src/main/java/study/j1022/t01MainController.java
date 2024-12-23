package study.j1022;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

//2개일때
@WebServlet({"/Main2", "/main2"})
public class t01MainController extends HttpServlet{
	
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("1번");
		//WEB-INF에서는 디스패처포워드만 사용가능 response.sendRedirect는 URL로 보내는거라 사용불가
		String viewPage = "/WEB-INF/main/main.jsp";
		//String viewPage = "/WEB-INF/main/11.jpg";
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
		
	}
}
