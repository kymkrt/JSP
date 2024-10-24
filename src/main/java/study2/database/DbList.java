package study2.database;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/study2/database/DbList")
public class DbList extends HttpServlet{
	
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String name = request.getParameter("name")==null ? "" : request.getParameter("name");
		
		DbTestDAO dao = new DbTestDAO();
		
		//한번만일때
		/* DbTestVO vo = dao.getDbTestSearch(); */ 
		//List도 사용가능
		//프론트에서도 해되서 VOS로
		ArrayList<DbTestVO> vos = dao.getDbTestList(name);
		
		request.setAttribute("vos", vos);
		
		
		String viewPage = "/WEB-INF/study2/database/dbList.jsp";
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
		
	}
}
