package board;

import java.io.IOException;
import java.sql.Array;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class BoardContentCommand implements BoardInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int idx = (request.getParameter("idx")==null || request.getParameter("idx").equals("")) ? 0	 : Integer.parseInt(request.getParameter("idx"));
		int pag = (request.getParameter("pag")==null || request.getParameter("pag").equals("")) ? 0 : Integer.parseInt(request.getParameter("pag"));
		//page 는 예약어라 쓸수 없기 때문에 pag
		BoardDAO dao = new BoardDAO();
		
		HttpSession session = request.getSession();
		
		String idxStr = idx+"board";
		String sIdx = (session.getAttribute("sIdx") == null) ? "" : session.getAttribute("sIdx").toString();
		//String idxPlus = session.getAttribute("sIdx").toString()+"/";
		
		if(sIdx.indexOf(idxStr) == -1) {
			//글조회수 1씩 증가하기
			dao.setContentReadNumPlus(idx);
			sIdx += idxStr+"board/";
			session.setAttribute("sIdx", sIdx);
		}
		
		//이전글/다음글 검색 아래처럼 나눠도 되지만
		//dao.getPreSearch(idx);
		//dao.getNextSearch(idx);
		//이렇게 메소드는 하나만 만들고 처리만 나눠도 된다
		BoardVO preVo = dao.getPreNextSearch(idx, "pre");
		BoardVO nextVo = dao.getPreNextSearch(idx, "next");
		request.setAttribute("preVo", preVo);
		request.setAttribute("nextVo", nextVo);
		
		//현재 게시글 vo에 담아오기
		BoardVO vo = dao.getBoardContent(idx);
		
		request.setAttribute("vo", vo);
		request.setAttribute("pag", pag);
		
		
		//댓글처리
		ArrayList<BoardReplyVO> replyVos = dao.getBoardReply(idx);
		request.setAttribute("replyVos", replyVos);
		
	}

}
