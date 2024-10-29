package member;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.mysql.fabric.xmlrpc.base.Data;

import common.SecurityUtil;

public class MemberLoginOkCommand implements MemberInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String mid = request.getParameter("mid")==null ? "" : request.getParameter("mid");
		String pwd = request.getParameter("pwd")==null ? "" : request.getParameter("pwd");
		
		//DB 연결
		MemberDAO dao = new MemberDAO();
		
		MemberVO vo=dao.getMemberIdCheck(mid); //원래는 pwd도 넘기지만 지금은 salt를 쓰기 때문에 id만 넘김
		
		//저장된 비밀번호에서 salt키를 분리시켜서 다시 암호화후 비교처리해야한다 
		String salt = vo.getPwd().substring(0,3);
		
		SecurityUtil security = new SecurityUtil();
		pwd = security.encryptSHA256(salt+pwd);
		System.out.println("pwd(암호화) : "+pwd);
		System.out.println("pwd(DB) : "+vo.getPwd().substring(3));
		
		
		if(!vo.getPwd().substring(3).equals(pwd)) { //결과적으로 id가 일치하는 사람이 없다는것
			request.setAttribute("message", "회원 정보가 없습니다.\\n확인하고 다시 로그인 하세요"); //\를 제어 코드로 보기 때문에 \를 2개 써서 인식되도록한다
			request.setAttribute("url", "MemberLogin.mem");
			return; //돌아가라는 뜻 여기 블럭들을 실행하다가 리턴으로 끝나기 때문에 아예 아래 부분을 실행하지도 않는다
		}
		
		//동일한 아아디가 검색되었다면 비밀번호가 맞는지 확인한다
		//입력받은 비밀번호를 암호화 시켜서 DB에 암호화 되어 저장 되어있는 비밀번호와 비교한다
		
		
		/*
		 * if(!vo.getPwd().equals(pwd)) { //부정적인걸 많이 써라 !사용
		 * request.setAttribute("message", "비밀번호가 틀립니다.\\n확인하고 다시 로그인 하세요"); //\를 제어 코드로
		 * 보기 때문에 \를 2개 써서 인식되도록한다 request.setAttribute("url", "MemberLogin.mem");
		 * return; //돌아가라는 뜻 여기 블럭들을 실행하다가 리턴으로 끝나기 때문에 아예 아래 부분을 실행하지도 않는다 }
		 */
		
		// 정상 인증이 완료되었을때 처리할 내용들을 기술한다
		//아이디를 쿠키로 저장처리 
		//방문포인트를 5회 미만일 경우게 10포인트 증가처리한다 방문횟수(총/오늘) 누적, 마지막 방문일자 처리(대부분 로그인 할때 처리 사람들이 로그아웃을 안하기 때문), 준회원을 자동으로 등업처리할경우 수행 등등 ==>> DB에 저장
		//처리 완료된 자료들은 작업수행이 지속되는 동안 꼭 필요한 정보만을 session에 저장처리한다
		
		//방문포인트 10증가, 방문카운트(총/오늘) 1증가, 마지막날짜(최종방문일자) 수정.  준회원은 따로 만드는게 편함
		
		Date today = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");//10자리라 앞부분만 떼면날짜나옴 뒤에 시간도 있음
		String strToday = sdf.format(today);
		
		//sql 밖에서 처리한것
		if(!strToday.equals(vo.getLastDate().substring(0, 10))) {
			//오늘 처음 방문한 경우 수행처리(오늘방문카운트를 1로하고, 기존 포인트+10)
			vo.setTodayCnt(1);
			vo.setPoint(vo.getPoint()+10);
		}
		
		else {
			//오늘 다시 방문한 경우(오늘 방문 카운트+1 포인트증가? 오늘 방문횟수가 5회까지만 포인트+10)
			vo.setTodayCnt(vo.getTodayCnt()+1);
			if(vo.getTodayCnt() <=5 ) vo.setPoint(vo.getPoint()+10);
			
		}
		//dao.setPointPlus(mid);
		
		//세션에 저장할 항목 : mid, nickName
		HttpSession session = request.getSession();
		session.setAttribute("sMid", mid);
		session.setAttribute("sNickName", vo.getNickName()); //vo로 가져왔음
		
		request.setAttribute("message", mid+"님 로그인 되었습니다"); //\를 제어 코드로 보기 때문에 \를 2개 써서 인식되도록한다
		request.setAttribute("url", "MemberMain.mem");
		
		
		
	}

}
