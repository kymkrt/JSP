<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	response.setCharacterEncoding("utf-8");
	String mid = request.getParameter("mid")==null ? "" : request.getParameter("mid");
	String pwd = request.getParameter("pwd")==null ? "" : request.getParameter("pwd");
	String member = request.getParameter("member")==null ? "" : request.getParameter("member");
%>
<!-- t01Res.jsp 목적지라서 뷰가 필요함-->
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>t01Res.jsp</title> <!-- 시리얼라이즈 직렬화? -->
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
  <script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.slim.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
<p><br /></p>
<div class="container">
  <h2>t01Res.jsp</h2>
  <hr />
  <div>
  	<div>아이디 : <%=mid%></div>
  	<div>비밀번호 : <%=pwd%></div>
  	<div>회원등급 : <%=member%></div>
  	<a href="t01_forword.jsp" class="btn btn-success">돌아가기</a>
  </div>
</div>
<p><br /></p>
</body>
</html>