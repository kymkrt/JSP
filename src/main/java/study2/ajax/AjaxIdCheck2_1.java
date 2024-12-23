package study2.ajax;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import study2.StudyDAO;

//디렉토리 패턴이라 앞에/가 필수
@WebServlet("/AjaxIdCheck2_1") 
public class AjaxIdCheck2_1 extends HttpServlet{//서블릿에서 도와주는것 즉 순수 자바가 아님
	
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String mid = request.getParameter("mid")==null ? "" : request.getParameter("mid");
		
		StudyDAO dao = new StudyDAO();
		
		String name = dao.getIdSearch(mid);
		if(name.equals("")) {
			name = "찾고자 하는 자료가 없습니다";
		}
		response.getWriter().write(name+"");
	}
}
