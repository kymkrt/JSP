package memberMessage;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import member.MemberDAO;
import member.MemberVO;

public class MemberIdSearchCheckCommand implements MemberMessageInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String mid = request.getParameter("mid")==null ? "" : request.getParameter("mid");
		
		MemberDAO dao = new MemberDAO();
		
		//아이디가 헷갈릴수있기 때문에 like 연산자를 사용한다 - 그래서 vos로 받음
		ArrayList<MemberVO> vos = dao.getMemberMidList(mid);
		
		request.setAttribute("vos", vos);
		request.setAttribute("mid", mid);
	}

}
