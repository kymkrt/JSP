package study.j1018;
import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import study.j1018.MemberVO;

@WebServlet("/1018/Jstl3Ok2")
public class Jstl3Ok2 extends HttpServlet{
	
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ArrayList<MemberVO> vos = new ArrayList<MemberVO>(); //뒤의 MemberVO 생략가능 앞에 어레이리스트 리스트로 변경 가능(타입맞춰야 할때)
		
		MemberVO vo = null;
		
		vo = new MemberVO();
		//생성법 1생성자(사용자 정의) 2게터 세터 여기는 게터세터
		vo.setName("홍길동");
		vo.setAge(25);
		vo.setGender("남자");
		vo.setJob("학생");
		vo.setAddress("서울");
		vos.add(vo); //1째가 올라간것
		
		//생성해서 담아야 한다
		vo = new MemberVO();
		vo.setName("김말숙");
		vo.setAge(33);
		vo.setGender("여자");
		vo.setJob("의사");
		vo.setAddress("청주");
		vos.add(vo); //2째가 올라간것
		
		vo = new MemberVO();
		vo.setName("이기자");
		vo.setAge(35);
		vo.setGender("남자");
		vo.setJob("회사원");
		vo.setAddress("서울");
		vos.add(vo);
		
		vo = new MemberVO();
		vo.setName("오하늘");
		vo.setAge(22);
		vo.setGender("여자");
		vo.setJob("자영업");
		vo.setAddress("제주");
		vos.add(vo);
		
		vo = new MemberVO();
		vo.setName("강감찬");
		vo.setAge(55);
		vo.setGender("남자");
		vo.setJob("군인");
		vo.setAddress("연천");
		vos.add(vo);
		
		//넘기는 2가지 1.sendredirct 2.디스패처 보내는 내용이 길면 ?하고 내용이 많아져서 그냥 디스패처가 편하다
		
		//데이서 실어서 보내기 여기선 vos
		request.setAttribute("vos", vos);
		
		String viewPage = "/"; //여기서/는 웹앱
		viewPage = "/study/1018_JSTL/jstl3_res2.jsp";
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
	}
}
