<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>photoView1.jsp</title>
  <jsp:include page="/include/bs4.jsp" />
  <script type="text/javascript">
  	'use strict';
  	
  	//이미지 미리보기
  	function imgCheck(input) {
			//if(input.files[0]){ //여기서 files는 예약어다 한개면 file이지만 여려개 올수 있어서 files 배열로 한다
			if(input.files && input.files[0]){	
				//외부에서 들어온 파일을 가져오는? 껍데기 클래스?
				let reader=new FileReader();
				reader.onload = function(e) { //e 감지되는 이벤트
					document.getElementById("demo").src = e.target.result;
				}
				reader.readAsDataURL(input.files[0]);
			}
			else{
				document.getElementById("demo").src = "";
			}
		}
  	
  	//이미지 일반 저장하기 
  	function fCheck1() {
			let fName = document.getElementById("fName").value;
			let maxSize = 1024*1024*10; //저장파일의 최대용량을 10MByte까지로 제한 
			let ext = fName.substring(fName.lastIndexOf(".")+1).toLowerCase(); //.다음부터 찾아야 해서 +1
			
			if(fName.trim() == ""){
				alert("업로드할 파일을 선택하세요");
				return false;
			}
			//여러개가 올수 있기 때문에 배열로 봐야함  그래서 files, size 둘다 예약어임
			let fileSize = document.getElementById("fName").files[0].size;
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
  <h2>업로드 사진 미리보기</h2>
  <form name="myform" id="myform" method="post" action="PhotoView1Ok.st" enctype="mutipart/form-data"">
  	<div>
  		<input type="file" name="fName" id="fName" onchange="imgCheck(this)" class="form-control-file border mb-2" />
  		<img id="demo" width="150px" />
  	</div>
  	<div>
  		사진 설명
  		<textarea rows="4" name="content" id="content" class="form-control mb-3" placeholder="사진설명을 입력하세요">
  			지금은 DB에 안담음 나중에 해봐야한다 
  		</textarea>
  		<div class="col"><input type="button" value="저장(일반)" onclick="fCheck1()" class="btn btn-success mb-2" /></div>
  		<div class="col"><input type="button" value="저장(AJAX)" onclick="fCheck2()" class="btn btn-secondary mb-2" /></div>
  		<div class="col"><input type="button" value="다시선택" onclick="location.reload()" class="btn btn-warning mb-2" /></div>
  		<div class="col"><input type="button" value="다중파일저장" onclick="fCheck1()" class="btn btn-primary mb-2" /></div>
  		<div class="col"><input type="button" value="업로드 사진 보기" onclick="location.href='PhotoStorageList.st'" class="btn btn-info mb-2" /></div>
  	</div>
  </form>
</div>
<p><br /></p>
<jsp:include page="/include/footer.jsp" />
</body>
</html>