<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>guestInput.jsp</title>
  <jsp:include page="/include/bs4.jsp" />
</head>
<body>
<jsp:include page="/include/header.jsp" />
<jsp:include page="/include/nav.jsp" />
<p><br /></p>
<div class="container">
  <h2>방 명 록 글 쓰 기</h2>
  <!--메소드 안주면 get  -->
   <form name="myform" method="post" action="GuestInputOk.gu" class="was-validated">
    <div class="form-group">
      <label for="name">성명</label>
      <input type="text" class="form-control" id="name" value="${sNickName}" placeholder="성명을 입력하세요 name" name="name" autofocus required />
      <div class="valid-feedback">Ok성공</div>
      <div class="invalid-feedback">성명을 입력하세요 name</div>
    </div>
    <div class="form-group">
      <label for="email">E-mail</label>
      <input type="text" class="form-control" id="email" placeholder="Enter email 이메일" name="email" />
    </div>
    <div class="form-group">
      <label for="homePage">홈페이지 homePage</label>
      <input type="text" class="form-control" id="homePage" value="http://" placeholder="Enter homePage 홈페이지" name="homePage" />
    </div>
    <div class="form-group">
      <label for="content">방문소감</label>
      <!--rows는 줘야함 cols는 form-control이 자동으로 준다  -->
      <textarea rows="5" class="form-control" id="content" placeholder="Enter content 방문소감" name="content" required></textarea>
      <div class="valid-feedback">Ok성공</div>
      <div class="invalid-feedback">방문소감을 입력하세요 content</div>
    </div>
    <div class="form-group text-center">
    	<button type="submit" class="btn btn-primary mr-3">방명록 등록</button>
    	<button type="reset" class="btn btn-warning mr-3">다시입력</button>
    	<button type="button" onclick="location.href='GuestList.gu'" class="btn btn-info">돌아가기</button>
    </div>
    <!--히든은 /폼 위에  -->
    <input type="hidden" name="hostIp" value="${pageContext.request.remoteAddr}" />
  </form>
</div>
<p><br /></p>
<jsp:include page="/include/footer.jsp" />
</body>
</html>