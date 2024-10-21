<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>jstl3_vo.jsp</title>
  <jsp:include page="/include/bs4.jsp" />
</head>
<body>
<p><br /></p>
<div class="container">
    <h2>회원자료 출력</h2>
    <!-- Get 방식이라 location.href추가 필요 -->
  	<p><button type="button" onclick="location.href='${ctp}/1018/Jstl3Ok1'" class="btn btn-success">vo(개별자료)자료출력</button></p>
  	<p><button type="button" onclick="location.href='${ctp}/1018/Jstl3Ok2'" class="btn btn-success">vos(전체자료)자료출력</button></p>
</div>
<p><br /></p>
</body>
</html>