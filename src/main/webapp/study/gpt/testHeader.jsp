<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%
    String userId = (String) session.getAttribute("userId");
    String dept = (String) session.getAttribute("dept");
    if (userId == null || dept == null) {
        response.sendRedirect("ex01Login.jsp");
    }
%>
<div class="header">
    <h1>환영합니다, <%= userId %>님 (부서: <%= dept %>)</h1>
    <a href="LogoutOk">로그아웃</a>
</div>
