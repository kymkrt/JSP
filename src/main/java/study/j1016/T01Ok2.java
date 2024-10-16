package study.j1016;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/1016/T01Ok2")
public class T01Ok2 extends HttpServlet{
	
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			System.out.println("이곳은 T01Ok2의 service 메소드입니다");
			request.setCharacterEncoding("utf-8");
			response.setContentType("text/html; charset=utf-8");
			
			String mid = request.getParameter("mid")==null ? "" : request.getParameter("mid");
			String pwd = request.getParameter("pwd")==null ? "" : request.getParameter("pwd");
			
			
			String viewPage = ""; //둘다에서 쓰기 때문에 외부로 빼둔다
			RequestDispatcher dispatcher = null; //객체니까 null로 초기화
			if((mid.equals("admin") && pwd.equals("1234")) || (mid.equals("hkd1234") && pwd.equals("1234"))) {
				viewPage = "/study/1016/t02_Member.jsp";
				request.setAttribute("mid", mid); //변수(저장소에 담는 변수), 값(저 위의 스트링의 변수 서블릿 변수)
//				직렬화 변수를 헤더변수에 담아 보내는것 
				//dispatcher = request.getRequestDispatcher(viewPage); //내가 보내고자 하는 뷰페이지
				//dispatcher.forward(request, response);
			}
			
			else {
				viewPage = "/study/1016/t02_Dispatcher.jsp";
				request.setAttribute("flag", "no"); //변수(저장소에 담는 변수), 값=데이터(서블릿 변수)
//				직렬화 변수를 헤더변수에 담아 보내는것 
				//dispatcher = request.getRequestDispatcher(viewPage); //내가 보내고자 하는 뷰페이지
				//dispatcher.forward(request, response);
				
			}
		//이렇게 빼주면 더 간결하다 
			dispatcher = request.getRequestDispatcher(viewPage); //내가 보내고자 하는 뷰페이지
			dispatcher.forward(request, response);
			
	}
}
