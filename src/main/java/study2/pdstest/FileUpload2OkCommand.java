package study2.pdstest;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import study2.StudyInterface;

public class FileUpload2OkCommand implements StudyInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String realPath = request.getServletContext().getRealPath("/images/pdstest"); //서버의 저장될 파일의 경로
		int maxSize = 1024*1024*10;  //1024Byte=1KB=2^10, 1MB=1024KByte=2^20Byte=1024B*1024B 10메가. 계산해서 넣어도된다
		String encoding = "UTF-8";
		
		//파일 업로드 처리(객체 생성과 동시에 자동 업로드)
		MultipartRequest multipartRequest = new MultipartRequest(request, realPath, maxSize, encoding, new DefaultFileRenamePolicy());//앞의 4개는 필수 뒤는 기타
		//매번 생성하기 귀찮으니까  new로 생성해서 넣는다
		
		//업로드된 파일의 정보를 추출시켜본다
		//multipartRequest에 넘어간것이므로 여기서 봐야한다 
		String originalFileName1 = multipartRequest.getOriginalFileName("fName1"); //form에서 name으로 넘어오는것이므로 form의 name태그의 이름을 써야함
		String originalFileName2 = multipartRequest.getOriginalFileName("fName2"); //form에서 name으로 넘어오는것이므로 form의 name태그의 이름을 써야함
		String originalFileName3 = multipartRequest.getOriginalFileName("fName3"); //form에서 name으로 넘어오는것이므로 form의 name태그의 이름을 써야함
		String filesystemName1 = multipartRequest.getFilesystemName("fName1");
		String filesystemName2 = multipartRequest.getFilesystemName("fName2");
		String filesystemName3 = multipartRequest.getFilesystemName("fName3");
		
		System.out.println("원본 파일명 "+ originalFileName1);
		System.out.println("원본 파일명 "+ originalFileName2);
		System.out.println("원본 파일명 "+ originalFileName3);
		System.out.println();
		System.out.println("서버에 저장된 파일명 "+ filesystemName1);
		System.out.println("서버에 저장된 파일명 "+ filesystemName2);
		System.out.println("서버에 저장된 파일명 "+ filesystemName3);
		System.out.println();
		System.out.println("서버에 저장된 파일경로 "+ realPath);
		
		//String nickName = request.getParameter("nickName")==null ? "" : request.getParameter("nickName");
		String nickName = multipartRequest.getParameter("nickName")==null ? "" : multipartRequest.getParameter("nickName");
		System.out.println("nickName : "+nickName);
		
		//BackEnd 파일체크
		if(originalFileName1 != null && !originalFileName1.equals("") && originalFileName2 != null && !originalFileName2.equals("") && originalFileName3 != null && !originalFileName3.equals("")) {
			request.setAttribute("message", "파일전송 완료");
		}
		else {
			request.setAttribute("message", "파일전송 실패");
		}
		
		request.setAttribute("url", "FileUpload2.st");
	}

}
