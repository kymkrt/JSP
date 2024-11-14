package study2.photoView;

import java.io.IOException;
import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import study2.StudyInterface;

public class PhotoView2OkCommand implements StudyInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String realPath = request.getServletContext().getRealPath("/images/photoView"); //서버의 저장될 파일의 경로
		int maxSize = 1024*1024*30;  //1024Byte=1KB=2^10, 1MB=1024KByte=2^20Byte=1024B*1024B 20메가. 계산해서 넣어도된다
		String encoding = "UTF-8";
		
		//파일 업로드 처리(객체 생성과 동시에 자동 업로드)
		MultipartRequest multipartRequest = new MultipartRequest(request, realPath, maxSize, encoding, new DefaultFileRenamePolicy());//앞의 4개는 필수 뒤는 기타
		//매번 생성하기 귀찮으니까  new로 생성해서 넣는다
		
		//업로드된 파일의 정보를 추출 객체로 넘어올때는 열거형으로 넘어오기 때문에 아래를 사용
		Enumeration fileNames = multipartRequest.getFileNames(); //제네릭은 모르면 생략가능
		
		String file = "";
		String ofName = ""; //오리지날 파일 네임
		String fsName = ""; //파일 시스템 네임
		
		
		//while문을 이터레이터 방식으로 돌린다 몇개가 넘어오는지 알수 없기 때문
		while(fileNames.hasMoreElements()) { //hasMoreElements() 있으면 참 없으면 거짓
			file = (String)fileNames.nextElement(); //파일명이니까 String 객체라서 String으로 형변환
			ofName += multipartRequest.getOriginalFileName(file) + "/";
			fsName += multipartRequest.getFilesystemName(file) + "/";
		}
		ofName = ofName.substring(0, ofName.lastIndexOf("/"));
		fsName = fsName.substring(0, fsName.lastIndexOf("/"));
		
		System.out.println("원본 파일명집합 : "+ofName);
		System.out.println("저장된 서버 파일명집합 : "+fsName);
		System.out.println("fName : " + multipartRequest.getParameter("fName"));
		
		
		if(!ofName.equals("")) {
			request.setAttribute("message", "파일이 업로드 되었습니다");
		}
		else {
			request.setAttribute("message", "파일이 업로드 실패");
		}
		request.setAttribute("url", "PhotoView2.st");
	}

}
