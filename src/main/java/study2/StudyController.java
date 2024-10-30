package study2;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import study2.ajax.AjaxIdCheck0Command;
import study2.ajax.AjaxPointCheckCommand;
import study2.password.PassCheckOkCommand;

@WebServlet("*.st")
public class StudyController extends HttpServlet{
	
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		StudyInterface command = null;
		
		String viewPage = "/WEB-INF/study2";
		String com = request.getRequestURI();
		com = com.substring(com.lastIndexOf("/"), com.lastIndexOf("."));
		
		// 인증처리 (spring에서는 AOP의 개념)
		//이렇게 해주면 여길 지나는 스터디 컨트롤러는 모두 걸리게 된다
		HttpSession session = request.getSession();
		int level = session.getAttribute("sLevel")==null ? 999 : (int)session.getAttribute("sLevel"); //세션은 객체라서 이렇게 처리해줌
		
		if(level>4) {
			request.setAttribute("message", "로그인 후 사용하세요");
			request.setAttribute("url", "/MemberLogin.mem");
			viewPage = "/include/message.jsp";
		}
		else if(level == 1) {
			request.setAttribute("message", "정회원부터 사용할수 있습니다");
			request.setAttribute("url", "/MemberMain.mem");
			viewPage = "/include/message.jsp";
		}
		else if(com.equals("/PassCheckForm")) {//위에서 +1 안해서 여기 / 필요
			viewPage += "/password/passCheck.jsp"; //jsp니까 첫글자 소문자
		}
		else if(com.equals("/PassCheckOk")) {//위에서 +1 안해서 여기 / 필요
			command = new PassCheckOkCommand();
			command.execute(request, response);
			viewPage += "/password/passCheck.jsp";
		}
		else if(com.equals("/AjaxTest")) {//위에서 +1 안해서 여기 / 필요
			viewPage += "/ajax/ajaxTest.jsp";
		}
		else if(com.equals("/AjaxIdCheck0")) {
			command = new AjaxIdCheck0Command();
			command.execute(request, response);
			viewPage = "/include/message.jsp";
		}
		else if(com.equals("/AjaxIdCheck1")) {
			command = new AjaxIdCheck1Command();
			command.execute(request, response);
			//viewPage = "/include/message.jsp";
			return; //여기서 끊어서 가는게 아니라 내용만 보냄
		}
		else if(com.equals("/AjaxPointCheck")) {
			command = new AjaxPointCheckCommand();//커맨드객체가 서비스 객체 스프링, 실무에선 전부 서비스라고 한다
			command.execute(request, response);
			//viewPage = "/include/message.jsp";
			return; //여기서 끊어서 가는게 아니라 내용만 보냄
		}
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
		
	}
}
