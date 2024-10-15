<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- test05Res.jsp -->
<!-- http 통신이라 한번 보내고 받으면 세션이 끝남 그래서 서버에 남는 데이터가 없어서 
jsp?name="+name+"&age="+age+" 이렇게 아예 값을 넘겨줘야한다
 -->
<%
	request.setCharacterEncoding("utf-8");
	
	/* 받아오는거 */
	String name = request.getParameter("name");
	/* 웹에서 넘어가는건 전부 문자다 숫자로 바꿔줘야함 */
	int age = Integer.parseInt(request.getParameter("age"));
	
	out.println("성명 : " + name);
	out.println("<br/>나이 : " + age);
	/* 같은 경로라 다 생략가능 */
	out.println("<br/><a href='test05.jsp'>돌아가기</a>");
	
	/* out.println("<div><a href='test05Res.jsp?name="+name+"&age="+age+"'>값전송</a></div>"); */
%>