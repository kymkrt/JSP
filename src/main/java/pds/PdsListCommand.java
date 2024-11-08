package pds;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class PdsListCommand implements PdsInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//페이징 처리
		
		//
		PdsDAO dao = new PdsDAO();
		ArrayList<PdsVO> vos = dao.getPdsList();
		
		
		
		request.setAttribute("vos", vos);
	}

}
