<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>t2_SessionDelete.jsp</title>
  <jsp:include page="/include/bs4.jsp" />
  <script>
  	'use strict'
  	
  	function sessionDelete() {
			//let sessionFlag = document.getElementById("sessionFlag").value;
			let sessionFlag = $("#sessionFlag").val(); //제이쿼리
			
			if(sessionFlag == "") {
				alert("삭제할 세션을 선택하세요");
				/* 리턴 팔스를 쓰면 엘스가 필요없다 */
				//return false;
			}
			else {
				//get 방식일때는 location 써야함
				location.href = "t2_SessionDeleteOk.jsp?sessionFlag="+sessionFlag; //get방식이라 ?뒤에 연결. 자바스크립트 변수라 뒤에+로 붙여준다 안에 쓰면 그냥 문자열
			}
		}
  
  </script>
</head>
<body>
<p><br /></p>
<div class="container">
  <h2>세션 부분 삭제</h2>
  <hr />
  <!-- 폼태그가 없어서 액션으로 못보냄 즉 겟 방식만 가능 -->
	<select name="sessionFlag" id="sessionFlag" onchange="sessionDelete()">
		<option value="">선택</option>
		<option value="sMid">아이디</option>
		<option value="sNickName">닉네임</option>
		<option value="sName">성명</option>
	
	</select>  
  <hr />
  <p><a href="t2_Session.jsp">돌아가기</a></p>
</div>
<p><br /></p>
</body>
</html>