package member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class MemberMainCommand implements MemberInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession();
		String mid = (String) session.getAttribute("sMid");
		
		//로그인한 회원의 정보를 vo에 담아서 넘겨준다
		MemberDAO mDao = new MemberDAO();
		MemberVO mVo = mDao.getMemberIdCheck(mid);
		
		request.setAttribute("mVo", mVo); //한번 뿌려주고 끝날거라 세션 말고 리퀘스트에 담아 보낸다
		
		//
	}

}
