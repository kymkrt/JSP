package guest;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import study2.database.DbTestDAO;

public class GuestListCommand2 implements GuestInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		GuestDAO dao = new GuestDAO();
		
		//ArrayList<E> = dao.getGuestList();
		//60퍼는 그냥 List쓴다
		List<GuestVO> vos = dao.getGuestList();
		
		
		request.setAttribute("vos", vos);
		//전체 글의 갯수
		request.setAttribute("guestCnt", vos.size());
	}

}
