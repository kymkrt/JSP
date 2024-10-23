<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>doInput.jsp</title>
  <jsp:include page="/include/bs4.jsp" />
</head>
<body>
<jsp:include page="/include/header.jsp" />
<jsp:include page="/include/nav.jsp" />
<p><br /></p>
<div class="container">
  <h2>doInput.jsp입니다</h2>
  <hr/>
  	<img src="${ctp}/images/11.jpg" />
  <hr/>
  <div class="row text-center">
	 <div class="col"><a href="inputOk.do" class="btn btn-info">회원가입</a></div><!--확장자패턴을 쓰면 앞부분은 필요없음  -->
	 <div class="col"><a href="${ctp}/study2/mapping/Test2" class="btn btn-warning">돌아가기</a></div>
  </div>
</div>
<p><br /></p>
<jsp:include page="/include/footer.jsp" />
</body>
</html>