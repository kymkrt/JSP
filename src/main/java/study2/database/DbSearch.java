package study2.database;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/study2/database/DbSearch")
public class DbSearch extends HttpServlet{
	
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int idx = (request.getParameter("idx")==null) || (request.getParameter("idx").equals("")) ? 0 : Integer.parseInt(request.getParameter("idx"));		
		
		DbTestDAO dao = new DbTestDAO();
		
		DbTestVO vo = dao.getDbTestSearch(idx); 
		//List도 사용가능
		//여러건 가져올때
		/* ArrayList<DbTestVO> vos = dao.getDbTestSearch(name); */
		
		System.out.println("vo : "+vo);
		request.setAttribute("vo", vo);
		
		
		String viewPage = "/WEB-INF/study2/database/dbUpdate.jsp";
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
		
	}
}
