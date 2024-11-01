package admin.member;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import admin.AdminInterface;
import guest.GuestVO;
import member.MemberDAO;
import member.MemberVO;

public class MemberListCommand implements AdminInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
																												//공백 오면 0이 나와서 관리자 리스트가 나오기 때문에 숫자를 999 같은 식으로 나만의 방식으로 정해야한다
		int level = (request.getParameter("level")==null || request.getParameter("level").equals("")) ? 999 : Integer.parseInt(request.getParameter("level"));		
		
		MemberDAO dao = new MemberDAO();

		//페이지처리
		//1. 현재 페이지 번호를 구한다(pag)
		int pag = request.getParameter("pag")==null ? 1 : Integer.parseInt(request.getParameter("pag")); //처음에는 페이지가 안넘어온다=첫페이지 1
		
		//2. 한페이지 분량을 구한다 (pagSize)
		int pageSize = request.getParameter("pageSize")==null ? 5 : Integer.parseInt(request.getParameter("pageSize"));//확장성 고려차원에서 이렇게 해둠 원래는 그냥 5해도된다
		
		//3. 총 레코드 건수를 구한다 (totRecCnt) - sql 명령어 중에서 count함수 이용
		int totRecCnt = dao.getTotRecCnt(level); // 여기서 레벨이 가야 된다
		
		//4. 총 페이지 건수를 구한다(totPage) 딱떨어지면 그냥 쓰고 아니면 1더해주기
		int totPage = (totRecCnt % pageSize)==0 ? (totRecCnt / pageSize) : (totRecCnt / pageSize) + 1;
		
		//5. 현재 페이지에서 출력되는 '시작 인덱스 번호'를 구한다 (startIndexNo)
		int startIndexNo = (pag - 1) * pageSize;//이걸로 사용자 페이지 갯수를 구한다?
		
		//6. 현재 표시할 화면에서 시작되는 시작번호를 구한다 (curScrStartNo)
		int curScrStartNo = totRecCnt - startIndexNo;
		
		//한페이지에 표시할 건수만을 DB에서 검색하여 가져온다
		
		//ArrayList<E> = dao.getGuestList();
		//60퍼는 그냥 List쓴다
		ArrayList<MemberVO> vos = dao.getMemberList(startIndexNo, pageSize, level);
		
		//블럭페이징처리 (시작블록을 0으로 처리 1로하는곳도 많음)
		//이 3가지는 그냥 공식처럼 생각하면 된다 이거 말고도 알고리즘은 많음
		//1. 블럭의 크기를 결정 (여기선 3으로 결정)
		int blockSize = 3;
		
		//2. 현재페이지가 속한 블록의 번호를 구한다. (예: 총레코드 수가 38개일경우 1페이지 분량 5개라면 총페이지수는 8개이다
		// 이때 0 블록은 1/2/3 1블록은 4/5/6 2블록은 7/8
		int curBlock = (pag - 1) / blockSize;
		
		//3. 마지막 블록을 구한다. 
		int lastBlock = (totPage - 1) / blockSize;
		
		request.setAttribute("vos", vos);
		request.setAttribute("pag", pag);
		request.setAttribute("pageSize", pageSize);
		request.setAttribute("totRecCnt", totRecCnt);
		request.setAttribute("totPage", totPage);
		//startIndexNo는 값을 꺼내기 위해 쓴거라 뷰로 안보내도됨
		request.setAttribute("curScrStartNo", curScrStartNo);
		
		request.setAttribute("blockSize", blockSize);
		request.setAttribute("curBlock", curBlock);
		request.setAttribute("lastBlock", lastBlock);
		
		request.setAttribute("level", level);
		
		//전체 글의 갯수
		//request.setAttribute("guestCnt", vos.size()); curScrStartNo가 있기 때문에 필요 없음
		
	}

}
