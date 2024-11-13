package memberMessage;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import admin.board.BoardListCommand;
import admin.board.BoardSelectDeleteCommand;
import admin.claim.BoardClaimInputCommand;
import admin.claim.ClaimDeleteOkCommand;
import admin.claim.ClaimListCommand;
import admin.claim.ClaimViewCheckCommand;
import admin.member.MemberDetailViewCommand;
import admin.member.MemberLevelChangeCommand;
import admin.member.MemberListCommand;
import study2.ajax.AjaxIdCheck0Command;
import study2.ajax.AjaxPointCheckCommand;
import study2.password.PassCheckOkCommand;

@WebServlet("*.msg")
public class MemberMessageController extends HttpServlet{
	
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		MemberMessageInterface command = null;
		
		String viewPage = "/WEB-INF/memberMessage";
		String com = request.getRequestURI();
		com = com.substring(com.lastIndexOf("/"), com.lastIndexOf("."));
		
		// 인증처리 (spring에서는 AOP의 개념)
		//이렇게 해주면 여길 지나는 스터디 컨트롤러는 모두 걸리게 된다
		HttpSession session = request.getSession();
		int level = session.getAttribute("sLevel")==null ? 999 : (int)session.getAttribute("sLevel"); //세션은 객체라서 이렇게 처리해줌
		
		if(level > 4) {
			request.setAttribute("message", "로그인 후 사용하세요");
			request.setAttribute("url", "/MemberLogin.mem");
			viewPage = "/include/message.jsp";
		}
		else if(com.equals("/MemberMessage")) {
			command = new MemberMessageCommand();
			command.execute(request, response);
			viewPage += "/memberMessage.jsp";
		}
		else if(com.equals("/MemberIdSearchCheck")) {
			command = new MemberIdSearchCheckCommand();
			command.execute(request, response);
			viewPage += "/memberMessage.jsp";
		}
		else if(com.equals("/MemberMessageInput")) {
			command = new MemberMessageInputCommand();
			command.execute(request, response);
			return;
		}
		else if(com.equals("/MemberMessageSearch")) {
			command = new MemberMessageSearchCommand();
			command.execute(request, response);
			viewPage += "/memberMessage.jsp";
		}
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
		
	}
}
