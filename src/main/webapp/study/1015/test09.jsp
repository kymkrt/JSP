<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 아래 부분은 서버의 WAS가 해석 -->
<%
	String flag = request.getParameter("flag");
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>test09.jsp</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
  <script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.slim.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript">
/* 7Ok 말고는 전부 프론트다 */
	'use strict'
	
	if('<%=flag%>'== 'no') {
		alert("회원정보를 확인하세요");
	}
	
	function fCheck() {
		let mid = myform.mid.value;
		let pwd = myform.pwd.value;
		
		if(mid.trim() == "") {
			alert("아이디를 입력하시오");
			myform.mid.focus();
		}
		else if(pwd.trim() == "") {
			alert("비밀번호를 입력하시오");
			myform.pwd.focus();
		}
		else{
			myform.submit();
		}
	}
	
</script>
</head>
<body>
<p><br /></p>
<div class="container">
  <!-- <form name="myform" method="post" action="/javaGroup/1015/Test09Ok2"> 절대 경로 --> <!-- 파일명이 아니라 경로 -->
  <form name="myform" method="post" action="<%=request.getContextPath() %>/1015/Test09Ok2"> <!-- 컨트롤러가 경로를 정해줬기 때문에 이 경로가 필수 콘텍스트명은 지워도 되지만 다른건 안됨-->
  	<div>아이디를 입력하시요
			<input type="text" name="mid" id="mid" value="hkd1234" class="form-control mb-2" autofocus /> 
		</div>
		<div>비밀번호를 입력하시요
	  	<input type="password" name="pwd" id="pwd" value="1234" class="form-control mb-2" />
  	</div>
  	<div>
  		<button type="button" onclick="fCheck()" class="form-control btn btn-info mb-2">전송</button>
  	</div>
  </form>
</div>
<p><br /></p>
</body>
</html>