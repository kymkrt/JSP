<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>memberPasswordCheck.jsp</title>
  <jsp:include page="/include/bs4.jsp" />
  <script type="text/javascript">
  	'use script'
  	
  	const regexPwd = /^[a-zA-Z0-9\!\@\#\$\%\&\*]{2,20}$/;
  	
  	//먼저 해두기 : 제이 쿼리
  	$(function() {
			$("#pwdDemo").hide();
		});
  	
  	function pwdReCheck() {
			let pwd = $("#pwd").val().trim();
			if(pwd == "") {
				alert("현재 비밀번호를 입력하세요");
				$("#pwd").focus();
				return false;
			}
			
			$.ajax({
				type : "get", //get post 다됨
				url : "MemberPwdCheckAjax.mem",
				data : {pwd : pwd}, //"" 주의
				success:function(res){
					if(res != 0) $("#pwdDemo").show();
					else alert("비밀번호가 틀립니다. 확인하세요");
				},
				error: function(){
					alert("전송오류");
				}
			});
		}
  	
  	//비밀번호 변경처리
  	function pwdChangeCheck() {
			let pwdCheck = $("#pwdCheck").val();
			let pwdCheckRe = $("#pwdCheckRe").val();
			
			if(pwdCheck.trim() == "" || pwdCheckRe.trim() == "" || pwdCheck.length < 2 || pwdCheckRe.length < 2){
				alert("변경할 비밀번호를 입력하세요");
				$("#pwdCheck").focus();
				return false;
			}
			else if(pwdCheck.trim() != pwdCheckRe.trim()){
				alert("새로 입력한 비밀번호가 서로 다릅니다 확인하세요");
				$("#pwdCheck").focus();
				return false;
			}
			else pwdForm.submit();
  	}
  </script>
</head>
<body>
<jsp:include page="/include/header.jsp" />
<jsp:include page="/include/nav.jsp" />
<p><br /></p>
<div class="container">
	<!-- 서브밋으로 넘겼지만 원래는 유효성 체크 해야됨 -->
  <form name="myform" method="post" action="MemberPwdCheckOk.mem">
  	<div class="text-center">
  		<h4>비밀번호 확인</h4>
			<div>(회원 정보 수정을 하기 위해 현재 비밀번호를 확인합니다.)</div>
		</div>
		<div>비밀번호를 입력하세요
	  	<input type="password" name="pwd" id="pwd" placeholder="비밀번호를 입력하세요" class="form-control mb-2" autofocus required>
  	</div>
  	<div class="row text-center">
  		<div class="col"><button type="button" class="btn btn-success mb-2" onclick="pwdReCheck()">비밀번호 변경</button></div><!--현재화면에서 처리하고 싶다=동적폼  -->
  		<div class="col"><button type="submit" class="btn btn-primary mb-2">회원정보 변경</button></div>
  		<div class="col"><button type="reset" class="btn btn-warning mb-2">다시입력</button></div>
  		<!-- 메세지로 가는게 아니라 MemberJoin.mem 앞에/를 빼줌 -->
  		<div class="col"><button type="button" onclick="location.href='MemberMain.mem'" class="btn btn-info">돌아가기</button></div>
  	</div>
  </form>
  	<div class="text-center" id="pwdDemo">
  		<h4>비밀번호 변경</h4>
  		<form name="pwdForm" method="post" action="MemberPwdCheckAjaxOk.mem">
	  		<div>변경할 비밀번호
			  	<input type="password" name="pwdCheck" id="pwdCheck" placeholder="새비밀번호를 입력하세요" class="form-control mb-2" required>
			  </div>
	  		<div>비밀번호 확인
			  	<input type="password" name="pwdCheckRe" id="pwdCheckRe" placeholder="비밀번호를 다시한번 입력하세요" class="form-control mb-2" required>
			  </div>
			  <div>
			  	<input type="button" value="비밀번호 변경" onclick="pwdChangeCheck()" class="btn btn-secondary" />
			  </div>
  		</form>
		</div>
</div>
<p><br /></p>
<jsp:include page="/include/footer.jsp" />
</body>
</html>