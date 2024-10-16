<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>t02_Member.jsp</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
  <script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.slim.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
  <!-- 스타일 태그는 link를 걸지만 자바스크립트는 src다 -->
  <script src="<%=request.getContextPath()%>/js/member.js"></script>
</head>
<body>
<!-- 상대경로는 자제 하는게 좋음 -->
<%-- <%@ include file="../../include/testHeader.jsp"%> --%>
<!-- jsp액션태그  위에건 중간에 <> 시리즈를 못써서 액션태그를 쓴다 -->
<%-- <jsp:include page="/<%=request.getContextPath()%>/include/testHeader.jsp"/> --%> <!-- 끊을때는 / -->
<jsp:include page="/include/testHeader.jsp"/> <!--jsp액션태그에선 /가 있으면 컨텍스트의 경로로 보기때문에 생략해줘야한다  -->
<p><br /></p>
<div class="container">
  <h2>이곳은 회원 전용방 입니다</h2>
  <hr />
  <div><img src="<%=request.getContextPath()%>/images/12.jpg" width="500px" /></div>
  <hr />
  <!-- 이렇게 자바 스크립트로 보낼수도 있다 -->
  <div><a href="javascript:logoutCheck('<%=request.getContextPath()%>/study/1016/t02_Dispatcher.jsp')" class="btn btn-success form-control">로그아웃</a></div>
  <hr />
</div>
<p><br /></p>
<jsp:include page="/include/testFooter.jsp"/>
</body>
</html>