<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!--  
	우선순위가 주석보다 높기 때문에 이렇게 띄어써야한다
	지시자(Directive) 	- < % @ 	 % > 	: 현 페이지의 환경설정에 관계된 사항처리
	스크립틀릿(Scriptlet)	- < %   	 % > 	: jsp코드안에서 java 코드를 사용할때 처리 
	선언문(Declaration) - < % ! 	 % > : jsp코드안에서 java 코드나 메소드 등의 선언문을 선언할때 처리
	표현식(Expression) 	- < % =  	 % > : jsp코드안에서 값(변수값 가능)을 출력할때 기술
-->
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>test01.jsp</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
  <script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.slim.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
<p><br /></p>
<div class="container">
  <h2>JSP 학습</h2>
  <%
  	System.out.println("1.이곳은 test1.jsp 입니다");
  %>
  <div>앞의 문장을 표현식으로 표시하면</div>
  <div><%="2.이곳은 test1.jsp 입니다" %>></div>
  <%
  	int i = 100;
  /*이거랑 똑같이 맞추려고 out 사용  */
  	out.println("i = "+ i);
  %>
  <div>선언문을 이용한 j변수 선언</div>
  <%!
  /* 여기는 선언문이라 실행 부분이 들어오면 안됨 */
  	int j = 200;
  %>
  <%
  	out.println("j = "+ j);
  %>
  <!-- 윗부분 생략가능 아래 처럼 표현이 가능하다 -->
  <div><%="j = " + j %></div>
</div>
<p><br /></p>
</body>
</html>