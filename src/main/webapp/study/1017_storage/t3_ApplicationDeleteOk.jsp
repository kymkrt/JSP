<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- t3_ApplicationDeleteOk.jsp -->
<%
	String applicationFlag = request.getParameter("applicationFlag"); //유효성검사 생략
	/* 애플리케이션 지우는 명령어 */
	application.removeAttribute(applicationFlag);
%>
<script>
/*표현식으로 쓰기 싫으면 변수로 받아야한다  */
	alert("<%=applicationFlag%>애플리케이션이 삭제 되었습니다");
	location.href = "t3_Application.jsp";
</script>