package study.j1014;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
//새로만들었으니까 무조건 서버를 리스타트 해야함

//경로를 여러개 만들수도 있다
//여러개일때는 중괄호로 묶어야한
@WebServlet({ "/Test3", "/T3", "/T03" })
//브라우저에 출력하려면 아래 클래스를 상속받아야 한다 
public class Test3 extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("이곳은 Test3 서블릿 파일 입니다.(Get)");
		response.getWriter().append("Served at3: ").append(request.getContextPath()).append("<br />: Hello");
	}
	
	//폼태그의 메소드가 포스트인 경우만 포스트 사용가능
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("이곳은 Test3 서블릿 파일 입니다.(Post)");
		doGet(request, response);
	}

}
