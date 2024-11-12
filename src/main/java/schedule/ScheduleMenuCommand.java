package schedule;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class ScheduleMenuCommand implements ScheduleInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String ymd = request.getParameter("ymd")==null ? "" : request.getParameter("ymd");
		//이젠 일까지 봐야 하므로 일을 분리해야함
		String[] ymds = ymd.split("-"); 
		//식으로 비교하는 방법으로 만들어도됨
		if(ymds[1].length() == 1) ymds[1] = "0"+ymds[1];
		if(ymds[2].length() == 1) ymds[2] = "0"+ymds[2];
		
		ymd = ymds[0]+"-"+ymds[1]+"-"+ymds[2];
		
		HttpSession session = request.getSession();
		String mid  = (String)session.getAttribute("sMid");
		
		ScheduleDAO dao = new ScheduleDAO();
		//파트를 안넣은 리스트 1 넣은 리스트 0
		List<ScheduleVO> vos = dao.getScheduleList(mid, ymd, 1); // 0:partCnt, 1:List
		
		request.setAttribute("vos", vos);
		request.setAttribute("ymd", ymd);
		request.setAttribute("scheduleCnt", vos.size());
		
	}

}
