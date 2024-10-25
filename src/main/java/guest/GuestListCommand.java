package guest;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import study2.database.DbTestDAO;

public class GuestListCommand implements GuestInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		GuestDAO dao = new GuestDAO();
		
		//페이지처리
		//1. 현재 페이지 번호를 구한다(pag)
		int pag = request.getParameter("pag")==null ? 1 : Integer.parseInt(request.getParameter("pag")); //처음에는 페이지가 안넘어온다=첫페이지 1
		
		//2. 한페이지 분량을 구한다 (pagSize)
		int pageSize = request.getParameter("pageSize")==null ? 5 : Integer.parseInt(request.getParameter("pageSize"));
		
		//3. 총 레코드 건수를 구한다 (totRecCnt) - sql 명령어 중에서 count함수 이용
		int totRecCnt = dao.getTotRecCnt();
		
		//4. 총 페이지 건수를 구한다(totPage) 딱떨어지면 그냥 쓰고 아니면 1더해주기
		int totPage = (totRecCnt % pageSize)==0 ? (totRecCnt / pageSize) : (totRecCnt / pageSize) + 1;
		
		//5. 현재 페이지에서 출력되는 '시작 인덱스 번호'를 구한다 (startIndexNo)
		int startIndexNo = (pag - 1) * pageSize;
		
		//6. 현재 표시할 화면에서 시작되는 시작번호를 구한다 (curScrStartNo)
		int curScrStartNo = totRecCnt - startIndexNo;
		
		//한페이지에 표시할 건수만을 DB에서 검색하여 가져온다
		
		//ArrayList<E> = dao.getGuestList();
		//60퍼는 그냥 List쓴다
		List<GuestVO> vos = dao.getGuestList(startIndexNo, pageSize);
		
		
		request.setAttribute("vos", vos);
		request.setAttribute("pag", pag);
		request.setAttribute("pageSize", pageSize);
		request.setAttribute("totRecCnt", totRecCnt);
		request.setAttribute("totPage", totPage);
		//startIndexNo는 값을 꺼내기 위해 쓴거라 뷰로 안보내도됨
		request.setAttribute("curScrStartNo", curScrStartNo);
		
		
		//전체 글의 갯수
		//request.setAttribute("guestCnt", vos.size()); curScrStartNo가 있기 때문에 필요 없음
	}

}
