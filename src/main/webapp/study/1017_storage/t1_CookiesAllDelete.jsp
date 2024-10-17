<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- t1_CookiesAllDelete.jsp 뷰가 아니라 필요 없음 -->
<%
Cookie[] cookies = request.getCookies();

	for(int i=0; i<cookies.length;i++) {
		cookies[i].setMaxAge(0); /* 0이나 음수면 지운다는뜻 */
		response.addCookie(cookies[i]);
	}

%>

<script>
	alert("모든 쿠키가 삭제 되었습니다");
	location.href = "t1_Cookies.jsp";
</script>