package guest;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("*.gu")
public class GuestController extends HttpServlet{
	
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//인터페이스 자체가 서비스 객체?
		GuestInterface command = null; //인터페이스는 생성을 할수 없어서 new가 안됨
		String viewPage = "/WEB-INF/guest"; //스펠링, 대소문자 틀리면 안됨
		
		//필요할때 필요한 커맨드 객체를 만드는것
		
		String com = request.getRequestURI();
		com = com.substring(com.lastIndexOf("/"), com.lastIndexOf("."));
		
		//
		if(com.equals("/GuestList")) {//여기에 /를 떼고 싶으면 위에 +1추가
			//구현객체 생성
			command = new GuestListCommand();
			command.execute(request, response);
			viewPage += "/guestList.jsp";
		}
		else if(com.equals("/GuestInput")) {//여기에 /를 떼고 싶으면 위에 +1추가
			//입력받기만 하는 애는 커맨드 객체 필요없음
			viewPage += "/guestInput.jsp";
		}
		else if(com.equals("/GuestInputOk")) {//여기에 /를 떼고 싶으면 위에 +1추가
			command = new GuestInputOkCommand();
			command.execute(request, response);
			//그냥 인풋으로 보내면 URL에 Ok가 떠있음 새로고침 하면 같은게 계속 DB에 입력되니까 메세지로 보낸다
			viewPage = "/include/message.jsp";
		}
		else if(com.equals("/GuestAdmin")) {//여기에 /를 떼고 싶으면 위에 +1추가
			//로그인창만 보여주는거라 커맨드 객체 필요없음
			viewPage += "/guestAdmin.jsp";
		}
		else if(com.equals("/GuestAdminOk")) {
			command = new GuestAdminOkCommand();
			command.execute(request, response);
			viewPage = "/include/message.jsp";
		}
		else if(com.equals("/GuestAdminOut")) {
			command = new GuestAdminOutCommand();
			command.execute(request, response);
			viewPage = "/include/message.jsp";
		}
		else if(com.equals("/GuestDeleteOk")) {
			command = new GuestDeleteOkCommand();
			command.execute(request, response);
			viewPage = "/include/message.jsp";
		}
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
	}
}
