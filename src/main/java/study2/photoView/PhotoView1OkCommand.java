package study2.photoView;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import study2.StudyInterface;

public class PhotoView1OkCommand implements StudyInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		/*
		 COS라이브러리 - MultipartRequest.class(파일업로드객체) / DefaultFileRenamePolicy(파일명중복방지를 위한 클래스-파일명1, 파일명2, 파일명3...) 
		 사용법 : MultipartRequest((서블릿)저장소(reqeust), 서버의 저장될 파일의 경로, 서버에 저장될 파일의 최대용량, 코드변환방식(utf-8 같은거) /여기까지가 필수/
		 		기타 옵션(파일명중복방지 클래스 등)
		 )
		 
		 	저장되는 서버 웹사이트의 절대경로(/webapp) : getRealPath("/") request객체임 
			ServletContext application = request.getServletContext();
			application.getRealPath("/");
			이렇게 줄여도됨
			request.getServletContext().getRealPath("/");  /가 webapp이다 
		  */
		
		String realPath = request.getServletContext().getRealPath("/images/photoView/"); //파일이라 /마지막에 붙여야함
		int maxSize = 1024*1024*10;  //1024Byte=1KB=2^10, 1MB=1024KByte=2^20Byte=1024B*1024B 10메가. 계산해서 넣어도된다
		String encoding = "UTF-8";
		
		//파일 업로드 처리(객체 생성과 동시에 자동 업로드)
		MultipartRequest multipartRequest = new MultipartRequest(request, realPath, maxSize, encoding, new DefaultFileRenamePolicy());
		//매번 생성하기 귀찮으니까  new로 생성해서 넣는다
		
		//업로드된 파일의 정보를 추출시켜본다
		//multipartRequest에 넘어간것이므로 여기서 봐야한다 
		String originalFileName = multipartRequest.getOriginalFileName("fName"); //form에서 name으로 넘어오는것이므로 form의 name태그의 이름을 써야함
		String filesystemName = multipartRequest.getFilesystemName("fName");
		
		System.out.println("원본 파일명 "+ originalFileName);
		System.out.println("서버에 저장된 파일명 "+ filesystemName);
		System.out.println("서버에 저장된 파일경로 "+ realPath);
		
		//공백이 올수도 있어서 처리해야함
		String content = (multipartRequest.getParameter("content")==null || multipartRequest.getParameter("content").equals("")) ? "내용없음" : multipartRequest.getParameter("content");
		//항상 equls 보다는 null을 먼저 비교해야한다
		
		System.out.println("content : "+content);
		
		//BackEnd 파일체크
		if(originalFileName != null && !originalFileName.equals("")) {
			request.setAttribute("message", "파일전송 완료");
		}
		else {
			request.setAttribute("message", "파일전송 실패");
		}
		
		request.setAttribute("url", "PhotoView.st");
	}

}
