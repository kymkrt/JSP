<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%
	String str = "The Amazing Digital Circus";
	pageContext.setAttribute("str", str);
%>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>title</title>
  <jsp:include page="/include/bs4.jsp" />
  <script type="text/javascript">
  	'use strict'
  	
  	function fCheck(way) {
		if(way==1){
			myform.hidden.value = "1";
			myform.submit();
		}
		else {
			myform.hidden.value = "2";
			myform.submit();
		}
	}
  
  </script>
</head>
<body>
<p><br /></p>
<div class="container">
  <form name="myform" method="post" action="/javaGroup/Prac">
  	<h2>연습하기</h2>
  	<div>글자 입력<input type="text" name="text" class="form-control" /></div>
  	<div>체크박스<input type="checkbox" name="checkBox" class="form-control" /></div>
  	<div><input type="hidden" name="hidden" class="form-control" /></div>
  	<div>위치조정<input type="range" name="range" class="form-control" /></div>
  	<input type="button" value="send" onclick="fCheck(1)" class="btn btn-info" />
  	<input type="button" value="dispatch" onclick="fCheck(2)" class="btn btn-info" />
  </form>
  <hr/>
  <div>
		str 길이 : ${fn:length(str)}  	
  </div>
</div>
<p><br /></p>
</body>
</html>