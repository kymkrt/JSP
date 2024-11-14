<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>photoView1.jsp</title>
  <jsp:include page="/include/bs4.jsp" />
  <script>
    'use strict';
    
    // 이미지 미리보기
    function imgCheck(input) {
    	//if(input.files) {
    	//if(input.files[0]) {
    	if(input.files && input.files[0]) {
    		let reader = new FileReader();
    		reader.onload = function(e) {
    			document.getElementById("demo").src = e.target.result;
    		}
    		reader.readAsDataURL(input.files[0]);
    	}
    	else document.getElementById("demo").src = "";
    }
    
    // 이미지 일반저장하기
    function fCheck1() {
    	let fName = document.getElementById("fName").value;
    	let maxSize = 1024 * 1024 * 10; 	// 저장파일 최대용량을 10MByte까지로 제한
    	let ext = fName.substring(fName.lastIndexOf(".")+1).toLowerCase();
    	
    	if(fName.trim() == "") {
    		alert("업로드할 파일을 선택하세요");
    		return false;
    	}
    	
    	let fileSize = document.getElementById("fName").files[0].size;
    	if(fileSize > maxSize) {
    		alert("업로드할 파일의 최대용량은 10MByte 입니다.");
    	}
    	else if(ext != 'jpg' && ext != 'gif' && ext != 'png' && ext != 'hwp' && ext != 'zip' && ext != 'ppt' && ext != 'pptx' && ext != 'xlsx' && ext != 'txt' && ext != 'doc') {
    		alert("업로드 가능한 파일은 'jpg/gif/png/hwp/zip/ppt/pptx/xlsx/txt/doc'만 가능합니다.")
    	}
    	else {
    		myform.submit();
    	}
    }
    
    // 이미지 ajax저장하기
    function fCheck2() {
    	let fName = document.getElementById("fName").value;
    	let maxSize = 1024 * 1024 * 10; 	// 저장파일 최대용량을 10MByte까지로 제한
    	let ext = fName.substring(fName.lastIndexOf(".")+1).toLowerCase();
    	
    	if(fName.trim() == "") {
    		alert("업로드할 파일을 선택하세요");
    		return false;
    	}
    	
    	let fileSize = document.getElementById("fName").files[0].size;
    	if(fileSize > maxSize) {
    		alert("업로드할 파일의 최대용량은 10MByte 입니다.");
    		return false;
    	}
    	else if(ext != 'jpg' && ext != 'gif' && ext != 'png' && ext != 'hwp' && ext != 'zip' && ext != 'ppt' && ext != 'pptx' && ext != 'xlsx' && ext != 'txt' && ext != 'doc') {
    		alert("업로드 가능한 파일은 'jpg/gif/png/hwp/zip/ppt/pptx/xlsx/txt/doc'만 가능합니다.")
    		return false;
    	}
    	
    	//이러면 form안에 있는걸 전부 객체로 보낼수 있다 히든도 다 보내짐
    	let query = new FormData(myform);//객체라 생성해야한다
    	
    	$.ajax({
    		type: "",
    		url: "PhotoViewAjax", //ajax처리할때는 URL 패턴을 써야한다 확장가패턴 쓰면 안됨
    		enctype: "multipart/form-data", //무조건써야한다 필수임
    		//false쓰면 기본타입으로 보낸다 ajax로 보낼때는 다 써야함
    		data: query,
    		//이 데이터를 처리해달라는 헤더의 명령을 적어야 한다 여러개라 보내야한
    		//다 예약어임
				processData: false,//편집하지 말고 바이너리로 보내라 false
				//타입에 대한 정보
				contentType: false,//편집하지 않고 윈도우에서 정해주는 형식으로 보낸다
				//여기까지는 다 필수 안쓰면 오류남
				cache: false, //캐시에 있는건 사용하지 않는다 필수는 아님
				timeout: 6000, //서버가 안끊기는 시간? 초단위 필수는 아님
    		success: function(res) {
					if(res != "0"){
							alert("파일업로드 성공");
							let str = "서버에 저장된 파일명 : "+res;
							$("#ajaxDemo").html(str);
					}
					else alert("파일 업로드 실패");
				},
				error: function () {
					alert("전송실패");
				}
    	});
    }
  </script>
</head>
<body>
<jsp:include page="/include/header.jsp" />
<jsp:include page="/include/nav.jsp" />
<p><br/></p>
<div class="container">
  <h2>업로드 사진 미리보기1</h2>
  <form name="myform" id="myform" method="post" action="PhotoView1Ok.st" enctype="multipart/form-data">
  	<div>
  	  <input type="file" name="fName" id="fName" onchange="imgCheck(this)" class="form-control-file border mb-2"/>
  	  <img id="demo" width="150px" />
  	</div>
  	<div>
  	  사진 설명
  	  <textarea rows="4" name="content" id="content" class="form-control mb-3" placeholder="사진설명을 입력하세요."></textarea>
  	  <div class="row">
  	    <div class="col"><input type="button" value="저장(일반)" onclick="fCheck1()" class="btn btn-success mb-2"></div>
  	    <div class="col"><input type="button" value="저장(AJax)" onclick="fCheck2()" class="btn btn-secondary mb-2"></div>
  	    <div class="col"><input type="button" value="다시선택" onclick="location.reload()" class="btn btn-warning mb-2"></div>
  	    <div class="col"><input type="button" value="다중파일저장" onclick="fCheck1()" class="btn btn-primary mb-2"></div>
  	    <div class="col"><input type="button" value="업로드사진보기" onclick="location.href='PhotoStorageList.st'" class="btn btn-info mb-2"></div>
  	  </div>
  	</div>
  </form>
  <hr/>
  <div id="ajaxDemo"></div>
</div>
<p><br/></p>
<jsp:include page="/include/footer.jsp" />
</body>
</html>