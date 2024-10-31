package member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.SecurityUtil;

public class MemberPwdCheckOkCommand implements MemberInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String pwd = request.getParameter("pwd")==null ? "" : request.getParameter("pwd");
		
		HttpSession session = request.getSession();
		String mid = (String) session.getAttribute("sMid"); //아이디를 넘겨 받지 않아서 세션에서 가져옴
		
		MemberDAO dao = new MemberDAO();
		MemberVO vo = dao.getMemberIdCheck(mid);//리턴타입을 잘봐야한다
		
		//DB에 저장된 비밀번호에서 salt키를 분리해서 현재 입력받은 암호와 결합하여 다시 암호화 시켜서 비교할수 있게 한다
		String salt = vo.getPwd().substring(0, 3);
		
		SecurityUtil security =  new SecurityUtil();
		pwd = security.encryptSHA256(salt+pwd);
		
		//부정으로 처리해주는게 좋다
		if(!vo.getPwd().substring(3).equals(pwd)) {
			request.setAttribute("message", "비밀번호를 확인하세요");
			request.setAttribute("url", "MemberPasswordCheck.mem");
		}
		else {
			request.setAttribute("message", "NO");
			request.setAttribute("url", "MemberUpdate.mem");//컨트롤러를 무조건 타야됨 웹inf라 jsp로 바로 못간다
		}
	}

}
