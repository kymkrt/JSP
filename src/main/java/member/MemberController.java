package member;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("*.mem")
public class MemberController extends HttpServlet{
	
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		MemberInterface command = null;
		
		String viewPage = "/WEB-INF/member";
		String com = request.getRequestURI();
		com = com.substring(com.lastIndexOf("/"), com.lastIndexOf("."));
		
		if(com.equals("/MemberLogin")) {//위에서 +1 안해서 여기 / 필요
			viewPage += "/memberLogin.jsp"; //jsp니까 첫글자 소문자
		}
		else if(com.equals("/MemberLoginOk")) {//위에서 +1 안해서 여기 / 필요
			command = new MemberLoginOkCommand();
			command.execute(request, response);
			viewPage = "/include/message.jsp"; //jsp니까 첫글자 소문자
		}
		else if(com.equals("/MemberLogout")) {//위에서 +1 안해서 여기 / 필요
			command = new MemberLogoutCommand();
			command.execute(request, response);
			viewPage = "/include/message.jsp"; //jsp니까 첫글자 소문자
		}
		else if(com.equals("/MemberMain")) {//위에서 +1 안해서 여기 / 필요
			command = new MemberMainCommand();
			command.execute(request, response);
			viewPage += "/memberMain.jsp"; //jsp니까 첫글자 소문자
		}
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
		
	}
}
