<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>
	console.log("로그아웃 JSP");
    alert("로그아웃 합니다");
<%
	session.invalidate();
%>	
    location.href="<%=request.getContextPath() %>/study/practice/ex01Login.jsp";
</script>