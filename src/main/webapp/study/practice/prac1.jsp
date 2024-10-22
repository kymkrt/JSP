<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${contText.request.getContextPath }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>prac2.jsp</title>
<jsp:include page="/include/bs4.jsp" />
</head>
<body>
<div class="container">
	<h2>send 버전</h2>
	<a href="${ctp}/study/practice/prac.jsp" class="form-control btn btn-success">돌아가기</a>
</div>	
</body>
</html>