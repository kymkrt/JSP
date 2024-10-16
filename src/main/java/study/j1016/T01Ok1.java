package study.j1016;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

//컨트롤러 용도로 쓰기 때문에 웹 서블릿 필요
@WebServlet("/1016/T01Ok1") //이거는 경로라 이름 달라도 됨 임의로 정해도된다
public class T01Ok1 extends HttpServlet{
	
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("이곳은 T01Ok1의 service 메소드입니다");
		
		//한글처리 항상 앞에다가햐아함 이건 요청할때
		request.setCharacterEncoding("utf-8");
		//요청받았을때
		response.setContentType("text/html; charset=utf-8");
		
		String mid = request.getParameter("mid")==null ? "" : request.getParameter("mid");
		String pwd = request.getParameter("pwd")==null ? "" : request.getParameter("pwd");
		
//		PrintWriter out = response.getWriter();
//		
//		//넘어온 아이디와 비빌버호가 DB에 저장된 회원정보와 같은지를 비교
//		if((mid.equals("admin") && pwd.equals("1234")) || (mid.equals("hkd1234") && pwd.equals("1234"))) {
//			out.println("<script>");
//			out.println("alert('"+mid+"님 로그인 되셨습니다')");
//			out.println("location.href='"+request.getContextPath()+"/study/1016/t02_Member.jsp';"); //절대경로
//			out.println("</script>");
//		}
//		else {
//			out.println("<script>");
//			out.println("alert('회원정보를 확인하세요')");
//		;가 없어도 되나																																						 여기
//			out.println("location.href='"+request.getContextPath()+"/study/1016/t02_Dispatcher.jsp'"); //절대경로
//			out.println("</script>");
//		}
		
//		System.out.println("이곳은 T01Ok1의 service 메소드입니다");
		
		if((mid.equals("admin") && pwd.equals("1234")) || (mid.equals("hkd1234") && pwd.equals("1234"))) {
			response.sendRedirect(request.getContextPath()+"/study/1016/t02_Member.jsp?mid="+mid);//?하고 넣어주는거 겟방식
		}
		else {
			response.sendRedirect(request.getContextPath()+"/study/1016/t02_Dispatcher.jsp?flag=no");
		}
		
	}
}
