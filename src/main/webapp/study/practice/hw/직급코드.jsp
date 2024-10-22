<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <!--prefix 접두어  -->
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>직급코드.jsp</title>
<jsp:include page="/include/bs4.jsp" />
</head>
<body>
<div class="container">
	<form action="">
	<div>예제2 : URL에 직급코드(code)를 QueryString방식으로 입력후 직급명을 출력하시오</div>
	<div>직급코드(kCode) : B(부장), K(과장), D(대리), S(사원) / 직급명(kName)</div>
	<div>직급코드가 앞의 코드 외의 값이 들어오면 '파견근로자'라고 출력한다</div>
	~~~~~<hr/>
	<div>
	<c:set var="code" value="${param.kCode }"></c:set>
	<c:choose>
		<c:when test="${code == 'B'}"><c:set var="kName" value="부장"></c:set></c:when>
		<c:when test="${code == 'K'}"><c:set var="kName" value="과장"></c:set></c:when>
		<c:when test="${code == 'D'}"><c:set var="kName" value="대리"></c:set></c:when>
		<c:when test="${code == 'S'}"><c:set var="kName" value="사원"></c:set></c:when>
		<c:otherwise><c:set var="kName" value="파견 근로자"></c:set></c:otherwise>
	</c:choose>	
	<div>직급코드 : ${code} / 직급명 : ${kName}</div>
	</div>
	</form>
</div>
</body>
</html>