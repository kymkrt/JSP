package pds;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class PdsDeleteCheckCommand implements PdsInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int idx = (request.getParameter("idx")==null || request.getParameter("idx").equals("")) ? 0	 : Integer.parseInt(request.getParameter("idx"));
		String[] fSNames = request.getParameter("fSName").split("/"); //있는걸 분리하는거라 널값처리 안해도됨
		
		//언제나 서버 실제 파일 먼저 삭제하고 DB 삭제해라 잘못하면 DB만 지워지고 파일이 남아있는 경우가 많다
		//서버에 존재하는 실제 파일 삭제
		String realPath = request.getServletContext().getRealPath("/images/pds/"); //경로만 쓸때는 마지막에 / 필요없음 파일쓸때는 마지막에 / 필요함
		//껍데기를 만들고 나서 지우던 만들던 해야함 
		for(String fSName : fSNames) {
			new File(realPath+fSName).delete();//io에 있는걸 사용해야한다
		}
		//DB에서 자료 삭제 처리
		PdsDAO dao = new PdsDAO();
		int res = dao.setPdsDeleteCheck(idx);
		
		response.getWriter().write(res+"");
	}

}
