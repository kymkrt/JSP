<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	/*EL로 쓰려면 변수를 받아야한다  */
	String mid = (String)application.getAttribute("aMid"); //객체라서 스트링으로 형변화
	String nickName = (String)application.getAttribute("aNickName");
	String name = (String)application.getAttribute("aName");
	
	/* 프론트에서 쓰기 위한것? 브라우저의 페이지단위에서 살아있는것 */
	pageContext.setAttribute("mid", mid);
	pageContext.setAttribute("nickName", nickName);
	pageContext.setAttribute("name", name);

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>t3_ApplicationCheck.jsp</title>
  <jsp:include page="/include/bs4.jsp" />
</head>
<body>
<p><br /></p>
<div class="container">
  <h2>저장된 어플리케이션 확인</h2>
  <!--EL로 쓰려면 변수로 받아야한다  -->
  <p>아이디 : ${mid}</p>
  <p>닉네임 : ${nickName}</p>
  <p>성명 : ${name}</p>
   <hr />
   <p>세션 아이디 : <%=session.getId() %></p>
   <hr />
  <p><a href="t3_Application.jsp" class="btn btn-info">돌아가기</a></p>
</div>
<p><br /></p>
</body>
</html>