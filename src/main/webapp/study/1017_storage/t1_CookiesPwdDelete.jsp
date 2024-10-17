<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- t1_CookiesPwdDelete.jsp 지우기만 하는거라 뷰 필요 없다 -->

<%
	Cookie[] cookies = request.getCookies();
	
	for(int i=0; i<cookies.length;i++) {
		if(cookies[i].getName().equals("cPwd")) {
		cookies[i].setMaxAge(0); /* 0이나 음수면 지운다는뜻 */
		response.addCookie(cookies[i]);
		}
}
%>

<script>
	alert("비밀번호 쿠키가 삭제 되었습니다");
	location.href = "t1_Cookies.jsp";
</script>