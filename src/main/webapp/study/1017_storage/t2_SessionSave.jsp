<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- t2_SessionSave.jsp 저장하는거라 필요없음? -->
<%
	request.setCharacterEncoding("utf-8"); //저장만하는거라 리스폰드는 안함
	
	/* 세션도 똑같이 setattribute */
	/* 받을때도 같다 getattri~ */
	session.setAttribute("sMid", request.getParameter("mid")); //원래는 null값도 처리
	session.setAttribute("sNickName", request.getParameter("nickName")); //원래는 null값도 처리
	session.setAttribute("sName", request.getParameter("name")); //원래는 null값도 처리
	
%>
<script>
	alert("세션이 생성/저장 되었습니다");
	location.href = "t2_Session.jsp";
</script>