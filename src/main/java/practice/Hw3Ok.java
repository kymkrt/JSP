package practice;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/practice/HwOk3")
public class Hw3Ok extends HttpServlet{
	
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		System.out.println("서비스 hw3");
		
		String mid = request.getParameter("mid")==null ? "" : request.getParameter("mid");
		String pwd = request.getParameter("pwd")==null ? "" : request.getParameter("pwd");
		String code = request.getParameter("mid").substring((request.getParameter("mid").length())-1).toUpperCase();
		String saveId = request.getParameter("saveId")==null ? "" : request.getParameter("saveId");
		String viewPage = "";
		
		HttpSession session =  request.getSession(); 
		
		session.setAttribute("sMid", mid);
		session.setAttribute("sPwd", pwd);
		session.setAttribute("sCode", code);
		
		Cookie cookieSaveId = new Cookie("cSaveId", saveId);
		cookieSaveId.setMaxAge(60);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(null);
		
		if(pwd.equals("1234")) {
		switch (code) {
			case "I": {
				System.out.println("I 접속");
				viewPage = "/study/practice/ex01IMain.jsp";
				dispatcher = request.getRequestDispatcher(viewPage);
				break;
			}
			case "C": {
				System.out.println("C 접속");
				viewPage = "";
				dispatcher = request.getRequestDispatcher(viewPage);
				break;
			}
			case "J": {
				System.out.println("J 접속");
				viewPage = "";
				dispatcher = request.getRequestDispatcher(viewPage);
				break;
			}
			case "S": {
				System.out.println("S 접속");
				viewPage = "";
				dispatcher = request.getRequestDispatcher(viewPage);
				break;
			}
			default:
				System.out.println("로그인 실패");
				viewPage = request.getContextPath()+"/study/practice/ex01Login.jsp";
				dispatcher = request.getRequestDispatcher(viewPage);
				break;
			}
		}
		response.addCookie(cookieSaveId);
		dispatcher.forward(request, response);
	}
}
