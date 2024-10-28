package study2;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import study2.password.PassCheckOkCommand;

@WebServlet("*.st")
public class StudyController extends HttpServlet{
	
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		StudyInterface command = null;
		
		String viewPage = "/WEB-INF/study2";
		String com = request.getRequestURI();
		com = com.substring(com.lastIndexOf("/"), com.lastIndexOf("."));
		
		if(com.equals("/PassCheckForm")) {//위에서 +1 안해서 여기 / 필요
			viewPage += "/password/passCheck.jsp"; //jsp니까 첫글자 소문자
		}
		if(com.equals("/PassCheckOk")) {//위에서 +1 안해서 여기 / 필요
			command = new PassCheckOkCommand();
			command.execute(request, response);
			viewPage += "/password/passCheck.jsp";
		}
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
		
	}
}
