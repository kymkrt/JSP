<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	session.invalidate(); //세션끄는 명령어 내사이트에 들어온 세션을 전부 지우겠다
%>
<script>
	alert("모든 세션이 삭제 되었습니다");
	location.href = "t4_StorageTest.jsp";
</script>