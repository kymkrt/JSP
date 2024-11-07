package study2.pdstest;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import study2.StudyInterface;

public class FileDeleteCommand implements StudyInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String fileName = request.getParameter("fileName")==null ? "" : request.getParameter("fileName");
		//파일의 진짜 경로
		String realPath = request.getServletContext().getRealPath("/images/pdstest/"); //마지막에 pdstest/ 이 마지막 /주의
		
		//파일객체를 무조건 생성해야한다  특히 io에 있는 File
		File file = new File(realPath + fileName);
		
		String res = "0";
		
		if(file.exists()) {
			file.delete();
			res = "1";
		}
		
		response.getWriter().write(res);
	}

}
