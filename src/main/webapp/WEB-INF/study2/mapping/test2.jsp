<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>test2.jsp</title>
  <jsp:include page="/include/bs4.jsp" />
  <script type="text/javascript">
  	'use strict'
  	
  	if('${message}' != "") {
  		alert("${message}");
  		//이렇게 해서 새로고침 문제를 해결함
  		location.href = "${ctp}/study2/mapping/Test2";
  	}
  
  </script>
</head>
<body>
<jsp:include page="/include/header.jsp" />
<jsp:include page="/include/nav.jsp" />
<p><br /></p>
<div class="container">
<!--do 확장자는 내 맘대로 해도된다 정부에서는 do가 기본  -->
  <h2>URL 패턴(확장자 패턴) - .do</h2>
  <hr/>
  <div>전송 메세지1 : ${msg}</div>
  <div>전송 메세지2 : ${msg2}</div>
  <hr/>
  <div>
  	<%-- <a href="${ctp}/study2/mapping/list.do" class="btn btn-success mr-3">연습 list.do</a> --%>
  	<!--JSTL은 쿼리스트링이 기본방식  -->
  	<a href="list.do?msg=list" class="btn btn-success mr-3">list.do(전체)</a>
  	<a href="search.do?msg=search" class="btn btn-primary mr-3">search.do(개별)</a>
  	<a href="input.do?msg=input" class="btn btn-info mr-3">input.do(가입)</a>
  	<a href="update.do?msg=update" class="btn btn-secondary mr-3">update.do(수정)</a>
  	<a href="delete.do?msg=delete" class="btn btn-danger mr-3">delete.do(삭제)</a>
  </div>
</div>
<p><br /></p>
<jsp:include page="/include/footer.jsp" />
</body>
</html>