<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>memberIdCheck.jsp</title>
  <jsp:include page="/include/bs4.jsp" />
  <script type="text/javascript">
  	'use strict'
  	
  	//제이쿼리 없이 그냥 쓰면 얘가 아래 돔을 못읽어서 작동이 안됨 이렇게 제이 쿼리를 쓰거나 자바 스크립트를 돔 아래에 써서 미리 불러오도록 해야한다
  	//제이 쿼리 이렇게 펑션을 쓰면 여기 작동 전에 자동으로 돔을 읽어온다
  	$(function(){
  		//alert("아이디 ${vo.mid} 임시 ${vo.tempMid}")
	  	let mid = "${vo.tempMid}"; /*문자로 받기 때문에 "" 사용  */
	  	let str = "";
	  	if(mid == ""){
	  		str = "${vo.mid}는 사용가능합니다";
	  	}
	  	else{
	  		str = mid+". ${vo.tempMid}는 이미 사용중입니다";
	  		str += '<form name="childForm" method="post" action="MemberIdCheck.mem">';
	  		str += '아이디';
	  		str += '<input type="text" name="mid" class="form-control" autofocus required />';
	  		str += '<input type="submit" value="아이디검색" class="btn btn-secondary" />';
	  		str += '</form>';
	  	}
	  	
	  	demo.innerHTML = str;
  	});
  	
  	function winClose(){
  		//alert("mid : ${	vo.mid}")
  		opener.window.myform.mid.value = '${vo.mid}'; //나를 연곳 opener
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