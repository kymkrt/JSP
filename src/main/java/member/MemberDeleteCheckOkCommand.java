package member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class MemberDeleteCheckOkCommand implements MemberInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession();
		String mid = (String) session.getAttribute("sMid"); //아이디를 넘겨 받지 않아서 세션에서 가져옴
		String midDelete = request.getParameter("mid")==null ? "" : request.getParameter("mid");
		
		MemberDAO dao = new MemberDAO();
		int res = 0;
		
		if(midDelete.equals("") || midDelete == null) {
			res = dao.setMemberDeleteCheckOk(mid);//여기 다녀오면 탈퇴회원
			session.invalidate(); //탈퇴회원이라 세션 다 삭제해준다
		}else if(!(midDelete.equals("")) && !(midDelete == null)) {
			res = dao.setMemberDeleteOk(midDelete);//여기 다녀오면 탈퇴회원
		}
		
		if(res != 0) {
			request.setAttribute("message", "회원 탈퇴되셨습니다 \\n 같은 아이디로 1달간 재가입 불가입니다");
			request.setAttribute("url", "MemberPasswordCheck.mem");
		}
		else {
			request.setAttribute("message", "회원 탈퇴 실패");
			request.setAttribute("url", "MemberMain.mem");//컨트롤러를 무조건 타야됨 웹inf라 jsp로 바로 못간다
		}
	}

}
