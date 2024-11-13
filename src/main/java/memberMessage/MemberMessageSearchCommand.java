package memberMessage;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import member.MemberDAO;
import member.MemberVO;

public class MemberMessageSearchCommand implements MemberMessageInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int idx = (request.getParameter("idx")==null || request.getParameter("idx").equals("")) ? 0	 : Integer.parseInt(request.getParameter("idx"));
		
		String msgFlag = request.getParameter("msgFlag")==null ? "" : request.getParameter("msgFlag");
		String mid = request.getParameter("mid")==null ? "" : request.getParameter("mid");
		
		MemberMessageDAO dao = new MemberMessageDAO();
		ArrayList<MemberMessageVO> messageVos = dao.getMemberMessageSearch(msgFlag, mid);
		
		MemberMessageVO contentVo = dao.getMemberMessageContent(idx);
		System.out.println("contentVo : "+contentVo);
		MemberDAO mdao = new MemberDAO();
		ArrayList<MemberVO> vos = mdao.getMemberList(0, 0, 888);
		request.setAttribute("vos", vos);
		
		request.setAttribute("messageVos", messageVos);
		request.setAttribute("msgFlag", msgFlag);
		
		request.setAttribute("contentVo", contentVo);
	}

}
