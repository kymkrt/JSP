package guest;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class GuestAdminOutCommand implements GuestInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		//invalidate는 다 지우는거다
		session.removeAttribute("sAdmin");
		
		request.setAttribute("message", "관리자 로그 아웃 되었습니다");
		request.setAttribute("url", "GuestList.gu");
	}

}
