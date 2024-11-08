package study2.pdstest;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Calendar;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import common.JavaGroupProcess;
import study2.StudyInterface;

//어노테이션은 클래스 위에서 선언해서 환경설정하는것
//보통 이거 설정으로 xml을 쓰는데 요새는 어노테이션을 많이 써서 우리도 이걸로 함
@MultipartConfig(//어노테이션에서 구별은 ;가 아니라 ,
		fileSizeThreshold = 1024*1024*2, //메모리에 저장 되는 임시파일크기 설정
		maxFileSize = 1024*1024*5, //1개 파일 업로드시의 최대용량
		maxRequestSize = 1024*1024*20 //한번에 전송할수 있는 최대 용량
		)//마지막에는 ,쓰면 안됨
@WebServlet("/FileUpload5Ok")
public class FileUpload5Ok extends HttpServlet {
	
	@Override
	public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String realPath = request.getServletContext().getRealPath("images/pdstest/");
		
		//request 객체안의 getPart()메소드 사용. Part클래스 타입으로 선언한다 
		Part filePart = request.getPart("fName"); //넘어오는 파일의 정보를 받아온다 name으로 받음
		String fileName = filePart.getSubmittedFileName();
		InputStream fis = filePart.getInputStream(); //가져오는 객체를 만든것 껍데기만 만들었다
		
		//파일명 중복 처리(날짜를 이용)- Date(sdf을 이용)나 Claender(내장 싱글톤 객체=생성할필요없음) 이용 
		//이렇게 하고 싶으면 아래 부분을 전부 메소드로 만들어서 호출만해서 쓸수 있도록 만들어야 한다
		Calendar cal =  Calendar.getInstance();//싱글톤은 거의 getInstance
		int yy = cal.get(Calendar.YEAR);
		int mm = cal.get(Calendar.MONTH) +1; //월은 0부터라 1을 더해야한다
		int dd = cal.get(Calendar.DAY_OF_MONTH);// 한자리수면 한자리로 나온다 그래서 공통메소드로 빼놔서 앞에 0을 붙이는 식으로 처리하면 좋다
		int hh = cal.get(Calendar.HOUR_OF_DAY);
		int mi = cal.get(Calendar.MINUTE);
		int ss = cal.get(Calendar.MILLISECOND);//천분의 1초 개념이라 3개 나옴 거의 중복되지 않는다 
		
		String strMM=mm+"", strDD=dd+"", strHH=hh+"", strMI=mi+"", strSS=ss+"", temp;
		
		if(mm<10) strMM = "0" + mm;
		if(dd<10) strDD = "0" + dd;
		if(hh<10) strHH = "0" + hh;
		if(mi<10) strMI = "0" + mi;
		if(ss<10) strSS = "0" + ss;
		temp = yy+strMM+strDD+strHH+strMI+strSS;
		//System.out.println("날짜 : "+yy+strMM+strDD+strHH+strMI+strSS);
		
		//아래처럼 만들어서 이렇게 쓸수 있다
		//JavaGroupProcess jgp = new JavaGroupProcess();
		//String temp = jgp.getTimeBaseFileName();
		
		// 중복방지를 위한 파일명 조합하기(파일형식: 중복방지코드_파일명.확장자)
		fileName = temp+"_"+ fileName;
		System.out.println("fileName : "+fileName);
		
		//껍데기만 만든것
		FileOutputStream fos = new FileOutputStream(realPath+fileName); //파일경로+파일이름
		
		//생성된 객체에 파일의 내용을 2048Byte씩 채워 보내어준다
		byte[] buffer = new byte[2048];
		int size=0;
		while ((size=fis.read()) != -1) {
			fos.write(buffer, 0, size);
		}
		fos.flush();
		fos.close();
		fis.close();
		
		request.setAttribute("message", "파일이 업로드 되었습니다");
		request.setAttribute("url", "FileUpload5.st");
		
		String viewPage = "/include/message.jsp";
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
	}

}
