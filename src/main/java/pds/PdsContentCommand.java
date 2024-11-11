package pds;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class PdsContentCommand implements PdsInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int idx = (request.getParameter("idx")==null || request.getParameter("idx").equals("")) ? 0	 : Integer.parseInt(request.getParameter("idx"));
		
		String part = request.getParameter("part")==null? "" : request.getParameter("part");
		int pag = request.getParameter("pag")==null ? 1 : Integer.parseInt(request.getParameter("pag"));
		int pageSize = request.getParameter("pageSize")==null ? 5 : Integer.parseInt(request.getParameter("pageSize"));//확장성 고려차원에서 이렇게 해둠 원래는 그냥 5해도된다
		
		PdsDAO dao = new PdsDAO();
		
		PdsVO vo = dao.getPdsContent(idx);
		
		request.setAttribute("part", part);
		request.setAttribute("vo", vo);

		request.setAttribute("pag", pag);
		request.setAttribute("pageSize", pageSize);
	}

}
