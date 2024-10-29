<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>memberNickNameCheck.jsp</title>
  <jsp:include page="/include/bs4.jsp" />
  <script type="text/javascript">
  	'use strict'
  	
  	//제이쿼리 없이 그냥 쓰면 얘가 아래 돔을 못읽어서 작동이 안됨 이렇게 제이 쿼리를 쓰거나 자바 스크립트를 돔 아래에 써서 미리 불러오도록 해야한다
  	//제이 쿼리 이렇게 펑션을 쓰면 여기 작동 전에 자동으로 돔을 읽어온다
  	$(function(){
  		//alert("아이디 ${vo.mid} 임시 ${vo.tempMid}")
	  	let nickName = "${vo.tempNickName}"; /*문자로 받기 때문에 "" 사용  */
	  	let str = "";
	  	if(nickName == ""){
	  		str = "${vo.nickName}는 사용가능합니다";
	  	}
	  	else{
	  		str = nickName+". ${vo.tempNickName}는 이미 사용중입니다";
	  		str += '<form name="childForm" method="post" action="MemberNickNameCheck.mem">';
	  		str += '닉네임';
	  		str += '<input type="text" name="nickName" class="form-control" autofocus required />';
	  		str += '<input type="submit" value="닉네임검색" class="btn btn-secondary" />';
	  		str += '</form>';
	  	}
	  	
	  	demo.innerHTML = str;
  	});
  	
  	function winClose(){
  		//alert("mid : ${	vo.mid}")
  		opener.window.myform.nickName.value = '${vo.nickName}'; //나를 연곳 opener
  		opener.window.myform.pwd.focus();
  		window.close()
  	}
  </script>
</head>
<body>
<p><br /></p>
<div class="container">
  <h3>아이디 검색 결과</h3>
  <hr/>
  <div id="demo"></div>
  <hr/>
  <p class="text-center"><input type="button" value="창닫기" onclick="winClose()"></p>
</div>
<p><br /></p>
</body>
</html>