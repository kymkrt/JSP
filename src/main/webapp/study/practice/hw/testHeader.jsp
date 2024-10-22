<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	session.getAttribute("sMid");
	session.getAttribute("sCode");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>testHeader.jsp</title>
<jsp:include page="/include/bs4.jsp" />
</head>
<body>
<div class="container">
	<h2>회사 페이지</h2>
	<div>접속자 : ${sMid}</div>
	<div>접속부서 : ${sCode}</div>
	<a href="<%=request.getContextPath()%>/study/practice/board.jsp">게시판</a>
	<a href="">자료실</a>
	<a href="<%=request.getContextPath()%>/study/practice/ex01LogOut.jsp">로그아웃</a>
</div>
</body>
</html>