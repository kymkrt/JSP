package board;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class BoardDeleteCommand implements BoardInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int idx = (request.getParameter("idx")==null || request.getParameter("idx").equals("")) ? 0 : Integer.parseInt(request.getParameter("idx"));
		
		BoardDAO dao = new BoardDAO();
		
		int res = dao.BoardDelete(idx);
		
		if(res != 0) {
			request.setAttribute("message", "게시판에 글이 삭제되셨습니다");
			request.setAttribute("url", "/BoardList.bo"); //확장자패턴
		}else {
			request.setAttribute("message", "게시판 글 삭제 실패");
			request.setAttribute("url", "/BoardContent.bo?idx="+idx); //확장자패턴 쿼리스트링변수
		}
	}

}
