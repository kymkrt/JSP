package member;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class MemberLoginOkCommand implements MemberInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String mid = request.getParameter("mid")==null ? "" : request.getParameter("mid");
		String pwd = request.getParameter("pwd")==null ? "" : request.getParameter("pwd");
		
		//DB 연결
		MemberDAO dao = new MemberDAO();
		
		MemberVO vo=dao.MemberIdCheck(mid); //원래는 pwd도 넘기지만 지금은 salt를 쓰기 때문에 id만 넘김
		
		
		if(vo.getPwd() == null) { //결과적으로 id가 일치하는 사람이 없다는것
			request.setAttribute("message", "회원 정보가 없습니다.\\n확인하고 다시 로그인 하세요"); //\를 제어 코드로 보기 때문에 \를 2개 써서 인식되도록한다
			request.setAttribute("url", "MemberLogin.mem");
			return; //돌아가라는 뜻 여기 블럭들을 실행하다가 리턴으로 끝나기 때문에 아예 아래 부분을 실행하지도 않는다
		}
		
		//동일한 아아디가 검색되었다면 비밀번호가 맞는지 확인한다
		//입력받은 비밀번호를 암호화 시켜서 DB에 암호화 되어 저장 되어있는 비밀번호와 비교한다
		
		
		if(!vo.getPwd().equals(pwd)) { //부정적인걸 많이 써라 !사용
			request.setAttribute("message", "비밀번호가 틀립니다.\\n확인하고 다시 로그인 하세요"); //\를 제어 코드로 보기 때문에 \를 2개 써서 인식되도록한다
			request.setAttribute("url", "MemberLogin.mem");
			return; //돌아가라는 뜻 여기 블럭들을 실행하다가 리턴으로 끝나기 때문에 아예 아래 부분을 실행하지도 않는다
		}
		
		// 정상 인증이 완료되었을때 처리할 내용들을 기술한다
		//아이디를 쿠키로 저장처리 
		//방문포인트를 5회 미만일 경우게 10포인트 증가처리한다 방문횟수(총/오늘) 누적, 마지막 방문일자 처리(대부분 로그인 할때 처리 사람들이 로그아웃을 안하기 때문), 준회원을 자동으로 등업처리할경우 수행 등등 ==>> DB에 저장
		//처리 완료된 자료들은 작업수행이 지속되는 동안 꼭 필요한 정보만을 session에 저장처리한다
		
		//방문포인트 10증가, 방문카운트(총/오늘) 1증가, 마지막날짜(최종방문일자) 수정.  준회원은 따로 만드는게 편함
		dao.setPointPlus(mid);
		
		//세션에 저장할 항목 : mid, nickName
		HttpSession session = request.getSession();
		session.setAttribute("smid", mid);
		session.setAttribute("sNickName", vo.getNickNickname()); //vo로 가져왔음
		
		request.setAttribute("message", mid+"님 로그인 되었습니다"); //\를 제어 코드로 보기 때문에 \를 2개 써서 인식되도록한다
		request.setAttribute("url", "MemberMain.mem");
		
		
		
	}

}
