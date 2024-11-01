package admin.member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import admin.AdminInterface;
import member.MemberDAO;
import member.MemberVO;

public class MemberDetailViewCommand implements AdminInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int idx = (request.getParameter("idx")==null || request.getParameter("idx").equals("")) ? 0 : Integer.parseInt(request.getParameter("idx"));
		
		MemberDAO dao = new MemberDAO();
		MemberVO vo = dao.getMemberIdxCheck(idx);
		
		request.setAttribute("vo", vo);
	}

}
