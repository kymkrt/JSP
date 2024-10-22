<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	Cookie[] cookies = request.getCookies();
	String check = cookies[0].getValue();
	System.out.println(check);
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>ex01Login.jsp</title>
  <jsp:include page="/include/bs4.jsp" />
</head>
<body>
<p><br /></p>
<div class="container">
	<h2>로그인</h2>
	<hr/>
  <form id="myform" name="myform" method="post" action="<%=request.getContextPath() %>/practice/HwOk3">
  	<div>아이디<input type="text" name="mid" value="${check}" class="form-control mb-3"></div>
  	<div>비밀번호<input type="password" name="pwd" class="form-control mb-3"></div>
  	<label for="saveId"><input type="checkbox" name="saveId" id="saveId" value="saveId" />아이디저장</label>
  	<div><button type="submit" class="form-control btn btn-success mb-3">로그인</button></div>
  	<div><button type="reset" class="form-control btn btn-warning">초기화</button></div>
  </form>
</div>
<p><br /></p>
</body>
</html>