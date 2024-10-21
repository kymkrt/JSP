<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>ex1_main.jsp</title>
  <jsp:include page="/include/bs4.jsp" />
</head>
<body>
<p><br /></p>
<div class="container">
  <h1>이곳은 회원(${sMid}) 메인 방입니다</h1>
  <hr />
  <a href="${ctp}/study/exam/ex1_Login.jsp" class="btn btn-outline-primary" >돌아가기</a>
</div>
<p><br /></p>
</body>
</html>