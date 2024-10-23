package study2.mapping;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
//이게 URL 창에 뜬다
@WebServlet("/mapping/Test1") //이제는 이 이름이 JSP 이름이 된다
public class Test1 extends HttpServlet{
	
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("/mapping/Test1 접속");
		
		//request.setAttribute("msg", "Hello 안녕");//한글을 필터에 처리 있음
		
		//request.setAttribute("msg", request.getParameter("mid")+"님 로그인중");
		
		RequestDispatcher dispatcher = null;
		String viewPage = "";
		
		String mid = request.getParameter("mid")==null ? "" : request.getParameter("mid");
		if(!mid.equals("") && mid.substring(0, 1).toLowerCase().equals("h")) {
			viewPage = "/WEB-INF/main/main.jsp";
			
		} else {
			viewPage = "/WEB-INF/study2/mapping/test1.jsp";
			
		}
		
		request.setAttribute("msg", mid+"님 로그인중");
		
		dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
		
	}
}
