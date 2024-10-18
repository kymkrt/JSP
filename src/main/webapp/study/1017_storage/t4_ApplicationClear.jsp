<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>t4_ApplicationClear.jsp</title>
  <jsp:include page="/include/bs4.jsp" />
  <script>
  	'use strict'
  	
  	function applicationDelete() {
			let applicationFlag = document.getElementById("applicationFlag").value;
			if(applicationFlag == "") {
				alert("삭제할 어플리케이션을 선택하세요");
				/* return false를 쓰면 else가 필요없다 */
				return false;
			}
			//get 방식일때는 location 써야함
			location.href = "t4_StorageTest.jsp?applicationFlag="+applicationFlag; //get방식이라 ?뒤에 연결. 자바스크립트 변수라 뒤에+로 붙여준다 안에 쓰면 그냥 문자열
		}
  
  </script>
</head>
<body>
<p><br /></p>
<div class="container">
  <h2>어플리케이션 부분 삭제</h2>
  <hr />
  <!-- 폼태그가 없어서 액션으로 못보냄 즉 겟 방식만 가능 -->
	<select name="applicationFlag" id="applicationFlag" onchange="applicationDelete()">
		<option value="">선택</option>
		<option value="aMid">아이디</option>
		<option value="aNickName">닉네임</option>
		<option value="aName">성명</option>
	</select>  
  <hr />
  <p><a href="t4_StorageTest.jsp">돌아가기</a></p>
</div>
<p><br /></p>
</body>
</html>