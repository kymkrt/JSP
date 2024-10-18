<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- t2_SessionDeleteOk.jsp 지워주기만 하는거라 필요없음 -->
<%
	String sessionFlag = request.getParameter("sessionFlag"); //유효성검사 생략
	/* 세션 지우는 명령어 */
	session.removeAttribute(sessionFlag);
%>
<script>
/*표현식으로 쓰기 싫으면 변수로 받아야한다  */
	alert("<%=sessionFlag%>세션이 삭제 되었습니다");
	location.href = "t2_Session.jsp";
</script>