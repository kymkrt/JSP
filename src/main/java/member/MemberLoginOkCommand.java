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
import guest.GuestDAO;

public class MemberLoginOkCommand implements MemberInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String mid = request.getParameter("mid")==null ? "" : request.getParameter("mid");
		String pwd = request.getParameter("pwd")==null ? "" : request.getParameter("pwd");
		
		//DB 연결
		MemberDAO dao = new MemberDAO();
		
		MemberVO vo=dao.getMemberIdCheck(mid); //원래는 pwd도 넘기지만 지금은 salt를 쓰기 때문에 id만 넘김
		
		if(vo.getMid() == null) {
			request.setAttribute("message", "회원정보가 없습니다 \\n 확인하고 다시 로그인해주세요");
			request.setAttribute("url", "MemberLogin.mem");
			return;
		}
		
		//저장된 비밀번호에서 salt키를 분리시켜서 다시 암호화후 비교처리해야한다 
		String salt = vo.getPwd().substring(0,3);
		
		SecurityUtil security = new SecurityUtil();
		pwd = security.encryptSHA256(salt+pwd);
		
		if(!vo.getPwd().substring(3).equals(pwd)) { //결과적으로 id가 일치하는 사람이 없다는것
			request.setAttribute("message", "회원 정보가 없습니다.\\n확인하고 다시 로그인 하세요"); //\를 제어 코드로 보기 때문에 \를 2개 써서 인식되도록한다
			request.setAttribute("url", "MemberLogin.mem");
			return; //돌아가라는 뜻 여기 블럭들을 실행하다가 리턴으로 끝나기 때문에 아예 아래 부분을 실행하지도 않는다
		}
		
		//--------------------------------------------
		//이곳부터는 로그인 처리가된 회원들의 작업내역들을 입력처리한다
		
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
		
		//세션에 저장할 항목 : mid, nickName
		HttpSession session = request.getSession();
		session.setAttribute("sMid", mid);
		session.setAttribute("sNickName", vo.getNickName()); //vo로 가져왔음
		session.setAttribute("sLevel", vo.getLevel());
		//최근 방문일을 세션에 담아둔다(쿠키도 가능) 리퀘스트에 담으면 매번 가지고 다녀야해서 불편하다
		session.setAttribute("sLastDate", vo.getLastDate());
		
		//회원등급별 등급명칭을 strLevel 변수에 저장한다 (자동등업처리에 써야 해서 메소드로 만들었다)
		/*
		 * String strLevel = ""; if(vo.getLevel() == 0) strLevel = "관리자"; else
		 * if(vo.getLevel() == 1) strLevel = "준회원"; else if(vo.getLevel() == 2) strLevel
		 * = "정회원"; else if(vo.getLevel() == 3) strLevel = "우수회원";
		 */
		
		//회원등급별 등급명칭을 strLevel 변수에 저장한다 (자동등업처리에 써야 해서 메소드로 만들었다)
		String strLevel = strLevelProcess(vo.getLevel());
		session.setAttribute("sStrLevel", strLevel);
		
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
		dao.setMemberInforUpdate(vo);
		
		// 준회원인경우 정회원으로 자동등업처리(조건:총방문회수 10회이상, 방명록글수 2개이상)
		int levelSw = 0;
		if(vo.getLevel() == 1) {
			GuestDAO gDao = new GuestDAO();
			vo = dao.getMemberIdCheck(mid);
			if(vo.getVisitCnt() >= 10 && gDao.getGuestCnt(mid, vo.getName(), vo.getNickName()) >= 2) {
				dao.setMemberLevelUpdate(vo.getIdx(), 2);
				session.setAttribute("sLevel", 2);
				session.setAttribute("strLevel", strLevelProcess(2));
				levelSw = 1;
			}
		}
		//스위치를 써서 자동등업이 됐을때 딱 한번만 등급업 메세지를 띄운것
		if(levelSw != 0) request.setAttribute("message", mid + "님 축하합니다.\\n정회원이 되셨습니다.");
		else request.setAttribute("message", mid + "님 로그인 되었습니다.");
		
		
//		if(vo.getVisitCnt() > 10 && vo.getLevel()==1) {
//			dao.setMemberLevelUpdate(mid);
//		}
		
		request.setAttribute("message", mid+"님 로그인 되었습니다"); //\를 제어 코드로 보기 때문에 \를 2개 써서 인식되도록한다
		request.setAttribute("url", "MemberMain.mem");
		
		
		
	}

	//회원등급별 등급명칭을 strLevel 변수에 저장한다 (자동등업처리에 써야 해서 메소드로 만들었다)
	private String strLevelProcess(int level) {
		String strLevel = ""; 
		if(level == 0) strLevel = "관리자"; 
		else if(level == 1) strLevel = "준회원"; 
		else if(level == 2) strLevel = "정회원"; 
		else if(level == 3) strLevel = "우수회원";
		return strLevel;
	}

}
