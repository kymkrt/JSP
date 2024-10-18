<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- t3_ApplicationSave.jsp 저장이라 필요없음 -->

<%
	request.setCharacterEncoding("utf-8"); //저장만하는거라 리스폰드는 안함
	
	/* 어플리케이션도 똑같이 setattribute */
	/* 받을때도 같다 getattri~ */
	/* 헷갈리니까 앞에 a 회사에서는 다를수 있음 */
	application.setAttribute("aMid", request.getParameter("mid")); //원래는 null값도 처리
	application.setAttribute("aNickName", request.getParameter("nickName")); //원래는 null값도 처리
	application.setAttribute("aName", request.getParameter("name")); //원래는 null값도 처리
	
%>
<script>
	alert("어플리케이션이 생성/저장 되었습니다");
	location.href = "t3_Application.jsp";
</script>