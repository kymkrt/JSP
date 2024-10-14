<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>test2.jsp</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
  <script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.slim.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
<p><br /></p>
<!-- 서버를 통해서 WAS로 가서 해석한다 -->
<div class="container">
  <h2>Post 방식을 통한 서블릿 호출</h2>
  <!-- 액션 : 서버호출 -->
  <!--서브밋이라 액션에있는 서버를 호출하는것-->
  <form method="post" action="/javaGroup/Test3">
  	<input type="submit" value="전송" class="btn btn-success" />
  	<hr />
  	<!-- Get 방식의 대표적인 예시 a href http부분도 꼭 써주자-->
  	<div><a href="http://localhost:9090/javaGroup/T03" class="btn btn-primary mb-2">Test3 호출(Get)</a></div>
  	<div><a href="http://localhost:9090/javaGroup/T04" class="btn btn-secondary">Test4 호출(Get)</a></div>
  </form>
</div>
<p><br /></p>
</body>
</html>