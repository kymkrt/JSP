package study2.database;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/study2/database/DbInputOk")
public class DbInputOk extends HttpServlet{
	
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//원래는 백엔드 체크도 해야함 
		String name = request.getParameter("name")==null ? "" : request.getParameter("name");
		//앞 () 빼도됨
		int age = (request.getParameter("age")==null) || (request.getParameter("age").equals("")) ? 0 : Integer.parseInt(request.getParameter("age"));
		String gender = request.getParameter("gender")==null ? "" : request.getParameter("gender");
		String address = request.getParameter("address")==null ? "" : request.getParameter("address");
		
		DbTestVO vo = new DbTestVO();
		vo.setName(name);
		vo.setAge(age);
		vo.setGender(gender);
		vo.setAddress(address);
		
		DbTestDAO dao = new DbTestDAO();
		
		//set으로 넣어줌 직접만든 메소드
		//그냥 vo로 넣어줌
		//1번 수행했다 정수값으로 1넘어옴
		int res = dao.setDbInputOk(vo);
		
		if(res != 0) {
			request.setAttribute("message", "회원가입이 완료되었습니다");
			request.setAttribute("url", "/study2/database/DbList");
		}
		else {
			request.setAttribute("message", "회원가입이 실패했습니다");
			request.setAttribute("url", "/study2/database/DbInputOk");
			
		}
		
		String viewPage = "/include/message.jsp";
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
		
	}
	
}
