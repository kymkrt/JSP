package study2.photoView;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import study2.StudyInterface;

public class PhotoViewDeleteCommand implements StudyInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String flag=request.getParameter("flag")==null ? "" : request.getParameter("flag");
		String fileName=request.getParameter("fileName")==null ? "" : request.getParameter("fileName");
		String selectFile = request.getParameter("selectFile")==null ? "" : request.getParameter("selectFile");//그냥 받고 나서 배열처리해야함 
		//안넘어기 때문?
		String[] selectFileArray = selectFile.split("/");
		
		//파일의 진짜 경로
		String realPath = request.getServletContext().getRealPath("/images/photoView/"); //마지막에 /가 마지막 /주의
		
		String res = "0";
		
		if(flag.equals("s")) {
			new File(res).delete();
			res = "1";
		}
		else {
			for(int i=0; i<selectFileArray.length; i++) {
				File file = new File(realPath+selectFileArray[i]);
				if(file.exists()) {
					file.delete();
					res = "1";
				}
			}
		}
		response.getWriter().write(res);
	}

}
