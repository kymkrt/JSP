package study2.ajax;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import study2.StudyDAO;
import study2.StudyInterface;

public class AjaxIdCheck0Command implements StudyInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String mid = request.getParameter("mid")==null ? "" : request.getParameter("mid");
		
		StudyDAO dao = new StudyDAO();
		
		String name = dao.getIdSearch(mid);
		
		//부정으로 주는게 좋다
		if(!name.equals("")) {
			//저장소로 보낸 방식
			request.setAttribute("name", name);
			request.setAttribute("message", "전송된 아이디: "+mid+",성명: "+name);
			//쿼리 스트링 방식
			request.setAttribute("url", "AjaxTest.st?name="+name); //request해서 파라미터로 널길때는 이렇게 줘야함
		}else {
			request.setAttribute("message", "검색된 아이디가 없습니다");
			request.setAttribute("url", "AjaxTest.st"); //request해서 파라미터로 널길때는 이렇게 줘야함
		}
		
	}

}
