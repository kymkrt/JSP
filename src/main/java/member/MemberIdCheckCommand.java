package member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class MemberIdCheckCommand implements MemberInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String mid = request.getParameter("mid")==null ? "" : request.getParameter("mid");
		
		MemberDAO dao = new MemberDAO();
		
		MemberVO vo = dao.getMemberIdCheck(mid);
		if(vo.getMid() != null && !vo.getMid().equals("")) {
			//System.out.println("템프 값넣음" +mid);
			vo.setTempMid(mid);
		}
		else vo.setMid(mid);
		
		/*
		 * System.out.println("mid: "+vo.getMid());
		 * System.out.println("temp mid: "+vo.getTempMid());
		 * System.out.println("vo(아이디체크) "+vo);
		 */
		
		//request.setAttribute("mid", vo.getMid());
		//여러개 일때는 그냥 VO 보냄 다처리할수 있어서 편하다
		//없다는걸 알려주기 위한 필드를 만들어준다
		request.setAttribute("vo", vo);
		
	}

}
