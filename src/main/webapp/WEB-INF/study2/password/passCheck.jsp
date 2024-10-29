<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>passCheck.jsp</title>
  <jsp:include page="/include/bs4.jsp" />
  <script type="text/javascript">
  	'use strict'
		
  	//이미 로그인 되서 세션에 넘어가 있기 때문에 넘길 필요 없음 해도 되긴 함
  	function fCheck(flag) {
  		let pwd = myform.pwd.value;
  		if(pwd.trim() == "") {
  			alert("비밀번호를 입력하세요");
  			myform.pwd.focus();
  		}
  		else {
  			myform.flag.value = flag;
  			myform.action = "PassCheckOk.st";
  			myform.submit();
  		}
	}
  </script>
</head>
<body>
<jsp:include page="/include/header.jsp" />
<jsp:include page="/include/nav.jsp" />
<p><br /></p>
<div class="container">
  <h2>비밀번호 암호화 연습</h2>
  <pre>
  	salt는 암호학에서는 데이터, 비밀번호 등을 통과시킬때 통과암호를 해시처리하는 단방향 함수의 추가 입력 랜덤 데이터이다
  	솔트는 레인보우 테이블(rainbow table : 해시 테이블)과 같은 미리 계산된 테이블을 사용하는 공격을 방어한다
  	
  	<h3>SHA(Secure Hash Algorithm)</h3>
  	SHA는 단방향식 암호화 기법으로 복호화가 되지 않는다. SHA-2라고도 부르며
  	해시 함수가 출력되는 암축된 문장을 다이제스트(Digest)라고 하는데 
  	SHA-2가 생성해주는 다이제스트의 출력길이는 256, 512Bit가 있다
  	따라서 256Bit의 출력길이를 갖는 SHA-2 암호화 기법을 SHA-256 암호화 방식이라고 한다
  	 
  </pre>
  <p>비밀번호를 10자 이내로 입력하세요</p>
  <form name="myform" method="post">
  	<table class="table table-bordered text-center">
  		<tr>
  			<td colspan="2"><font size="5">로 그 인</font></td>
  		</tr>
  		<tr>
  			<th>아이디</th>
  			<td><input type="text" name="mid" value="${sMid}" class="form-control" autofocus required /></td>
  		</tr>
  		<tr>
  			<th>비밀번호</th>
  			<td><input type="text" name="pwd" value="1234" class="form-control" required /></td>
  		</tr>
  		<tr>
				<td colspan="2">
																		<!--form에 액션이 없으니 여기서 숫자로 따로 넣겠다는뜻-->
					<input type="button" value="숫자비밀번호" onclick="fCheck(1)" class="btn btn-success mr-2" />
					<input type="button" value="문자비밀번호" onclick="fCheck(2)" class="btn btn-secondary mr-2" />
					<input type="button" value="조합비밀번호" onclick="fCheck(3)" class="btn btn-primary mr-2" />
					<input type="button" value="SHA256" onclick="fCheck(4)" class="btn btn-info" />
				</td>  		
  		</tr>
  	</table>
  	<input type="hidden" name="flag" id="flag" value="" /> <!--${vo.idx} 이렇게 해도 됨 -->
  </form>
  <hr/>
  <h5>암호화된 비밀번호</h5>
  <div id="demo">${pwd}</div>
</div>
<p><br /></p>
<jsp:include page="/include/footer.jsp" />
</body>
</html>