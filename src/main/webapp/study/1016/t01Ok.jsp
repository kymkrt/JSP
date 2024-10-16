<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	//String mid = request.getParameter("mid")==null ? "" : request.getParameter("mid");
	//String pwd = request.getParameter("pwd")==null ? "" : request.getParameter("pwd");
%>
<!--t01Ok.jsp  중간단계만 처리하는 파일 -->

<!-- 
<script> 
 이 명령어는 멈췄다가 가는것 이러면 값이 전달이 안된다 
	location.href = "t01Res.jsp";
</script> 
-->

<%-- <jsp:forward page="t01Res.jsp" /> --%> <!-- /는 종료태그다 -->

<!-- 값을 유지하고 싶으면 직렬화(시리얼라이즈) 즉 포워드를 사용해야한다 -->
<jsp:forward page="t01Res.jsp">
	<jsp:param name="member" value="memeberOk"/>
</jsp:forward>