<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	response.setCharacterEncoding("utf-8");
	String name = request.getParameter("name")==null ? "" : request.getParameter("name");
	String age = request.getParameter("age")==null ? "" : request.getParameter("age");
	String gender = request.getParameter("gender")==null ? "" : request.getParameter("gender");
	String hobby = request.getParameter("hobby")==null ? "" : request.getParameter("hobby");
	String job = request.getParameter("job")==null ? "" : request.getParameter("job");
	String mountain = request.getParameter("mountain")==null ? "" : request.getParameter("mountain");
	String content = request.getParameter("content")==null ? "" : request.getParameter("content");
	String fName = request.getParameter("fName")==null ? "" : request.getParameter("fName");
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>hwRes.jsp</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
  <script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.slim.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
  <script src="<%=request.getContextPath()%>/js/member.js"></script>
</head>
<body>
<p><br /></p>
	<div class="container">
  	<div>성명 : <%=name%></div>
  	<div>나이 : <%=age%></div>
  	<div>성 : <%=gender%></div>
  	<div>취미 : <%=hobby%></div>
  	<div>직업 : <%=job%></div>
  	<div>다녀온산 : <%=mountain%></div>
  	<div>자기소개 : <%=content%></div>
  	<div>파일이름 : <%=fName%></div>
  	
 		<div><a href="javascript:logoutCheck('<%=request.getContextPath()%>/study/practice/hw1.jsp')" class="btn btn-success form-control">돌아가기</a></div>
	</div>
<p><br /></p>
</body>
</html>