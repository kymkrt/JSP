package study2.mapping;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.Date;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/study2/mapping/Test1Ok")
public class Test1Ok extends HttpServlet{
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Test1Ok 접속");
		String viewPage = "";
		
		int su1 = (request.getParameter("su1")==null || request.getParameter("su1").equals("")) ? 0 : Integer.parseInt(request.getParameter("su1"));
		int su2 = (request.getParameter("su2")==null || request.getParameter("su2").equals("")) ? 0 : Integer.parseInt(request.getParameter("su2"));
		int flag = request.getParameter("flag")==null ? 2 : Integer.parseInt(request.getParameter("flag"));
		
		int hap = su1+su2;
		int cha = su1-su2;
		int gob = su1*su2;
		int mok=9999999;
		
		Date date = new Date();
		
		if(su2!=0) {
			mok=su1/su2;
		}
		
		request.setAttribute("su1", su1);
		request.setAttribute("su2", su2);
		
		if(flag==1) {
			request.setAttribute("hap", hap);
			request.setAttribute("cha", cha);
		} else if(flag==3) {
			request.setAttribute("mok", mok);
			request.setAttribute("gob", gob);
		} else if(flag==4) {
			LocalDateTime today = LocalDateTime.now(); //2024-10-23T10:11:42.282221200
			String str = today.toString().substring(0,10)+"/";
			str += today.toString().substring(11, 19);
			request.setAttribute("msg", str);
			request.setAttribute("today", today); //jsp에서 jstl을 이용한 날짜/시간 분리를 위한 준비
		}
		
		
		viewPage = "/WEB-INF/study2/mapping/test1.jsp";
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
	}
	
}
