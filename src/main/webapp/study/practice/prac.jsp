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
</head>
<body>
<p><br /></p>
<div class="container">
  <form name="myform" method="post" action="/javaGroup/Prac">
  	<h2>연습하기</h2>
  	<input type="submit" value="연습" class="btn btn-info" />
  </form>
  <hr/>
  <div>
		str 길이 : ${fn:length(str)}  	
  </div>
</div>
<p><br /></p>
</body>
</html>