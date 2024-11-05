package board;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class BoardGoodCheck3Command implements BoardInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int idx = (request.getParameter("idx")==null || request.getParameter("idx").equals("")) ? 0	: Integer.parseInt(request.getParameter("idx"));
		
		BoardDAO dao = new BoardDAO();
		
		//좋아요 수 증가 처리 (중복 불허)
		HttpSession session = request.getSession();
		ArrayList<String> contentGood = (ArrayList<String>) session.getAttribute("sContentGood"); //객체타입으로 강제형변환
		if(contentGood == null) {
			contentGood = new ArrayList<String>(); //처음엔 없으니까 만들어줌
		}
		String imsiContentGood = "board" + idx;
		int res = 0;
		if(!contentGood.contains(imsiContentGood)) {
			res = dao.setBoardGoodCheck(idx, 1);
			contentGood.add(imsiContentGood);
		}
		session.setAttribute("sContentGood", contentGood);
		//int res = dao.setBoardGoodCheck(idx, 1);
		
		response.getWriter().write(res+""); //문자로 가야됨
	}

}
