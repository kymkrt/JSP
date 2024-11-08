<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>fileUpload.jsp</title>
  <jsp:include page="/include/bs4.jsp" />
</head>
<body>
<jsp:include page="/include/header.jsp" />
<jsp:include page="/include/nav.jsp" />
<p><br /></p>
<div class="container">
  <h2>파일 업로드 연습(싱글/멀티)</h2>
  <hr/>
  <h4>COS라이브러리를 이용한 파일 업로드</h4>
  
  <pre>
	  http://www.servlets.com/
		https://mvnrepository.com/artifact/servlets.com/cos/05Nov2002
  </pre>
  
  <hr/>
  <div class="row text-center">
  	<div class="col"><a href="FileUpload1.st" class="btn btn-success">업로드 연습1</a></div>
  	<div class="col"><a href="FileUpload2.st" class="btn btn-primary">업로드 연습2</a></div>
  	<div class="col"><a href="FileUpload3.st" class="btn btn-secondary">업로드 연습3</a></div>
  	<div class="col"><a href="FileUpload4.st" class="btn btn-info">업로드 연습4</a></div>
  </div>
  <hr/>
  <h4>자바 서블릿의 Part객체를 이용한 파일 업로드(클래스 임포트만 걸면되서 라이브러리 추가 필요 없음)</h4>
  <div class="row text-center">
  	<div class="col"><a href="FileUpload5.st" class="btn btn-success">업로드 연습5</a></div>
  	<div class="col"><a href="FileUpload6.st" class="btn btn-primary">업로드 연습6</a></div>
  </div>
  <hr/>
  <div class="row">
  	<div class="col"><a href="FileDownload.st" class="btn btn-primary form-control">다운로드 폴더로 이동</a></div>
  	<div class="col"><a href="MemberMain.mem" class="btn btn-warning form-control">돌아가기</a></div>
  </div>
</div>
<p><br /></p>
<jsp:include page="/include/footer.jsp" />
</body>
</html>