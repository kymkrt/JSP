<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
  <form id="myform" method="post" action="<%=request.getContextPath() %>/HwOk3">
  	<div>아이디<input type="text" class="form-control mb-3"></div>
  	<div>비밀번호<input type="password" class="form-control mb-3"></div>
		<div class="row mb-3">
	  	<div class="col"><button type="submit" class="btn btn-success ">로그인</button></div>
	  	<div class="col"><button type="reset" class="btn btn-warning">새로</button></div>
	  </div>
	  <div style="text-align: center"><input type="checkbox" id="midSave" /><label for="midSave">아이디 저장</label></div>
  </form>
</div>
<p><br /></p>
</body>
</html>