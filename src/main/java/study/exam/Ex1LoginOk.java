package study.exam;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/exam/Ex1LoginOk")
public class Ex1LoginOk extends HttpServlet{
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String mid = request.getParameter("mid")==null ? "" : request.getParameter("mid");
		String pwd = request.getParameter("pwd")==null ? "" : request.getParameter("pwd");
		String idSave = request.getParameter("idSave")==null ? "off" : "on"; //체크 박스는 on off로 넘어온다
		
		//하드 코딩
		//넘어온 'mid/pwd'를 DB에서 검색후 확인이 되면 로그인 처리한다 
		
		//로그인 OK시에 idSave에 체크를 하였다면 아이디를 쿠키에 저장처리 한다 idSave에 체크 해제되어있다면 쿠키에서 제거한다
		
		//무조건 서블릿에 있는 객체
		Cookie cookieMid = new Cookie("cMid", mid);
		cookieMid.setPath("/"); //레벨이 달라서 못찾을때 이걸로 해두면 검색이 바로 된다?
		if(idSave.equals("on")) {
			cookieMid.setMaxAge(60*60*24*7);//일주일
		}
		else {
			cookieMid.setMaxAge(0);//체크가 안되어있을때
		}
		response.addCookie(cookieMid);
		
		HttpSession session = request.getSession();
		session.setAttribute("sMid", mid);
		
		//모든 작업 처리후 회원 main창으로 보낸다
		request.setAttribute("messsage", mid+"님 로그아웃 되었습니다");
		
		String viewPage = "/study/exam/ex1_main.jsp";
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
	}
}
