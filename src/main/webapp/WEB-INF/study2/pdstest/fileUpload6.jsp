<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>fileUpload6(멀티파일처리 JAVA).jsp</title>
  <jsp:include page="/include/bs4.jsp" />
  <script type="text/javascript">
  	'use strict'
  	
  	//프론트 에서 이런거 미리 다 체크해야한다 
  	function fCheck() {
			let fName = document.getElementById("file").value;
  		let fNames = "";
  		let ext = "";
  		let fileSize = 0; //누적은 0부터 시작
			let maxSize = 1024*1024*20; //합친 파일의 최대용량을 20MByte까지로 제한 
			
			//여기서 객체로들어오기 때문에 이전처럼 .으로 할수가 없고 객체를 꺼내서 확장자를 봐야한다
			//let ext = fName.substring(fName.lastIndexOf(".")+1).toLowerCase(); //.다음부터 찾아야 해서 +1
			
			if(fName.trim() == ""){
				alert("업로드할 파일을 선택하세요");
				return false;
			}
			
			//객체가 들어간 배열 비슷한것
			let fileLength = document.getElementById("file").files.length; //선택(업로드)한 파일의 갯수 files는 예약어임 배열이름이라 보면 된다
			let sw = 0;
			
			for(let i=0; i<fileLength; i++){
				fileSize += document.getElementById("file").files[i].size; //size도 예약어
				fName = document.getElementById("file").files[i].name; // name 예약어 
				ext = fName.substring(fName.lastIndexOf(".")+1).toLowerCase();
				// 안되는거 목록이면 확장자가 너무 많아서 안된다  되는거로 생각해야됨
				if(ext != 'jpg' && ext != 'png' && ext != 'gif' && ext != 'hwp' && ext != 'zip' && ext != 'ppt' && ext != 'pptx' && ext != 'xlsx' && ext != 'txt' && ext != 'doc'){
					alert("업로드 가능한 파일은 'jpg/png/gif/hwp/zip/ppt/pptx/xlsx/txt/doc'만 가능합니다");
					return false; //반복문에는 리턴 넣으면 안됨? 되는거 같은데
					sw = 1;
				}
				fNames += fName + "/";
			}
			if(sw != 0){
				return false;
			}
			else if(fileSize > maxSize){
				alert("업로드할 전체 파일의 최대 용량은 20MB 입니다")
			}
			else{
				document.getElementById("fNames").value = fNames;
				myform.submit();
			}
		}
  </script>
</head>
<body>
<jsp:include page="/include/header.jsp" />
<jsp:include page="/include/nav.jsp" />
<p><br /></p>
<div class="container">
  <h2>Java 파일 업로드 연습6(멀티파일처리)</h2>
  <hr/><!--확장자 패턴 안씀  -->
  <form name="myform" method="post" action="FileUpload6Ok" enctype="multipart/form-data">
  	파일명 : 
  	<!-- 여러개일때는 mutiple 추가 -->
  	<input type="file" name="fName" id="file" multiple class="form-control-file border mb-2" />
  	<input type="button" value="파일전송" onclick="fCheck()" class="btn btn-success form-control" />
  	<input type="hidden" name="nickName" value="${sNickName}" />
  	<input type="hidden" name="fNames" id="fNames" />
  </form>
  <hr/>
  <div class="row">
  	<div class="col"><a href="FileDownload.st" class="btn btn-primary form-control">다운로드 폴더로 이동</a></div>
  	<div class="col"><a href="FileUpload.st" class="btn btn-warning form-control">돌아가기</a></div>
  </div>
</div>
<p><br /></p>
<jsp:include page="/include/footer.jsp" />
</body>
</html>