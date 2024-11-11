package pds;

import java.io.IOException;
import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class PdsInputOkCommand implements PdsInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		String realPath = request.getServletContext().getRealPath("/images/pds"); //서버의 저장될 파일의 경로
		int maxSize = 1024*1024*30;  //1024Byte=1KB=2^10, 1MB=1024KByte=2^20Byte=1024B*1024B 20메가. 계산해서 넣어도된다
		String encoding = "UTF-8";
		
		//파일 업로드 처리(객체 생성과 동시에 자동 업로드)
		MultipartRequest multipartRequest = new MultipartRequest(request, realPath, maxSize, encoding, new DefaultFileRenamePolicy());//앞의 4개는 필수 뒤는 기타
		//매번 생성하기 귀찮으니까  new로 생성해서 넣는다
		
		//업로드된 파일의 정보를 추출 객체로 넘어올때는 열거형으로 넘어오기 때문에 아래를 사용? 여기서는 동적폼으로 여러개 넘어온거
		Enumeration fileNames = multipartRequest.getFileNames(); //제네릭은 모르면 생략가능
		
		String file = "";
		String ofName = ""; //오리지날 파일 네임
		String fsName = ""; //파일 시스템 네임
		
		
		//while문을 이터레이터 방식으로 돌린다 몇개가 넘어오는지 알수 없기 때문
		while(fileNames.hasMoreElements()) { //hasMoreElements() 있으면 참 없으면 거짓
			file = (String)fileNames.nextElement(); //파일명이니까 String 객체라서 String으로 형변환
			
			if(multipartRequest.getFilesystemName(file) != null) {
				ofName += multipartRequest.getOriginalFileName(file) + "/";
				fsName += multipartRequest.getFilesystemName(file) + "/";
			}
		}
		ofName = ofName.substring(0, ofName.lastIndexOf("/"));
		fsName = fsName.substring(0, fsName.lastIndexOf("/"));
		
		System.out.println("원본 파일명집합 : "+ofName);
		System.out.println("저장된 서버 파일명집합 : "+fsName);
		System.out.println("fName : " + multipartRequest.getParameter("fName"));
		//여기까지가 파일을 서버에 저장하고 파일의 정보를 추출한것
		
		//업로드시킨 파일을 DB에 저장처리(1.변수저장처리 2.vo담기 3.DB저장하기)
		String mid = multipartRequest.getParameter("mid")==null ? "" : multipartRequest.getParameter("mid");
		String nickName = multipartRequest.getParameter("nickName")==null ? "" : multipartRequest.getParameter("nickName");
		int fSize = (multipartRequest.getParameter("fSize")==null || multipartRequest.getParameter("fSize") == "") ? 0 : Integer.parseInt(multipartRequest.getParameter("fSize"));
		String part  = multipartRequest.getParameter("part")==null ? "" : multipartRequest.getParameter("part");
		String title = multipartRequest.getParameter("title")==null ? "" : multipartRequest.getParameter("title");
		String content  = multipartRequest.getParameter("content")==null ? "" : multipartRequest.getParameter("content");
		String openSw = multipartRequest.getParameter("openSw")==null ? "" : multipartRequest.getParameter("openSw");
		String hostIp = multipartRequest.getParameter("hostIp")==null ? "" : multipartRequest.getParameter("hostIp");
		
		int pag = multipartRequest.getParameter("pag")==null ? 1 : Integer.parseInt(request.getParameter("pag"));
		int pageSize = multipartRequest.getParameter("pageSize")==null ? 5 : Integer.parseInt(request.getParameter("pageSize"));//확장성 고려차원에서 이렇게 해둠 원래는 그냥 5해도된다
		
		PdsVO vo = new PdsVO();
		vo.setMid(mid);
		vo.setNickName(nickName);
		vo.setfName(ofName);
		vo.setfSName(fsName);
		vo.setfSize(fSize);
		vo.setPart(part);
		vo.setTitle(title);
		vo.setContent(content);
		vo.setHostIp(hostIp);
		vo.setOpenSw(openSw);
		
		System.out.println("vo: "+vo);
		
		PdsDAO dao = new PdsDAO();
		int res = dao.setPdsInputOk(vo);
		
		if(res != 0) {
			request.setAttribute("message", "자료실에 자료가 업로드 되었습니다");
			request.setAttribute("url", "PdsList.pds?part="+part+"&pag="+pag+"&pageSize="+pageSize);
		}
		else {
			request.setAttribute("message", "업로드 실패");
			request.setAttribute("url", "PdsList.pds?part="+part+"&pag="+pag+"&pageSize="+pageSize);
		}
	}
}
