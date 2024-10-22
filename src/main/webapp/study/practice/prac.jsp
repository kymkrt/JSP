<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>title</title>
  <jsp:include page="/include/bs4.jsp" />
  <script type="text/javascript">
  	'use strict'
  	
  </script>
</head>
<body>
<p><br /></p>
<div class="container">
  <form name="myform" method="post" action="${ctp}/Prac">
 	<button type="submit" class="btn btn-success">여기</button>
 	
  </form>
  <hr/>
</div>
<p><br /></p>
</body>
</html>