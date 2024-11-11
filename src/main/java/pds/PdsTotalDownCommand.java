package pds;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class PdsTotalDownCommand implements PdsInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int idx = (request.getParameter("idx")==null || request.getParameter("idx").equals("")) ? 0	 : Integer.parseInt(request.getParameter("idx"));
		
		//idx로 DB에 저장된 파일의 정보(업로드시파일명(fName)/서버저장파일명(fSName))를 가져온다
		PdsDAO dao = new PdsDAO();
		PdsVO vo = dao.getPdsContent(idx);
		
		//원본파일명과 서버저장파일명을 각각 분리 시켜준다
		String[] fNames = vo.getfName().split("/");
		String[] fSNames = vo.getfSName().split("/");
		
//		int i = 0; //fSNames를 찍기 위한것
//		for(String fName : fNames) {
//			System.out.print((i+1)+"원본파일 : "+fName + " , ");
//			System.out.println("서버파일 : "+fSNames[i]);
//			i++;
//		}
		
		//파일 압축 다운로드시 필요한 객체를 준비시킨다 전부 자바파일
		FileInputStream fis = null; //몇번 생성해야 할지 모르니까 null로 준비만 해둠
		FileOutputStream fos = null; //받아줄곳?
		ZipOutputStream zos = null;
		ServletOutputStream sos = null;//웹에서 서블릿에서 받아야 한다?
		
		//작업에 필요한 경로 설정 / 저장시킬 압출파일명 설정
		String realPate =request.getServletContext().getRealPath("/images/pds/"); //파일명할때는 뒤에 /가 있어야 한다 경로명일때는 필요없음
		String zipPath = request.getServletContext().getRealPath("/images/pds/temp/");
		String zipName = vo.getTitle()+".zip";
		
		//원본파일을 압축/저장시킬 객체 생성
		fos = new FileOutputStream(zipPath + zipName); //압축할건 temp에 넣기 때문에 zipPath 거기에 zipName으로 저장
		zos = new ZipOutputStream(fos); //아웃풋스트림을 넣어준다
		
		//반복문 안에 쓰면 귀찮아서 밖에서 선언
		byte[] buffer = new byte[2048]; //읽어서 전부
		int size = 0;
		
		//zip파일 만들기  각각의 파일을 압축처리하기 위한 각 fis을 생성후 zos에 처리한다 
		for(int i=0; i<fSNames.length; i++) {
			//인풋객체를 만들어서 출력객체에 넣는다 
			File file = new File(realPate + fSNames[i]);//서버에 있는거라 realPath
			fis = new FileInputStream(file);
			//input 만든걸 넣는다 
			zos.putNextEntry(new ZipEntry(fNames[i]));//자료를 하나 넣는다 zip파일에 넣을때는 원본 이름으로 넣어준다
		//여기까지가 껍데기를 만든것
		
			while((size = fis.read(buffer)) != -1) {
				zos.write(buffer, 0, size);
			}
			zos.flush();
			zos.closeEntry(); //각각의 파일에 대해 닫아준다
			fis.close(); //열었던거 닫는다
		}
		zos.close();//zipOuptStream을 닫는다
		//여기까지 하면 zip파일이 temp폴더에 받아진다 이걸 이제 다운만 받으면 된다
		//여기까지의 작업은 전부 서버안이다 클라이언트아님
		
		//서버에서의 압축작업이 완료되면 서버의 압축파일을 클라이언트로 전송하고 서버에 존재하는 압축파일은 삭제한다 (남겨도 되긴함)
		
		
		
		/* HTTP프로토콜 형식에 맞도록 헤더에 전송할 파일의 정보를 담아준다 */
		//서버 요청은 전부 서블릿컨텍스트 													파일 타입인데 스트링을 요구하기 때문에 바꿔줌
		
		//여기부터
		String downLoadName = "";
		//사용하는 브라우저의 형식에 맞춰야한다 근데 지금은 다 통일됨 
		if(request.getHeader("user-agent").indexOf("MSIE") != -1) { //user-agent가 브라우저다
			//여기부터 zip 파일을 처리하는거다
			downLoadName = new String(zipName.getBytes("UTF-8"), "8859_1"); //스트링 객체에서 코드변환하는것 바이트 단위로 넘어오는걸 하나로 묶어주는 객체
		}
		else {
			downLoadName = new String(zipName.getBytes("EUC-KR"), "8859_1");
		}
		//앞의 정보들을 추출(확인)하여 헤더에 첨부
		//다 예약어들이라 그대로 써야함
		response.setHeader("Content-Disposition", "attachment;filename="+downLoadName);  //사용자한테 보내는거니까 response
		//여기까지 한묶음
		
		//서버와 클라이언트 간의 이동 출발하는곳(서버) 인풋 받아주는곳(클라이언트) 아웃풋
		//자바파일 에서도 스트리밍 방식으로 한다 그래서 서버가 인풋스트림 라이언트가 아웃풋스트림
		
		fis = new FileInputStream(zipPath+zipName); //아직 넘긴게 아니라 준비
		sos = response.getOutputStream(); //사용자 측으로 가는것 그래서 생성이 아니라 http개념
		
		while((size = fis.read(buffer)) != -1) {
			sos.write(buffer, 0, size);
		}
		
		//사용한 객체들 반납 마지막걸 먼저
		sos.flush(); //다 처리 하고 남은것도 다 버려라
		sos.close();
		fis.close();
		
		//전송이 끝나면 서버의 압축파일을 삭제처리한다 
		//당연히 있기 때문에 물어볼필요없이 생성해서 지우면 된다
		new File(zipPath+zipName).delete();//무조건 생성
		
		//다운로드수 증가처리
		dao.setPdsDownNumCheck(idx);
		
	}
	
}
