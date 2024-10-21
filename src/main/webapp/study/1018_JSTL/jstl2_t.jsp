<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>jstl2.jsp</title>
  <jsp:include page="/include/bs4.jsp" />
</head>
<body>
<p><br/></p>
<div class="container">
  <h2>JSTL 반복문(core라이브러리 사용 : forEach문)</h2>
  <pre>
    사용법1 : < c : forEach var="변수" begin="초기값" end="최종값 step="증감값" varStatus="매개변수"> ~~ < / c : forEach >
            setp 이 1인경우는 생략가능. varStatus="변수" 는 매개값을 필요로할경우에만 표기하면 됨.
    사용법2 : < c : forEach var="변수" items=" $ {객체명}" varStatus="매개변수"> ~~ < / c : forEach >
    사용법3 : < c : forTokens var="변수" items=" $ {객체명}" delims="구분기호"> ~~ < / c : forTokens >
  </pre>
  <hr/>
  <p>사용법1</p>
  <c:forEach var="i" begin="1" end="10" step="1">
  	${i} /
  </c:forEach>
  <br/><br/>
  <p>사용법2</p>
<%
  String[] cards = {"국민","BC","LG","현대","삼성","농협","신한"};
  pageContext.setAttribute("cards", cards);
%>
  <c:forEach var="card" items="${cards}">
  	${card} /
  </c:forEach>
  <br/><br/>
  <p>사용법3</p>
  <c:set var="hobbys" value="등산/수영/낚시/바둑/독서/승마/바이크" />
  취미 : ${hobbys}<br/>
  '/'를 구분기호로 분리해서 ','로 출력 : 
  <c:forTokens var="hobby" items="${hobbys}" delims="/">
    ${hobby} ,
  </c:forTokens>
  <br/><br/>
  <p>사용법4(상태변수 사용예)</p>
  <div>count / index / current / first / last</div>
  <c:forEach var="card" items="${cards}" varStatus="st">
  	${st.count}(${st.index}) : ${card} 카드 , 조건? a.${st.current} , b.${st.first} , c.${st.last}<br/>
  </c:forEach>
	<hr/>
	<h5>1.구구단 5단을 출력하세요</h5>
	* 5단 *<br/>
	
	
	<br/><br/>
	
	
</div>
<p><br/></p>
</body>
</html>