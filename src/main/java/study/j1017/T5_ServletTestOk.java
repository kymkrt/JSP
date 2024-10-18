package study.j1017;

import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/1017/T5_ServletTestOk")
public class T5_ServletTestOk extends HttpServlet{
	
	//애플리케이션과 세션을 서블릿에서
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String mid = request.getParameter("mid"); //원래 널값 처리
		System.out.println("T5_ServletTestOk mid : "+mid);
		
		//세션은 타입을 httpsession이다 세션객체를 생성할때 타입을 이걸로 
		//세션객체 생성
		HttpSession session = request.getSession(); //담으려면 변수명 필요 객체의 타입이 인터페이스
		session.setAttribute("sMid", mid);
		
		//어플리케이션객체 생성
//		애플리케이션 객체를 생성할때는 서블릿콘텍스트 객체로 타입
		//ServletContext application = session.getServletContext();
		//편법?
		//ServletContext application = request.getSession().getServletContext(); //세션 객체로 가져와서 사용
		//ServletContext application = request.getServletContext(); //세션객체 없이도 리퀘스트 객체로 가능
		ServletContext application = request.getServletContext(); //앞부분 타입만 해두면 뒤에 리퀘스트만 해도 자동으로 나온다
		application.setAttribute("aMid", mid);
		
		// 호출하는 2가지 방법 : 센드리다이렉트 디스패처포워드
		response.sendRedirect(request.getContextPath()+"/study/1017_storage/t5_ServletTest.jsp");//그냥 보내기만 하는거기 때문에 센드 리디렉트
	}
}