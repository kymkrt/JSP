<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>photoView2.jsp</title>
  <jsp:include page="/include/bs4.jsp" />
  <script>
    'use strict';
    
    //이미지 여러장 미리 보기
    $(function() {//제이쿼리에선 이벤트가 발생할때 늘 on 사용 앞이 이벤트 뒤가 콜백함수
    	//onchange onclick ondrag 등
			$("#fName").on("change", multiImageCheck); //콜백함수로 이름만 씀 ()안쓴다
		});
    
    function multiImageCheck(e) {
			let files = e.target.files;
			//배열객체 속성이 프로토타입
			let filesArr = Array.prototype.slice.call(files);
			
			filesArr.forEach(function(f) { //e랑 f랑 같은거 이름만 다르게 한거다
				if(!f.type.match("image.*")){
					alert("업로드할 파일은 이미지 파일만 가능합니다");
					return false;
				}
			});
			//멀티파일 이미지 미리보기
			let i = e.target.files.length; //자바스크립트는 무조건 length
			for(let image of e.target.files){//향상된 포문이라 뒤에 객체
				let img = document.createElement("img");//만드는거라 get아니고 create
				let reader = new FileReader(); //얘가 컨트롤?
				reader.onload = function(e) {
					img.setAttribute("src", e.target.result); //속성을 정해주는거니까 set
					img.setAttribute("width", 200); //px주면 안됨 숫자주면 알아서 픽셀로 본다
				}
				reader.readAsDataURL(e.target.files[--i]);
				document.querySelector(".imgDemo").appendChild(img);
			}
		}
    
    
    // 이미지 일반저장하기
    function fCheck1() {
    	let fName = document.getElementById("fName").value;
    	let maxSize = 1024 * 1024 * 30; 	// 저장파일 최대용량을 10MByte까지로 제한
    	let ext = fName.substring(fName.lastIndexOf(".")+1).toLowerCase();
    	
    	if(fName.trim() == "") {
    		alert("업로드할 파일을 선택하세요");
    		return false;
    	}
    	
    	let fileSize = document.getElementById("fName").files[0].size;
    	if(fileSize > maxSize) {
    		alert("업로드할 파일의 최대용량은 30MByte 입니다.");
    	}
    	else if(ext != 'jpg' && ext != 'gif' && ext != 'png' && ext != 'hwp' && ext != 'zip' && ext != 'ppt' && ext != 'pptx' && ext != 'xlsx' && ext != 'txt' && ext != 'doc') {
    		alert("업로드 가능한 파일은 'jpg/gif/png/hwp/zip/ppt/pptx/xlsx/txt/doc'만 가능합니다.")
    	}
    	else {
    		myform.submit();
    	}
    }
    
    // 이미지 aJax저장하기
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
    	
    	let query = new FormData(myform);
    	
    	$.ajax({
    		type : "post",
    		url  : "PhotoViewAjax",
    		enctype: "multipart/form-data",
    		data : query,
    		processData: false,
    		contentType: false,
    		/*
    		cache: false,
    		timeout: 6000,
    		*/
    		success:function(res) {
    			if(res != "0") {
    				alert("파일 업로드 성공!");
    				let str = "서버에 저장된 파일명 : " + res;
    				$("#ajaxDemo").html(str);
    			}
    			else alert("파일 업로드 실패~");
    		},
    		error : function() {
    			alert("전송실패!");
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
  <h2>업로드 사진 미리보기2</h2>
  <form name="myform" id="myform" method="post" action="PhotoView2Ok.st" enctype="multipart/form-data">
  	<div>
  	  <input type="file" name="fName" id="fName" multiple class="form-control-file border mb-2"/>
  	</div>
  	<div class="imgDemo">
  		
  	</div>
  	<div>
  	  사진 설명
  	  <textarea rows="4" name="content" id="content" class="form-control mb-3" placeholder="사진설명을 입력하세요."></textarea>
  	  <div class="row">
  	    <div class="col"><input type="button" value="저장(일반)" onclick="fCheck1()" class="btn btn-success mb-2"></div>
  	    <div class="col"><input type="button" value="저장(AJax)" onclick="fCheck2()" class="btn btn-secondary mb-2"></div>
  	    <div class="col"><input type="button" value="다시선택" onclick="location.reload()" class="btn btn-warning mb-2"></div>
  	    <div class="col"><input type="button" value="싱글파일저장" onclick="location.href='PhotoView.st'" class="btn btn-primary mb-2"></div>
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