<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>memberMain.jsp</title>
  <jsp:include page="/include/bs4.jsp" />
</head>
<body>
<jsp:include page="/include/header.jsp" />
<jsp:include page="/include/nav.jsp" />
<p><br /></p>
<div class="container">
  <h2>회 원 전 용 방</h2>
  <hr/>
  <div>현재 <font color="blue"><b>${sNickName}(<font color="red">${strLevel}</font>)</b></font>님 로그인 중입니다.</div>
  <hr/>
  <div>총 방문 횟수 : <font color="blue"><b>${mVo.visitCnt }</b></font></div>
  <div>오늘 방문 횟수 : <font color="blue"><b>${mVo.todayCnt }</b></font></div>
  <div>최종 방문 일(기존) : <font color="blue"><b>${mVo.lastDate }</b></font></div><!--이렇게 찍으면 지금 시간 나옴 로그아웃 되야 시간이 되도록 바꿨기 때문  -->
  <div>최종 방문 일(JSTL) : <font color="blue"><b>${fn:substring(sLastDate,0,19)}</b></font></div><!--substring을 써야 하기 때문에 위에 펑션 JSTL사용  -->
  <div>총 포인트 : <font color="blue"><b>${mVo.point }</b></font></div>
  <hr/>
  <!--과제 방명록이 올린 이름이 같거나 닉네임이 같거나 id가 같으면 같은 사람이 쓴걸로 간주  -->
  <div>방명록에 작성한 글수 : <font color="blue">총 <b><%-- ${} --%></b>건</font></div>
  <hr/>
  <div>회원사진 : <img src="${ctp}/images/member/${mVo.photo}" width="300px" /></div>
</div>
<p><br /></p>
<jsp:include page="/include/footer.jsp" />
</body>
</html>