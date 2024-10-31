package member;

import java.io.IOException;
import java.time.LocalDate;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.SecurityUtil;

public class MemberUpdateOkCommand implements MemberInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//아이디는 안넘어오기 때문에 히든으로 하던가 세션으로 해야함
		HttpSession session = request.getSession();
		String mid = (String) session.getAttribute("sMid");
		
		//String mid = request.getParameter("mid")==null ? "" : request.getParameter("mid");
		String nickName = request.getParameter("nickName")==null ? "" : request.getParameter("nickName");
		String name = request.getParameter("name")==null ? "" : request.getParameter("name");
		String gender = request.getParameter("gender")==null ? "" : request.getParameter("gender");
		String birthday = request.getParameter("birthday")==null ? "" : request.getParameter("birthday");
		String tel = request.getParameter("tel")==null ? "" : request.getParameter("tel");
		String address = request.getParameter("address2")==null ? "" : request.getParameter("address2");
		String email = request.getParameter("email")==null ? "" : request.getParameter("email");
		String content = request.getParameter("content")==null ? "" : request.getParameter("content");
		String photo = request.getParameter("photo")==null ? "" : request.getParameter("photo");
		String userInfor = request.getParameter("userInfor")==null ? "" : request.getParameter("userInfor");
		
		if(photo.equals("")) photo = "noimages.jpg";
		
		MemberVO vo = new MemberVO();
		
		vo.setMid(mid); //고유 번호를 찾아서 여기에 해당하는 내용을 고쳐야 하기 때문에 mid나 idx가 넘어가야한다
		vo.setNickName(nickName);
		vo.setName(name);
		vo.setGender(gender);
		vo.setBirthday(birthday);
		vo.setTel(tel);
		vo.setAddress(address);
		vo.setEmail(email);
		vo.setContent(content);
		vo.setPhoto(photo);
		vo.setUserInfo(userInfor);
		
		System.out.println("MemeberVO : "+vo); //이렇게 다써줘야 좋다
		
		MemberDAO dao = new MemberDAO();
		
		//게터 세터 외에는 굳이 set get 넣을 필요없지만 편의를 위해 쓴다
		int res = dao.setMemberUpdateOk(vo);
		
		if(res != 0) {
			session.setAttribute("sNickName", vo.getNickName());
			request.setAttribute("message", "회원정보가 수정되었습니다");
			request.setAttribute("url", "/MemberMain.mem"); //확장자패턴
		}else {
			request.setAttribute("message", "회원 수정 실패");
			request.setAttribute("url", "/MemberUpdate.mem"); //확장자패턴
		}
	}

}
