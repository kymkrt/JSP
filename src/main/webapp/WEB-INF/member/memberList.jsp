<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>memberList.jsp</title>
  <jsp:include page="/include/bs4.jsp" />
</head>
<body>
<jsp:include page="/include/header.jsp" />
<jsp:include page="/include/nav.jsp" />
<p><br /></p>
<div class="container">
  <h2 class="text-center">회 원 리 스 트</h2>
  
  <c:forEach var="vo" items="${vos}" varStatus="st">
  	<span class="mr-2">
	  	<span class="card w-auto h-auto" style="width: 18rem;">
	  	<h5 class="card-header">${st.count} / ${vo.name}</h5>
	  	 	<span class="card-body">
		  		<h5 class="card-title">닉네임 : ${vo.nickName}</h5>
		  		<p class="card-text">공개여부 : ${vo.userInfo}</p>
		  		<c:if test="${vo.userInfo == '공개'}">
			  		<p class="card-text">성별 : ${vo.gender}</p>
			  		<p class="card-text">생일 : ${vo.birthday}</p>
			  		<p class="card-text">전화번호 : ${vo.tel}</p>
			  		<p class="card-text">주소 : ${vo.address}</p>
			  		<p class="card-text">이메일 : ${vo.email}</p>
			  		<p class="card-text">자기소개 : ${vo.content}</p>
			  		<c:if test="${sMid == vo.mid}"><p class="card-text">마지막 접속일 : ${fn:substring(sLastDate,0,16)}</p></c:if>
			  		<!--배타적 조건  -->
			  		<c:if test="${sMid != vo.mid}"><p class="card-text">마지막 접속일 : ${fn:substring(vo.lastDate,0,16)}</p></c:if>
		  		</c:if>
		  		<c:if test="${vo.userInfo == '비공개'}">
		  			<p class="card-text">비공개</p>
		  		</c:if>
	  		</span>
	  	</span>
  	</span>
  </c:forEach>
</div>
<p><br /></p>
<jsp:include page="/include/footer.jsp" />
</body>
</html>