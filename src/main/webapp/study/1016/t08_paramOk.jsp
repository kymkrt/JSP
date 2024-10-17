<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- t08_paramOk.jsp 뷰가 아니라 다 날려도된다 -->

<% 
	String mid = request.getParameter("mid")==null ? "" : request.getParameter("mid");
	String pwd = request.getParameter("pwd")==null ? "" : request.getParameter("pwd");
	
	pageContext.setAttribute("mid", mid);
	pageContext.setAttribute("pwd", pwd);
%>

<h2>회원 정보</h2>
<p>아이디 : ${mid}</p>
<p>비밀번호 : ${pwd}</p>
<hr />
<%if(mid.substring(mid.length()-1).equals("I")) { %>
	<!-- 위에서 값을 안담았으면 표현식으로 꺼내야한다 jsp주석은 꺽쇠 퍼센트다 그래서 이걸 아래에 넣으면 주석이 아니라 글로봄 -->
	<jsp:forward page="t08_resI.jsp">
		<jsp:param name="mid" value="${mid}"/>
		<jsp:param name="pwd" value="${pwd}"/>
	</jsp:forward>
<%} else if(mid.substring(mid.length()-1).equals("C")) { %>
		<!-- 위에서 값을 안담았으면 표현식으로 꺼내야한다 -->
		<jsp:forward page="t08_resC.jsp">
		<jsp:param name="mid" value="${mid}"/>
		<jsp:param name="pwd" value="${pwd}"/>
	</jsp:forward>
<%} else if(mid.substring(mid.length()-1).equals("J")) { %>
		<!-- 위에서 값을 안담았으면 표현식으로 꺼내야한다 -->
		<jsp:forward page="t08_resJ.jsp">
		<jsp:param name="mid" value="${mid}"/>
		<jsp:param name="pwd" value="${pwd}"/>
	</jsp:forward>
<%} else if(mid.substring(mid.length()-1).equals("S")) { %>
		<!-- 위에서 값을 안담았으면 표현식으로 꺼내야한다 -->
		<jsp:forward page="t08_resS.jsp">
		<jsp:param name="mid" value="${mid}"/>
		<jsp:param name="pwd" value="${pwd}"/>
	</jsp:forward>
<%} %>
