package study2.ajax;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import member.MemberVO;
import study2.StudyDAO;

@WebServlet("/AjaxIdCheck3")
public class AjaxIdCheck3 extends HttpServlet{
	
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String mid = request.getParameter("mid")==null ? "" : request.getParameter("mid");
		
		StudyDAO dao = new StudyDAO();
		
		MemberVO vo = dao.getMostPoint();
		
		int point = vo.getPoint();
		String name = vo.getName();
		
		//여기서 다른곳으로 넘기기 때문 비동기식이 아니게 된다 
		//그래서 여기서 처리를 하기 위해 리퀘스트가 아니라 리스폰스 사용
		
		//부정으로 주는게 좋다
		if(point ==0) {
			name = "포인트 없음";
			point = 0;
		}
		response.getWriter().write(name);
		response.getWriter().write(point);
	}
}
