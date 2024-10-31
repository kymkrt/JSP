<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>adminContent.jsp</title>
  <jsp:include page="/include/bs4.jsp" />
</head>
<body>
<p><br /></p>
<!--대시 보드 여기에 모든 정보가 나올수 있도록 해야한다  -->
<div class="container">
  <h3>관리자 메인화면</h3>
  <hr/>
  <!--  
  방명록, 게시판, 자료실에 최근 올라온 글 표시 (개수. 링크로 갈수도 있게)
  신규회원 처리
  탈퇴신청회원 처리
  -->
  <p>방명록 새글 : 건</p>
  <p>게시판 새글 : 건</p>
  <p>신고글(최근 일주일) 새글 : 건</p>
  <p>신규 등록 회원(준회원) : 건</p>
  <p>탈퇴 신청 회원 : 건</p>
</div>
<p><br /></p>
</body>
</html>