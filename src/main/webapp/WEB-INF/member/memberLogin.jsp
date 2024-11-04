<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<c:set var="hostIp" value="${pageContext.request.remoteAddr}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>memberLogin.jsp</title>
  <jsp:include page="/include/bs4.jsp" />
</head>
<body>
<jsp:include page="/include/header.jsp" />
<jsp:include page="/include/nav.jsp" />
<p><br /></p>
<div class="container">
	<h2 class="text-center mb-4">회원 로그인</h2>
	<!-- 서브밋으로 넘겼지만 원래는 유효성 체크 해야됨 -->
  <form name="myform" method="post" action="MemberLoginOk.mem">
  	<div>아이디를 입력하시요
			<input type="text" name="mid" value="admin" class="form-control mb-2" autofocus required/> 
		</div>
		<div>비빌번호를 입력하시요
	  	<input type="password" name="pwd" id="pwd" value="1234" class="form-control mb-2" required>
  	</div>
  	<input type="hidden" name="hostIp" value="${hostIp}" />
  	<div class="row text-center">
  		<div class="col"><button type="submit" class="btn btn-success mb-2">로그인</button></div>
  		<div class="col"><button type="reset" class="btn btn-warning mb-2">다시입력</button></div>
  		<!-- 메세지로 가는게 아니라 MemberJoin.mem 앞에/를 빼줌 -->
  		<div class="col"><button type="button" onclick="location.href='MemberJoin.mem'" class="btn btn-info">회원가입</button></div>
  		<div class="col"><input type="checkbox" name="idSave" id="idSave" value="idSave" />아이디저장</div>
  	</div>
  </form>
</div>
<p><br /></p>
<jsp:include page="/include/footer.jsp" />
</body>
</html>