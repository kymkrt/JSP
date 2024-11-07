package study2.pdstest;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import study2.StudyInterface;

public class JavaFileDownloadCommand implements StudyInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String realPath = request.getServletContext().getRealPath("/images/psdtest/"); //가상경로. 뷰에서는 콘텍스트경로(ctp) 써줘야함
																																		//마지막 /가 언제 붙고 안붙는지 프로그래머가 판단해야한다
		String fileName = request.getParameter("file")==null ? "" : request.getParameter("file");
		
		//자바관련?은 전부 생성해야한다
		File file = new File(realPath + fileName);//io 로 만들어야한다
		
		/* HTTP프로토콜 형식에 맞도록 헤더에 전송할 파일의 정보를 담아준다 */
		//서버 요청은 전부 서블릿컨텍스트 													파일 타입인데 스트링을 요구하기 때문에 바꿔줌
		String mimeType = request.getServletContext().getMimeType(file.toString()); // 내가 다운받겠다고 결정한 파일의 이름
		if(mimeType == null) {
			//응답이라 response 객체
			response.setContentType("application/octet-stream"); //2진 바이너리 형식으로 줘야한다
		}
		
		String downLoadName = "";
		//사용하는 브라우저의 형식에 맞춰야한다 근데 지금은 다 통일됨 
		if(request.getHeader("user-agent").indexOf("MSIE") == -1) { //user-agent가 브라우저다
			downLoadName = new String(fileName.getBytes("UTF-8"), "8859_1"); //스트링 객체에서 코드변환하는것 바이트 단위로 넘어오는걸 하나로 묶어주는 객체
		}
		else {
			downLoadName = new String(fileName.getBytes("EUC-KR"), "8859_1");
		}
		
		//앞의 정보들을 추출(확인)하여 헤더에 첨부
		response.setHeader("Content-Disposition", "attachment;filename="+downLoadName);  //사용자한테 보내는거니까 response
		
		//서버와 클라이언트 간의 이동 출발하는곳(서버) 인풋 받아주는곳(클라이언트) 아웃풋
		//자바파일 에서도 스트리밍 방식으로 한다 그래서 서버가 인풋스트림 라이언트가 아웃풋스트림
		
		FileInputStream fis = new FileInputStream(file); //아직 넘긴게 아니라 준비
		//FileOutputStream fos = null;
		ServletOutputStream sos = response.getOutputStream(); //사용자 측으로 가는것 그래서 생성이 아니라 http개념
		
		//fis에서 sos로 가는거
		byte[] buffer = new byte[2048];
		int size = 0;
		while((size = fis.read(buffer)) != -1) {
			sos.write(buffer, 0, size);
		}
		
		//사용한 객체들 반납 마지막걸 먼저
		sos.flush(); //다 처리 하고 남은것도 다 버려라
		sos.close();
		fis.close();
		
	}

}
