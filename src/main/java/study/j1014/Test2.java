package study.j1014;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

//새로 읽어도 뭐가 안된다 리스타트해라

//시리얼라이즈의 경로 선언을 무시해라?
@SuppressWarnings("serial")
//매핑된 주소 내가 변경 가능
@WebServlet("/T02")
public class Test2 extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at2: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
