<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>t01_forword.jsp</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
  <script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.slim.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
<p><br /></p>
<div class="container">
  <h2>Forword를 통한 값의 전달/이동</h2> <!-- 중간에 안멈춤 ok로 가게 해뒀는데 res로 간다(주소는ok) 그 안멈추는 중간에 처리하게 둔다 보통 보안 작업 -->
  <hr />
  <form name="myform" method="post" action="t01Ok.jsp"> <!-- 컨트롤러가 경로를 정해줬기 때문에 이 경로가 필수 콘텍스트명은 지워도 되지만 다른건 안됨-->
		<div>아이디를 입력하시요
			<input type="text" name="mid" id="mid" value="hkd1234" class="form-control mb-2" autofocus required /> 
		</div>
		<div>비밀번호를 입력하시요
	  	<input type="password" name="pwd" id="pwd" value="1234" class="form-control mb-2" required />
		</div>
		<div>
			<button type="submit" class="form-control btn btn-info mb-2">로그인</button>
			<button type="reset" class="form-control btn btn-warning mb-2">다시입력</button>
		</div>
  </form>
</div>
<p><br /></p>
</body>
</html>