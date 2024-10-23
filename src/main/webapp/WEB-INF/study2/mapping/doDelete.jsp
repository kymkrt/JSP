<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>doDelete.jsp</title>
  <jsp:include page="/include/bs4.jsp" />
</head>
<body>
<jsp:include page="/include/header.jsp" />
<jsp:include page="/include/nav.jsp" />
<p><br /></p>
<div class="container">
  <h2>doDelete.jsp입니다</h2>
   <hr/>
  	<img src="${ctp}/images/2.jpg" />
  <hr/>
  <div class="row text-center">
	 <div class="col"><a href="deleteOk.do" class="btn btn-warning">정보삭제 탈퇴</a></div>
	 <div class="col"><a href="${ctp}/study2/mapping/Test2" class="btn btn-info">돌아가기</a></div>
  </div>
</div>
<p><br /></p>
<jsp:include page="/include/footer.jsp" />
</body>
</html>