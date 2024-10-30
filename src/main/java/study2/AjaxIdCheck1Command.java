package study2;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class AjaxIdCheck1Command implements StudyInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//xhr 사용방식
		
		String mid = request.getParameter("mid")==null ? "" : request.getParameter("mid");
		
		StudyDAO dao = new StudyDAO();
		
		String name = dao.getIdSearch(mid);
		
		//여기서 다른곳으로 넘기기 때문 비동기식이 아니게 된다 
		//그래서 여기서 처리를 하기 위해 리퀘스트가 아니라 리스폰스 사용
		
		//부정으로 주는게 좋다
		if(name.equals("")) {
			name = "찾는 아이디가 없습니다";
		}
		response.getWriter().write(name);
		
	}

}
