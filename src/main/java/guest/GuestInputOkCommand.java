package guest;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class GuestInputOkCommand implements GuestInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String name = request.getParameter("name")==null ? "" : request.getParameter("name");
		String content = request.getParameter("content")==null ? "" : request.getParameter("content");
		String email = request.getParameter("email")==null ? "" : request.getParameter("email");
		String homePage = request.getParameter("homePage")==null ? "" : request.getParameter("homePage");
		String hostIp = request.getParameter("hostIp")==null ? "" : request.getParameter("hostIp");
		
		//&내용; 까지가 이걸 사용한다? 라는 뜻이기 때문에 꼭;를 붙여야한다 안붙여도 작동은 하는데 그건 이게 html4, 5 둘다 지원하기 때문이다 만약 html5만 지원하면 작동안됨
		//< 이게 &lt;랑 같은 뜻이다 반대도 마찬가지고
		name = name.replace("<", "&lt;");
		name = name.replace("<", "&gt;");
		
		GuestVO vo = new GuestVO();
		
		vo.setName(name);
		vo.setContent(content);
		vo.setEmail(email);
		vo.setHomePage(homePage);
		vo.setHostIp(hostIp);
		
		GuestDAO dao = new GuestDAO();
		
		int res = dao.setGuestInputOk(vo);
		
		if(res != 0) {
			request.setAttribute("message", "방명록에 글이 등록되었습니다");
			request.setAttribute("url", "/GuestList.gu"); //확장자패턴
		}else {
			request.setAttribute("message", "방명록 등록 실패");
			request.setAttribute("url", "/GuestInput.gu"); //확장자패턴
		}
		
	}

}
