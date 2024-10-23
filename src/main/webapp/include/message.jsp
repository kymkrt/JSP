<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>message.jsp</title>
  <script type="text/javascript">
  	'use strict';	
  	
  	if("${message}" != "NO") alert("${message}"); 
  	// /가 여러개 나와도 1개로 인식한다 이 경우 URL창에도 /가 많이 들어가 있음
  	location.href = "${ctp}//////${url}" //이동할 주소
  	// 원래는 이렇게 함 기본적으로 URL 앞에 /가 들어가기 때문
  	//location.href = "${ctp}${url}" //이동할 주소
  </script>
</head>
<body>

</body>
</html>