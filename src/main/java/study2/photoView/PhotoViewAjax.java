package study2.photoView;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Calendar;
import java.util.UUID;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

//ajax에서는 cos라이브러리 사용불가
@WebServlet("/PhotoViewAjax")
@MultipartConfig(//어노테이션에서 구별은 ;가 아니라 ,
		fileSizeThreshold = 1024*1024*2, //메모리에 저장 되는 임시파일크기 설정
		maxFileSize = 1024*1024*5, //1개 파일 업로드시의 최대용량
		maxRequestSize = 1024*1024*20 //한번에 전송할수 있는 최대 용량
		)//마지막에는 ,쓰면 안됨
public class PhotoViewAjax extends HttpServlet{ //이 서블릿이 자바를 웹에서 실행하게 도와주는것 스프링에서는 다르다 
	
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String res = "0";
		
		String realPath = request.getServletContext().getRealPath("images/photoView/");//파일명일때는 마지막에 / 필수
		
		//java에서 제공하는 part객체
		//request 객체안의 getPart()메소드 사용. Part클래스 타입으로 선언한다 
		Part filePart = request.getPart("fName"); //넘어오는 파일의 정보를 받아온다 name으로 받음
		String fileName = filePart.getSubmittedFileName();
		System.out.println("fileName : " + fileName);
		
		if(fileName != null && !fileName.isEmpty()) {
			System.out.println("22222asdfasdf");
			InputStream fis = filePart.getInputStream(); //가져오는 객체를 만든것 껍데기만 만들었다
			
			//파일명 중복처리 방지(UUID 활용) 열거형이라 클래스명으로 바로 불러쓸수 있다
			String uid = UUID.randomUUID().toString().substring(0, 8); //32글자 들어옴 너무 길어서 8글자
			
		// 중복방지를 위한 파일명 조합하기(파일형식: 파일명_중복방지코드.확장자) 이렇게 파일명이 앞에 있는게 찾기 쉽다 
			fileName = fileName.substring(0, fileName.lastIndexOf("."))+"_"+fileName.substring(fileName.lastIndexOf("."));
			System.out.println("fileName : "+fileName);
			
			//껍데기만 만든것
			FileOutputStream fos = new FileOutputStream(realPath + fileName); //파일경로+파일이름
			
			//생성된 객체에 파일의 내용을 2048Byte씩 채워 보내어준다
			byte[] buffer = new byte[2048];
			int size=0;
			while ((size=fis.read()) != -1) {
				fos.write(buffer, 0, size);
			}
			fos.flush();
			fos.close();
			fis.close();
			
			res = fileName;
		}
		/*---------------------------*/
		response.getWriter().write(res+"");
	}
}
