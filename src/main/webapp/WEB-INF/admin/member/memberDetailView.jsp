<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>memberDetailView.jsp</title>
  <jsp:include page="/include/bs4.jsp" />
</head>
<body>
<jsp:include page="/include/header.jsp" />
<jsp:include page="/include/nav.jsp" />
<p><br /></p>
<div class="container">
  <h2>회원 정보 상세 보기</h2>
  <br/>
  <div>고유번호 : ${vo.idx}</div>
  <div>아이디 : ${vo.mid}</div>
  <div>닉네임 : ${vo.nickName}</div>
  <div>성명 : ${vo.name}</div>
  <div>성별 : ${vo.gender}</div>
  <div>생일 : ${vo.birthday}</div>
  <div>전화번호 : ${vo.tel}</div>
  <div>주소 : ${vo.address}</div>
  <div>이메일 : ${vo.email}</div>
  <div>자기소개 : ${vo.content}</div>
  <div>정보공개 : ${vo.userInfo}</div>
  <div>탈퇴신청여부 : ${vo.userDel}</div>
  <div>레벨 : ${vo.level}</div>
  <div>포인트 : ${vo.point}</div>
  <div>총방문횟수 : ${vo.visitCnt}</div>
  <div>오늘방문횟수 : ${vo.todayCnt}</div>
  <div>가입일 : ${vo.startDate}</div>
  <div>최종방문일 : ${vo.lastDate}</div>
  <div>사진 : <img src="${ctp}/images/member/${vo.photo}" width="200px" /></div>
  <hr/>
  <div><button onclick="history.back()">돌아가기</button></div>
</div>
<p><br /></p>
<jsp:include page="/include/footer.jsp" />
</body>
</html>