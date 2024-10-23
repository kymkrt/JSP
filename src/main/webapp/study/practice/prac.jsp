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
  	<input type="text" name="an" value="The Amazing Digital Circus" class="form-control" />
  	<input type="number" name="su" value="10" class="form-control">
 		<button type="submit" name="action" value="pomni" class="btn btn-success">폼니</button>
 		<button type="submit" name="action" value="kinger" class="btn btn-success">킹어</button>
 		<button type="submit" name="action" value="jax" class="btn btn-success">잭스</button>
  </form>
  an : ${an}
  <hr/>
  su : ${su}
  <hr/>
</div>
<p><br /></p>
</body>
</html>