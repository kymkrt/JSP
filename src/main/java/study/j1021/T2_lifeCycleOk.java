package study.j1021;

import java.io.IOException;

import javax.annotation.PostConstruct;
import javax.annotation.PreDestroy;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
@WebServlet("/1021/T2_lifeCycleOk")
public class T2_lifeCycleOk extends HttpServlet{
	
  @Override protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
  	System.out.println("이곳은 service 메소드 입니다");
  }
  
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("이곳은 doPost 메소드 입니다");
		doGet(request, response);
	}
	
	
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("이곳은 doGet 메소드 입니다");
		//메인 작업 처리
	}
	
	//아주 옛날 방식 유지 보수용
	public void doAction (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException  {
		System.out.println("이곳은 doAction 메소드 입니다");
		doPost(request, response);
	}
	
	@Override
	public void init() throws ServletException {
		System.out.println("이곳은 init 메소드입니다");
	}
	
	//init 앞에
	@PostConstruct
	public void initProcess() {
		System.out.println("이곳은 사용자 정의 메소드(initProcess)입니다");
	}
	
	@Override
	public void destroy() {
		System.out.println("이곳은 destroy 메소드입니다");
	}
	
	//destroy뒤에
	@PreDestroy
	public void destroyProcess() {
		System.out.println("이곳은 사용자 정의 메소드(destroyProcess)입니다");
	}
	
}
