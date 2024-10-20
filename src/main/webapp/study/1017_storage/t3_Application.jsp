<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>t3_Application.jsp</title>
  <jsp:include page="/include/bs4.jsp" />
</head>
<body>
<p><br /></p>
<div class="container">
  <h2>어플리케이션 연습 메인 메뉴</h2>
  <hr />
  <form name="myform" method="post" action="t3_ApplicationSave.jsp">
  	<div>아이디를 입력하시요
  	<!-- 어플리케이션값을 바로 꺼내려면 밸류에 어플리케이션을 넣어야 한다 없으면 아무것도 안나옴  -->
			<input type="text" name="mid" value="${aMid}" class="form-control mb-2" autofocus required/> 
		</div>
		<div>닉네임을 입력하시요
	  	<input type="text" name="nickName" id="nickName" value="${aNickName}" class="form-control mb-2" required>
  	</div>
		<div>성명을 입력하시요
	  	<input type="text" name="name" id="name" value="${aName}" class="form-control mb-2" required>
  	</div>
  	<div class="row">
  		<div class="col"><button type="submit" class="form-control btn-info mb-2">어플리케이션저장</button></div>
	  	<div class="col"><a href="t3_ApplicationCheck.jsp" class="btn btn-primary">어플리케이션확인</a></div>
	  	<!-- 어플리케이션 전체 삭제는 명령자체가 없다 -->
	  	<div class="col"><a href="t3_ApplicationDelete.jsp" class="btn btn-danger">부분어플리케이션삭제</a></div>
  	</div>
  </form>
</div>
<p><br /></p>
</body>
</html>