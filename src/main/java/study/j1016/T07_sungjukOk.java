package study.j1016;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/1016/T07_sungjuk")
public class T07_sungjukOk extends HttpServlet{
	
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		System.out.println("서블릿");
		String name = request.getParameter("name")==null ? "" : request.getParameter("name");
		String hakbun = request.getParameter("hakbun")==null ? "" : request.getParameter("hakbun");
		int kor = (request.getParameter("kor")==null || request.getParameter("kor").equals("")) ? 0 : Integer.parseInt(request.getParameter("kor")); 
		int eng = (request.getParameter("eng")==null || request.getParameter("eng").equals("")) ? 0 : Integer.parseInt(request.getParameter("eng")); 
		int mat = (request.getParameter("mat")==null || request.getParameter("mat").equals("")) ? 0 : Integer.parseInt(request.getParameter("mat")); 
		int soc = (request.getParameter("soc")==null || request.getParameter("soc").equals("")) ? 0 : Integer.parseInt(request.getParameter("soc")); 
		int sci = (request.getParameter("sci")==null || request.getParameter("sci").equals("")) ? 0 : Integer.parseInt(request.getParameter("sci")); 
		String hostIp = request.getParameter("hostIp");
		
		int tot = kor + eng + mat + soc + sci;
		double avg = tot / 5.0;
		String grade ="";
		
		switch((int)(avg / 10)) {
			case 10:
			case 9:
				grade = "A"; break;
			case 8:
				grade = "B"; break;
			case 7:
				grade = "C"; break;
			case 6:
				grade = "D"; break;
			default:
				grade = "F";
		}
		
		//처리된 결과를 VO객체에 담으려한다
		//1.생성자를 이용한 값의 주입(처리)
		//SungjukVO vo = new SungjukVO(name, hakbun, kor, eng, mat, soc, sci, tot, avg, grade, hostIp);
		
		//request.setAttribute("vo", vo); //객체안에 다있다 그래서 객체만 보냄

		//2.세터를 통한 값의 주입(처리) 세터 메소드를 생성해야쓸수 있는데 그래서 기본생성자가 필요하다
		SungjukVO vo = new SungjukVO();
		vo.setName(name);
		vo.setHakbun(hakbun);
		vo.setKor(kor);
		vo.setEng(eng);
		vo.setMat(mat);
		vo.setSoc(soc);
		vo.setSci(sci);
		vo.setTot(tot);
		vo.setAvg(avg);
		vo.setGrade(grade);	
		vo.setHostIp(hostIp);
		
		request.setAttribute("vo", vo); //객체안에 다있다 그래서 객체만 보냄
		
//		request.setAttribute("name", name);
//		request.setAttribute("hakbun", hakbun);
//		request.setAttribute("kor", kor);
//		request.setAttribute("eng", eng);
//		request.setAttribute("mat", mat);
//		request.setAttribute("soc", soc);
//		request.setAttribute("sci", sci);
//		request.setAttribute("tot", tot);
//		request.setAttribute("avg", avg);
//		request.setAttribute("grade", grade);
//		request.setAttribute("hostIp", hostIP);

		
		//String viewPage = "/study/1016/t07_res.jsp"; //맨앞/는 웹앱니다
		String viewPage = "/study/1016/t07_res2.jsp"; //맨앞/는 웹앱니다
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage); //목적지 주소만 쓰면됨
		dispatcher.forward(request, response);
	}
	
}
