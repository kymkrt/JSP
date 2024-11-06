package board;

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

@WebServlet("*.bo")
public class BoardController extends HttpServlet{
	
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		BoardInterface command = null;
		
		String viewPage = "/WEB-INF/board";
		String com = request.getRequestURI();
		com = com.substring(com.lastIndexOf("/"), com.lastIndexOf("."));
		
		// 인증처리 (spring에서는 AOP의 개념이지만 AOP는 아님) 묶어서 공통 관심사로 뺀거라 개념은 AOP가 맞지만 AOP는 아님 AOP는 코드를 여기에 안쓰고 바깥에다 쓰고 경로만 주는것
		//이렇게 해주면 여길 지나는 스터디 컨트롤러는 모두 걸리게 된다
		//스프링에서는 공통관심사를 컨트롤러에 붙일수 있다 AOP처럼 쓰는것
		HttpSession session = request.getSession();
		int level = session.getAttribute("sLevel")==null ? 999 : (int)session.getAttribute("sLevel"); //세션은 객체라서 이렇게 처리해줌
		
		if(level>4) {
			request.setAttribute("message", "로그인 후 사용하세요");
			request.setAttribute("url", "/MemberLogin.mem");
			viewPage = "/include/message.jsp";
		}
		else if(com.equals("/BoardList")) {
			command = new BoardListCommand();
			command.execute(request, response);
			viewPage += "/boardList.jsp";
		}
		else if(level == 1) {
			request.setAttribute("message", "정회원부터 사용할수 있습니다");
			request.setAttribute("url", "/BoardList.bo");
			viewPage = "/include/message.jsp";
		}
		else if(com.equals("/BoardInput")) {
			viewPage += "/boardInput.jsp";
		}
		else if(com.equals("/BoardInputOk")) {
			command = new BoardInputOkCommand();
			command.execute(request, response);
			viewPage = "/include/message.jsp";
		}
		else if(com.equals("/BoardContent")) {
			command = new BoardContentCommand();
			command.execute(request, response);
			viewPage += "/boardContent.jsp";
		}
		else if(com.equals("/BoardDelete")) {
			command = new BoardDeleteCommand();
			command.execute(request, response);
			viewPage = "/include/message.jsp";
		}
		else if(com.equals("/BoardUpdate")) {
			command = new BoardUpdateCommand();
			command.execute(request, response);
			viewPage += "/boardUpdate.jsp";
		}
		else if(com.equals("/BoardUpdateOk")) {
			command = new BoardUpdateOkCommand();
			command.execute(request, response);
			viewPage = "/include/message.jsp";
		}
		else if(com.equals("/BoardGoodCheck")) {
			command = new BoardGoodCheckCommand();
			command.execute(request, response);
			return; //ajax 처리라 리턴
		}
		else if(com.equals("/BoardGoodCheck3")) {
			command = new BoardGoodCheck3Command();
			command.execute(request, response);
			return; //ajax 처리라 리턴
		}
		else if(com.equals("/BoardSearchList")) {
			command = new BoardSearchListCommand();
			command.execute(request, response);
			viewPage += "/boardSearchList.jsp";
		}
		else if(com.equals("/BoardReplyInput")) {
			command = new BoardReplyInputCommand();
			command.execute(request, response);
			return; //ajax 처리라 리턴
		}
		else if(com.equals("/BoardReplyDelete")) {
			command = new BoardReplyDeleteCommand();
			command.execute(request, response);
			return; //ajax 처리라 리턴
		}
		else if(com.equals("/BoardReplyUpdate")) {
			command = new BoardReplyUpdateCommand();
			command.execute(request, response);
			return; //ajax 처리라 리턴
		}
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
		
	}
}
