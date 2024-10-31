package member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.SecurityUtil;

public class MemberPwdCheckAjaxOkCommand implements MemberInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String pwd = request.getParameter("pwdCheck")==null ? "" : request.getParameter("pwdCheck");
		
		HttpSession session = request.getSession();
		String mid = (String) session.getAttribute("sMid"); //아이디를 넘겨 받지 않아서 세션에서 가져옴
		
		//비밀번호 암호화 (int) Math.random() * (최댓값-최솟값+1) + 최솟값
		long temp = (int)(Math.random()*(999-100+1))+100; //3자리 난수
		String salt = temp + "";
		
		SecurityUtil security = new SecurityUtil();
		pwd = security.encryptSHA256(salt + pwd);
		pwd = salt + pwd;
		
		MemberDAO dao = new MemberDAO();
		int res = dao.setMemberPwdCheckAjaxOk(mid, pwd);
		
		if(res != 0) {
			request.setAttribute("message", "비밀번호가 변경되었습니다 \\n 다시 로그인 해주세요"); //서블릿에서는 \가 2개 있어야 한다
			request.setAttribute("url", "/MemberLogout.mem"); //확장자패턴
		}else {
			request.setAttribute("message", "비밀번호 변경 실패");
			request.setAttribute("url", "/MemberPwdCheckAjax.mem"); //확장자패턴
		}
		
	}
}
