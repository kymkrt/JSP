package study2.ajax;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import study2.database.DbTestDAO;
import study2.database.DbTestVO;

//디렉토리 패턴이라 앞에/가 필수
@WebServlet("/AjaxIdCheck2_3") 
public class AjaxIdCheck2_3 extends HttpServlet{//서블릿에서 도와주는것 즉 순수 자바가 아님
	
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String mid = request.getParameter("mid")==null ? "" : request.getParameter("mid");
		
		DbTestDAO dao = new DbTestDAO();
			
		DbTestVO vo = dao.getIdSearch(mid);
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("mid", vo.getMid());
		map.put("name", vo.getName());
		map.put("age", vo.getAge()+"");
		map.put("gender", vo.getGender());
		map.put("address", vo.getAddress());
		
		System.out.println("map: "+map);
		
		//map 형식의 자료를 JSON 형식으로 변환처리된다
		JSONObject jObj = new JSONObject(map);	
		System.out.println("jObj: "+jObj);
		
		//jObj을 JSON객체의  문자열로 변환
	//여기는 생략해도 됨 실무에서도 보통 생략한다
		String str = jObj.toJSONString(); //문자로 바꾸는것
		//parse 문자열로 넘어온걸 자바스크립트 객체로 바꾸는것 자바스크립트에 있다
		
//		response.getWriter().write(str); //원래는 이렇게 다 바꿔야한다
		response.getWriter().write(jObj+""); //이렇게 보내도 되긴 한다 자바스크립트는 유연해서 형식만 비슷하면이렇게 바꾼다
	}
}
