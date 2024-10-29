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
  	
  	function fCheck() {
  		alert("asdfasdf");
  		let tel = myform.tel1.value+"-"+myform.tel2.value+"-"myform.tel3.value;
  		let email = myform.email1.value+"@"+myform.email2.value;
  		
  		/* 이렇게 해도됨
  		let tel2 = myform.tel2.value;
  		let tel3 = myform.tel3.value;
  		let email1 = myform.email1.value;
  		let email2 = myform.email2.value; */
  		
  		//유효성검사(정규식으로 처리) 프론트체크는 requierd부분에서 반드시 처리
  		
  		alert(tel +" : "+email);
  		
			//myform.action = "";
			
			myform.tel.value = tel;
			myform.email.value = email;
			myform.submit();
		}
  </script>
  <style type="text/css">
  	th {
			width: 150px; 
			background-color: #eee;	
			padding: 10px;
  	}
  	
  	#subject {
			background-color: #eee;	
  	}
  </style>
</head>
<body>
<jsp:include page="/include/header.jsp" />
<jsp:include page="/include/nav.jsp" />
<p><br /></p>
<div class="container">
  <form name="myform" id="myform" method="post" action="MemberJoinOk.mem" onsubmit="return fCheck()">
	<table class="table table-bordered">
		<tr id="subject">
			<td class="text-center" colspan="7"><b>회원가입</b></td>
		</tr>
	  	<tr>
		  	<th class="text-center"><label for="mid" class="form-label">아이디</label></th>
		  	<td colspan="7"><input type="text" name="mid" id="mid" placeholder="아이디를 입력하세요" class="form-control" autofocus required /></td>
	  	</tr>
	  	<tr>
		  	<th class="text-center"><label for="pwd" class="form-label">비밀번호</label></th>
		  	<td colspan="7"><input type="password" name="pwd" id="pwd" placeholder="비밀번호를 입력하세요" class="form-control" required /></td>
	  	</tr>
	  	<tr class="mb-2">
		  	<th class="text-center"><label for="name" class="form-label">성명</label></th>
		  	<td colspan="7"><input type="text" name="name" id="name" placeholder="성명을 입력하세요" class="form-control" required /></td>
	  	</tr>
	  	<tr class="mb-2">
		  	<th class="text-center"><label for="nickName" class="form-label">닉네임</label></th>
	  		<td colspan="7"><input type="text" name="nickName" id="nickName" placeholder="닉네임을 입력하세요" class="form-control" required /></td>
	  	</tr>
	  	<tr class="mb-2">
	  		<th class="text-center">성별</th>
			  	<td colspan="7" class="text-center">
				  	<input type="radio" name="gender" id="male" value="남자" checked /><label for="male" class="form-label mr-3">남자</label>
				  	<input type="radio" name="gender" id="female" value="여자" />	<label for="female" class="form-label">여자</label>
		  		</td>
	  	</tr>
	  	<tr class="mb-4">
	  		<th class="text-center"><label for="birthday" class="form-label">생일</label></th>
	  		<td colspan="7"><input type="date" name="birthday" id="birthday" class="form-control"></td>
	  	</tr>
	  	<tr class="mb-2">
	  		<th class="text-center"><label for="tel1" class="form-label">전화번호</label></th>
	  		<td>
	  		<select class="form-control" id="tel1" name="tel1">
				  <option>010</option>
				  <!--이런식으로 해도된다  -->
				  <option value="02">서울</option>
				  <option value="041">천안</option>
				  <option value="042">대전</option>
				  <option value="043">청주</option>
				  <option value="031">인천</option>
				</select>
				-<input type="text" class="" id="tel2" name="tel2" >
				-<input type="text" class="" id="tel3" name="tel3" />
			</td>
	  	</tr>
	  	<tr class="mb-2">
	  		<th class="text-center"><label for="address" class="form-label">주소</label></th>
	  		<td colspan="7"><input type="text" name="address" id="address" class="form-control" /></td>
	  	</tr>
	  	<tr class="mb-2">
		    <th class="text-center">이메일</th>
		    <td colspan="3"><input type="text" name="email1" id="email1" class="form-control" required /></td>
		    <td class="text-center"><b>@</b></td>
		    <td colspan="3">
		        <select class="form-control" id="email2" name="email2" required >
		            <option value="naver.com">naver.com</option>
		            <option value="daum.net">daum.net</option>
		            <option value="gmail.com">gmail.com</option>
		        </select>
		    </td>
		</tr>
	  	<tr class="mb-2">
		  	<th class="text-center"><label for="content" class="form-label">자기소개</label></th>
		  	<td colspan="7"><textarea cols="5" name="content" id="content" class="form-control"></textarea></td>
	  	</tr>
	  	<tr class="mb-2">
		  	<th class="text-center"><label for="photo" class="form-label">사진</label></th>
	  		<td colspan="7"><input type="file" name="photo" id="photo" class="form-control-file border" /></td>
	  	</tr>
	  	<tr class="mb-2">
		  	<th class="text-center"><label for="userInfor" class="form-label">정보공개</label></th>
		  	<td colspan="7" class="text-center">
		  		<input type="radio" name="userInfor" id="YES" value="공개" class="btn-check" /><label for="YES" class="form-label mr-3">공개</label>
		  		<input type="radio" name="userInfor" id="NO" value="비공개" class="btn-check" checked /><label for="NO" class="form-label">비공개</label>
		  	</td>
	  	</tr>
  	</table>
  	<button type="submit" class="form-control btn btn-success mb-2">제출</button>
  	<button type="reset" class="form-control btn btn-warning mb-2">다시입력</button>
  	<%-- <button type="button" onclick="location.href='${ctp}/'" class="form-control btn btn-info mb-2">돌아가기</button> --%>
  	<!--히스토리백은 사용에 주의해야한다  -->
  	<button type="button" onclick="history.back()" class="form-control btn btn-info mb-2">돌아가기</button>
  	<input type="hidden" name="tel" id="tel" />
  	<input type="hidden" name="email" id="email" />
  </form>
  <div name="demo" id="demo">
  </div>
</div>
<p><br /></p>
<jsp:include page="/include/footer.jsp" />
</body>
</html>