package member;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("*.mem")
public class MemberController extends HttpServlet{
	
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		MemberInterface command = null;
		
		String viewPage = "/WEB-INF/member";
		String com = request.getRequestURI();
		com = com.substring(com.lastIndexOf("/"), com.lastIndexOf("."));
		
		//공통코드 공통관심사
	// 인증처리 (spring에서는 AOP의 개념)
		//이렇게 해주면 여길 지나는 스터디 컨트롤러는 모두 걸리게 된다
		HttpSession session = request.getSession();
		int level = session.getAttribute("sLevel")==null ? 999 : (int)session.getAttribute("sLevel"); //세션은 객체라서 이렇게 처리해줌
		
		if(com.equals("/MemberLogin")) {//위에서 +1 안해서 여기 / 필요
			
			//MVC2패턴을 위해 여기서 쿠키를 처리한다
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
		else if(com.equals("/MemberJoin")) {//위에서 +1 안해서 여기 / 필요
			viewPage += "/memberJoin.jsp"; //jsp니까 첫글자 소문자
		}
		else if(com.equals("/MemberJoinOk")) {//위에서 +1 안해서 여기 / 필요
			command = new MemberJoinOkCommand();
			command.execute(request, response);
			viewPage = "/include/message.jsp"; //jsp니까 첫글자 소문자
		}
		else if(com.equals("/MemberIdCheck")) {//위에서 +1 안해서 여기 / 필요
			command = new MemberIdCheckCommand();
			command.execute(request, response);
			//뷰화일이 되는것 아래 jsp가 그 작은 창에 뜬다
			viewPage += "/memberIdCheck.jsp"; //jsp니까 첫글자 소문자
		}
		else if(com.equals("/MemberNickNameCheck")) {//위에서 +1 안해서 여기 / 필요
			command = new MemberNickNameCheckCommand();
			command.execute(request, response);
			//뷰파일이 되는것 아래 jsp가 그 작은 창에 뜬다
			viewPage += "/memberNickNameCheck.jsp"; //jsp니까 첫글자 소문자
		}
		else if(com.equals("/NickNameAjaxCheck")) {//위에서 +1 안해서 여기 / 필요
			command = new NickNameAjaxCheckCommand();
			command.execute(request, response);
			return; //이건 뷰페이지 없음 그래서 return 처리
		}
		//위아래 로그인이 필요없는거는 체크 없이 할수 있도록 나눈다 이거 이후로는 전부 체크되는것
		else if(level>4) { 
		  request.setAttribute("message", "로그인 후 사용하세요");
		  request.setAttribute("url", "/MemberLogin.mem");
		  viewPage ="/include/message.jsp"; 
		}
		else if(com.equals("/MemberMain")) {//위에서 +1 안해서 여기 / 필요
			command = new MemberMainCommand();
			command.execute(request, response);
			viewPage += "/memberMain.jsp"; //jsp니까 첫글자 소문자
		}
		else if(com.equals("/MemberMain")) {//위에서 +1 안해서 여기 / 필요
			command = new MemberMainCommand();
			command.execute(request, response);
			viewPage += "/memberMain.jsp"; //jsp니까 첫글자 소문자
		}
		else if(com.equals("/MemberList")) {//위에서 +1 안해서 여기 / 필요
			command = new MemberListCommand();
			command.execute(request, response);
			viewPage += "/memberList.jsp"; //jsp니까 첫글자 소문자
		}
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
		
	}
}
