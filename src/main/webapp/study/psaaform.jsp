<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>.jsp</title>
  <jsp:include page="/include/bs4.jsp" />
  <script type="text/javascript">
  	'use strict'
  	
  	function fCheck(flag) {
  		let tel1 = myform.tel1.value;
  		let tel2 = myform.tel2.value;
  		let tel3 = myform.tel3.value;
  		let email1 = myform.email1.value;
  		let email2 = myform.email2.value;
  		
  		alert(tel1+tel2+tel3+email1+email2);
  		
			if(flag == 1){
				myform.tel.value= tel1+tel2+tel3;
				myform.email.value= email1+'@'+email2;
				myform.action = "";
				myform.submit();
			}
			else if(flag == 2){
				location.href="${ctp}/Main";
			}
		}
  </script>
</head>
<body>
<jsp:include page="/include/header.jsp" />
<jsp:include page="/include/nav.jsp" />
<p><br /></p>
<div class="container">
  <form name="myform" id="myform" method="post" action="">
	<table class="table table-borderd">
  	<tr>
	  	<th><label for="mid" class="form-label">아이디</label></th>
	  	<td><input type="text" name="mid" id="mid" value="" class="form-control" autofocus required /></td>
  	</tr>
  	<tr>
	  	<th><label for="pwd" class="form-label">비밀번호</label></th>
	  	<td><input type="password" name="pwd" id="pwd" value="" class="form-control" required /></td>
  	</tr>
  	<tr class="mb-2">
	  	<th><label for="nickName" class="form-label">이름</label></th>
  		<td><input type="text" name="nickName" id="nickName" value="" class="form-control" required /></td>
  	</tr>
  	<tr class="mb-2">
	  	<th><label for="name" class="form-label">닉네임</label></th>
	  	<td><input type="text" name="name" id="name" value="" class="form-control" required /></td>
  	</tr>
  	<tr class="mb-2">
  		<th colspan="2">성별</th>
	  	<td><input type="radio" name="gender" id="male" value="남자" checked /></td>
	  	<td><input type="radio" name="gender" id="female" value="여자" /></td>
  	</tr>
  	<tr>
  		<td><label for="male" class="form-label">남자</label></td>
  		<td><label for="female" class="form-label">여자</label></td>
  	</tr>
  	<tr class="mb-4">
  		<th><label for="birthday" class="form-label">생일</label></th>
  		<input type="date" name="birthday" id="birthday" class="form-control">
  	</tr>
  	<tr class="mb-2">
  		<th><label for="tel1" class="form-label">전화번호</label></th>
  		<select class="form-select" id="tel1" name="tel1">
			  <option selected>지역번호</option>
			  <option value="043">043</option>
			  <option value="02">02</option>
			  <option value="045">045</option>
			</select>
  		<th><label for="tel2" class="form-label">-</label></th>
  		<select class="form-select" id="tel2" name="tel2" >
			  <option selected>국번</option>
			  <option value="123">123</option>
			  <option value="456">456</option>
			  <option value="789">789</option>
			</select>
  		<th><label for="tel3" class="form-label">-</label></th>
  		<select class="form-select" id="tel3" name="tel3" >
			  <option selected>전화번호</option>
			  <option value="321">321</option>
			  <option value="654">654</option>
			  <option value="987">987</option>
			</select>
  	</tr>
  	<tr class="mb-2">
  		<th><label for="address" class="form-label">주소</label></th>
  		<input type="text" name="address" id="address" class="form-control" />
  	</tr>
  	<tr class="input-group mb-2">
  		<span class="input-group-text" id="basic-addon1">이메일</span>
  		<input type="text" name="email1" id="email1" class="form-control" required />
		  <span class="input-group-text">@</span>
		  <select class="form-select" id="email2" name="email2" required >
			  <option value="naver.com">naver.com</option>
			  <option value="daum.net">daum.net</option>
			  <option value="gmail.com">gmail.com</option>
			</select>
  	</tr>
  	<tr class="mb-2">
	  	<th><label for="content" class="form-label">자기소개</label></th>
	  	<textarea cols="5" name="content" id="content" class="form-control"></textarea>
  	</tr>
  	<tr class="mb-2">
	  	<th><label for="photo" class="form-label">사진</label></th>
  		<input type="file" name="photo" id="photo" class="form-control-file border" />
  	</tr>
  	<tr class="mb-2">
	  	<input type="radio" name="userInfo" id="YES" value="공개" class="btn-check" /><label for="YES" class="form-label btn btn-info">공개</label>
	  	<input type="radio" name="userInfo" id="NO" value="비공개" class="btn-check" checked /><label for="NO" class="form-label btn btn-info">비공개</label>
  	</tr>
  	</table>
  	<button type="button" onclick="fCheck(1)" class="form-control btn btn-success mb-2">제출</button>
  	<button type="reset" class="form-control btn btn-warning mb-2">다시입력</button>
  	<button type="button" onclick="fCheck(2)" class="form-control btn btn-info mb-2">돌아가기</button>
  	<input type="hidden" name="tel" id="tel" value="" />
  	<input type="hidden" name="email" id="email" value="" />
  </form>
  <div name="demo" id="demo">
  
  </div>
</div>
<p><br /></p>
<jsp:include page="/include/footer.jsp" />
</body>
</html>