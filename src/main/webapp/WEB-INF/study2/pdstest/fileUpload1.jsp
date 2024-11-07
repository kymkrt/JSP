<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>fileUpload1.jsp</title>
  <jsp:include page="/include/bs4.jsp" />
  <script type="text/javascript">
  	'use strict'
  	
  	//프론트 에서 이런거 미리 다 체크해야한다 
  	function fCheck() {
			let fName = document.getElementById("file").value;
			let maxSize = 1024*1024*10; //저장파일의 최대용량을 10MByte까지로 제한 
			let ext = fName.substring(fName.lastIndexOf(".")+1).toLowerCase(); //.다음부터 찾아야 해서 +1
			
			if(fName.trim() == ""){
				alert("업로드할 파일을 선택하세요");
				return false;
			}
			//여러개가 올수 있기 때문에 배열로 봐야함  그래서 files, size 둘다 예약어임
			let fileSize = document.getElementById("file").files[0].size;
			if(fileSize > maxSize){
				alert("업로드할 파일의 최대용량은 10MB 입니다")
			}
			// 안되는거 목록이면 확장자가 너무 많아서 안된다  되는거로 생각해야됨
			else if(ext != 'jpg' && ext != 'png' && ext != 'gif' && ext != 'hwp' && ext != 'zip' && ext != 'ppt' && ext != 'pptx' && ext != 'xlsx' && ext != 'txt' && ext != 'doc'){
				alert("업로드 가능한 파일은 'jpg/png/gif/hwp/zip/ppt/pptx/xlsx/txt/doc'만 가능합니다");
			}
			else{
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
  <h2>파일 업로드 연습(싱글)</h2>
  <hr/>
  <form name="myform" method="post" action="FileUpload1Ok.st" enctype="multipart/form-data">
  	파일명 : 
  	<input type="file" name="fName" id="file" class="form-control-file border mb-2" />
  	<input type="button" value="파일전송" onclick="fCheck()" class="btn btn-success form-control" />
  	<input type="hidden" name="nickName" value="${sNickName}" />
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