package member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class MemberUpdateCommand implements MemberInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//넘어온게 없지만 세션은 있음 아이디는 고유한 정보라 이걸로 검색가능
		HttpSession session = request.getSession();
		String mid = (String) session.getAttribute("sMid"); //아이디를 넘겨 받지 않아서 세션에서 가져옴
		
		MemberDAO dao = new MemberDAO();
		MemberVO vo = dao.getMemberIdCheck(mid);//리턴타입을 잘봐야한다
		
		//전화번호 분리(-) 백엔드 처리
		String[] tel = vo.getTel().split("-");
		//공백처리 프론트 부분에 맥스사이즈가 4라서 공백이 있으면 그걸 지워야만 4글자를 칠수 있다
		if(tel[1].equals(" ")) tel[1] = "" ;
		if(tel[2].equals(" ")) tel[2] = "" ;
		request.setAttribute("tel1", tel[0]);
		request.setAttribute("tel2", tel[1]);
		request.setAttribute("tel3", tel[2]);
		//프론트에서는 jstl하고 c:set 써야함
		
		//주소 분리(/)
		String[] address = vo.getAddress().split("/");
		if(address[0].equals(" ")) address[0] = "";
		if(address[1].equals(" ")) address[1] = "";
		if(address[2].equals(" ")) address[2] = "";
		if(address[3].equals(" ")) address[3] = "";
		request.setAttribute("postcode", address[0]);
		request.setAttribute("address", address[1]);
		request.setAttribute("detailAddress", address[2]);
		request.setAttribute("extraAddress", address[3]);
		
		//이메일 주소 분리(@)
		String[] email = vo.getEmail().split("@");
		if(email[0].equals(" ")) email[0] = "";
		if(email[1].equals(" ")) email[1] = "";
		request.setAttribute("email1", email[0]);
		request.setAttribute("email2", email[1]);
		
		
		request.setAttribute("vo", vo);
	}

}
