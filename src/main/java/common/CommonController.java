package common;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("*.common")
public class CommonController extends HttpServlet{
	
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		CommonInterFace command = null;
		String viewPage = "/WEB-INF";
		String uri = request.getRequestURI();
		
		String page = uri.substring(uri.lastIndexOf("/"), uri.lastIndexOf("."));
		
		if(page.equals("/ClaimList")) {
			command = new PagenationCommand();
			command.execute(request, response);
			viewPage += "/admin/claim/claimList.jsp";
		}
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
		
	}
}
