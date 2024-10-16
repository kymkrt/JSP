<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>hw1.jsp</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
  <script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.slim.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
  <script src="<%=request.getContextPath()%>/js/member.js"></script>
</head>
<body>
<p><br /></p>
<!--원래는 아이디도 다 써서 유효성 검사도 정규식으로 해야함 -->
<div class="container">
	<h2>폼태그를 이용한 값의 전달 연습</h2>
	<hr/>
  <form name="myform" method="post" action="<%=request.getContextPath()%>/hw1"> 
  	<div class="mb-3">성명
  		<input type="text" name="name" id="name" value="홍길동" class="form-control mb-3" placeholder="성명을 입력하세요" autofocus required /> <!-- 플레이스 홀더 같은것도 활용 -->
  	</div>
  	<div class="mb-3">나이
  		<input type="number" name="age" id="age" value="23" class="form-control mb-3" />
  	</div>
  	<div class="mb-3">성별 &nbsp;&nbsp;
  		<input type="radio" name="gender" id="male" value="남자" checked />남자&nbsp;&nbsp;
  		<input type="radio" name="gender" id="female" value="여자" />여자
  	</div>
  	<div class="mb-3">취미 &nbsp;&nbsp;
  		<input type="checkbox" name="hobby" id="hobby1" value="등산" />등산&nbsp;
  		<input type="checkbox" name="hobby" id="hobby2" value="낚시" />낚시&nbsp;
  		<input type="checkbox" name="hobby" id="hobby3" value="수영" />수영&nbsp;
  		<input type="checkbox" name="hobby" id="hobby4" value="배드민턴" />배드민턴&nbsp;
  		<input type="checkbox" name="hobby" id="hobby5" value="바이크" />바이크&nbsp;
  		<input type="checkbox" name="hobby" id="hobby6" value="바둑" />바둑&nbsp;
  	</div>
  	<div class="mb-3">직업
  		<select name="job" id="job">
  			<option value="">선택</option> <!-- 없으면 메세지 뜨게 -->
  			<option id="j1">회사원</option>
  			<option id="j2">공무원</option>
  			<option id="j3">학생</option>
  			<option id="j4">군인</option>
  			<option id="j5">자영업</option>
  			<option id="j6">기타</option>
  		</select>
  	</div>
  	<div class="mb-3">가본산
  		<select name="mountain" id="mountain" size="5" multiple> <!--리스트상자 여러개 쓰려면 멀티플 -->
  			<option id="m1">한라산</option>
  			<option id="m2">태백산</option>
  			<option id="m3">소백산</option>
  			<option id="m4">우암산</option>
  			<option id="m5">속리산</option>
  			<option id="m6">대둔산</option>
  			<option id="m7">북한산</option>
  		</select>
  	</div>
  	<div class="mb-3">자기소개
  		<textarea rows="6" name="content" id="content" class="form-control"></textarea>
  	</div>
  	<div class="mb-3">첨부파일
			<input type="file" name="fName" id="fName" class="form-control-file border" />  	
  	</div>
  	<dlv>
  		<!-- <input type="button" onclick="fCheck()" value="전송" class="form-control btn btn-success" /> -->
  		<input type="submit" value="전송" class="form-control btn btn-success" />
  	</dlv>
  </form>
</div>
<p><br /></p>
</body>
</html>