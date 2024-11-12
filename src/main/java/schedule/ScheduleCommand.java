package schedule;

import java.io.IOException;
import java.util.Calendar;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class ScheduleCommand implements ScheduleInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//오늘날짜 저장
		Calendar calToday = Calendar.getInstance();//싱글톤객체라 생성할필요없이 갯인스턴스 사용
		int toYear = calToday.get(Calendar.YEAR);
		int toMonth = calToday.get(Calendar.MONTH); //0부터시작하기 때문에 1을 더해야 우리 월이 나온다
		int toDay = calToday.get(Calendar.DATE);
		
		//화면에 보여주는 년월 세팅
		int yy = request.getParameter("yy")==null? toYear : Integer.parseInt(request.getParameter("yy"));
		int mm = request.getParameter("mm")==null? toMonth : Integer.parseInt(request.getParameter("mm"));
		
		if(mm<0) {
			yy--;
			mm = 11;
		}
		if(mm>11) {
			yy++;
			mm = 0;
		}
		
		//선택한 날짜를 해당 년월일로 세팅(일은 첫날(1)로 처리)
		calToday.set(yy, mm, 1); //오늘날짜를 세팅한것 단 받은연월의 달력으로 해야해서 받은값으로 처리한다
		
		//세팅한 날짜의 해당월의 마지막 일자
		int lastDay = calToday.getActualMaximum(Calendar.DAY_OF_MONTH); //마지막월의 일을 가져오겠다
		
		//세팅한날짜의 해당 첫번째 일자의 요일을 구한다(일:1 월:2 화:3...)
		int startWeek = calToday.get(Calendar.DAY_OF_WEEK);

		//화면에 보여주는 달력변수 저장
		request.setAttribute("yy", yy);
		request.setAttribute("mm", mm);
		request.setAttribute("lastDay", lastDay);
		request.setAttribute("startWeek", startWeek);
		
		//오늘날짜 저장
		request.setAttribute("toYear", toYear);
		request.setAttribute("toMonth", toMonth);
		request.setAttribute("toDay", toDay);
		
		//DB에 저장된 일정 정보들을 가져와서 준비한다
		HttpSession session = request.getSession();
		String mid  = (String)session.getAttribute("sMid");
		
		//날짜편집 : 2024-5-9 == >> 2024-05-09
		String ym = "";
		if((mm+1) < 10) ym = yy + "-0" +(mm+1);
		else ym = yy + "-" + (mm+1);
		
		ScheduleDAO dao = new ScheduleDAO();
	//파트를 안넣은 리스트 1 넣은 리스트 0
		List<ScheduleVO> vos = dao.getScheduleList(mid, ym, 0); // 0:partCnt, 1:List
		
		request.setAttribute("vos", vos);
	}

}
