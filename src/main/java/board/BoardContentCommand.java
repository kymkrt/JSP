package board;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class BoardContentCommand implements BoardInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int idx = (request.getParameter("idx")==null || request.getParameter("idx").equals("")) ? 0 : Integer.parseInt(request.getParameter("idx"));
		int pag = (request.getParameter("pag")==null || request.getParameter("pag").equals("")) ? 0 : Integer.parseInt(request.getParameter("pag"));
		//page 는 예약어라 쓸수 없기 때문에 pag
		BoardDAO dao = new BoardDAO();
		
		HttpSession session = request.getSession();
		String idxStr = idx+"";
		String idxPlus = session.getAttribute("sIdx").toString()+"/";
		
		if(session.getAttribute("sIdx").toString().indexOf(idxStr) == -1) {
			//글조회수 1씩 증가하기
			dao.setContentReadNumPlus(idx);
			idxPlus += idxStr;
			session.setAttribute("sIdx", idxPlus);
		}
		
		BoardVO vo = dao.getBoardContent(idx);
		
		request.setAttribute("vo", vo);
		request.setAttribute("pag", pag);
		
	}

}
