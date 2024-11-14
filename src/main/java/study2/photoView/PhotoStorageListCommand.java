package study2.photoView;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import study2.StudyInterface;

public class PhotoStorageListCommand implements StudyInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//파일의 진짜 경로
		String realPath = request.getServletContext().getRealPath("/images/photoView"); //마지막에 pdstest/ 이 마지막 /주의
		
		String[] files = new File(realPath).list(); //list가 경로안에 있는 파일들의 정보를 다 읽어오는것 배열임
		
		request.setAttribute("files", files);
		request.setAttribute("fileCount", files.length);
	}

}
