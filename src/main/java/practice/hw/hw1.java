package practice.hw;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/hw1")
public class hw1 extends HttpServlet{
	
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		String name = request.getParameter("name")==null ? "" : request.getParameter("name");
		int age = request.getParameter("age")==null ? 0 : Integer.parseInt(request.getParameter("age")); //인트로 받기 때문에 기본 0 이고 파스인트
		String gender = request.getParameter("gender"); //기본값이 있기 때문에 null 처리 안해도됨
		String[] hobbys = request.getParameterValues("hobby");
		String job = request.getParameter("job");
		String[] mountains = request.getParameterValues("mountain");
		String content = request.getParameter("content")==null ? "" : request.getParameter("content");
		String fName = request.getParameter("fName")==null ? "" : request.getParameter("fName");
		
		//콘솔출력
		System.out.println("성명 : "+name);
		System.out.println("나이 : "+age);
		System.out.println("성별 : "+gender);
		
		String hobby = "";
		if(hobbys != null) {
			for(String h: hobbys) {
				hobby += h + "/";
			}
			hobby = hobby.substring(0, hobby.length()-1);
		}
		System.out.println("취미 : "+hobby);
		System.out.println("직업 : "+job);
		
		String mountain = "";
		if(mountains != null) {
			for (String m: mountains) {
				mountain += m + "/";
			}
			mountain = mountain.substring(0, mountain.length()-1);
		}
		System.out.println("다녀온산 : "+mountain);
		
		content = content.replace("\n", "<br/>");
		System.out.println("자기소개 : " + content);
		System.out.println("첨부파일 : " + fName);
		
		String viewPage = "";
		RequestDispatcher dispatcher = null;
		request.setAttribute("name", name);
		request.setAttribute("age", age);
		request.setAttribute("gender", gender);
		request.setAttribute("hobby", hobby);
		request.setAttribute("job", job);
		request.setAttribute("mountain", mountain);
		request.setAttribute("content", content);
		request.setAttribute("fName", fName);
		
		viewPage = "/study/practice/hw1Res.jsp";
		dispatcher = request.getRequestDispatcher(viewPage); //내가 보내고자 하는 뷰페이지
		dispatcher.forward(request, response);
		
	}
	
}
