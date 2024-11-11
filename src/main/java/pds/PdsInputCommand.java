package pds;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class PdsInputCommand implements PdsInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String part = request.getParameter("part")==null? "" : request.getParameter("part");
		int pag = request.getParameter("pag")==null || request.getParameter("pag").equals("") ? 1 : Integer.parseInt(request.getParameter("pag")); //처음에는 페이지가 안넘어온다=첫페이지 1
		int pageSize = request.getParameter("pageSize")==null || request.getParameter("pageSize").equals("") ? 5 : Integer.parseInt(request.getParameter("pageSize"));//확장성 고려차원
		
		request.setAttribute("part", part);
		request.setAttribute("pag", pag);
		request.setAttribute("pageSize", pageSize);
	}

}
