package study2.mapping;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

//@WebServlet("/study2/mapping/list.do") 기존 디렉토리패턴 디렉토리패턴은 경로의 시작이 무조건 /로 시작
@WebServlet("*.do") //확장자 패턴(FrontController) 앞에는 중요하지 않음 뒤에가 중요 여기선 와일드카드 사용
public class DoController extends HttpServlet{

	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String msg = request.getParameter("msg")==null ? "" : request.getParameter("msg");
		
		request.setAttribute("msg", msg);
		
		//관리를 위해 인터페이스를 만들어준다
		//인터페이스/추상메소드는 생성이 안됨 일을 안하기 때문 구현객체만 있다
		DoInterface command = null;
		
		String viewPage = "/WEB-INF/study2/mapping/";
		
		String uri = request.getRequestURI();
		
		System.out.println("uri : "+uri);
		//이렇게 뽑아내고 보낸다
		String com = uri.substring(uri.lastIndexOf("/")+1, uri.lastIndexOf("."));
		System.out.println("uri : "+com);
		
		//이렇게 여긴 교통정리만 하고 실제 일은 execute가 한다
		if(com.equals("list")) {
			//우두머리 명을 써줌 여긴 Do
			command = new DoListCommand();
			//여기 respnse가 execute의 response를 받는다
			command.execute(request, response);
			viewPage += "doList.jsp";
		}
		else if(com.equals("search")) {
			//우두머리 명을 써줌 여긴 Do
			command = new DoSearchCommand();
			//여기 respnse가 execute의 response를 받는다
			command.execute(request, response);
			viewPage += "doSearch.jsp";
		}
		else if(com.equals("input")) {
			command = new DoListCommand();
			command.execute(request, response);
			viewPage += "doInput.jsp";
		}
		else if(com.equals("inputOk")) {
			command = new DoInputOkCommand();
			command.execute(request, response);
			viewPage += "test2.jsp";
		}
		else if(com.equals("update")) {
			command = new DoUpdateCommand();
			command.execute(request, response);
			viewPage += "doUpdate.jsp";
		}
		else if(com.equals("updateOk")) {
			command = new DoUpdateOkCommand();
			command.execute(request, response);
			viewPage = "/include/message.jsp";//처음 /는 웹앱을 의미한다
		}
		else if(com.equals("delete")) {
			command = new DoDeleteCommand();
			command.execute(request, response);
			viewPage += "doDelete.jsp";
		}
		else if(com.equals("deleteOk")) {
			command = new DoDeleteOkCommand();
			command.execute(request, response);
			viewPage = "/include/message.jsp";
		}
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
	}
}
