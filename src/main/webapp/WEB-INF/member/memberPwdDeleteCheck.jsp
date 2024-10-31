<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>memberPwdDeleteCheck.jsp</title>
  <jsp:include page="/include/bs4.jsp" />
  <script type="text/javascript">
  	'use strict'
  	
  	function pwdCheck(){
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
					if(res != 0) {
						let ans = confirm("회원 탈퇴 신청을 하시겠습니까?");
						if(ans) {
							ans = confirm("회원 탈퇴를 하시면 1개월간 같은 아이디로 가입하실수 없습니다. \n 계속 진행하시겠습니까?");
							if(ans) myform.submit();
						}
					}
					else alert("비밀번호가 틀립니다. 확인하세요");
				},
				error: function(){
					alert("전송오류");
				}
			});
		}
  </script>
</head>
<body>
<jsp:include page="/include/header.jsp" />
<jsp:include page="/include/nav.jsp" />
<p><br /></p>
<div class="container">
  <h3>비밀 번호 확인</h3>
  <form name="myform" method="post" action="MemberDeleteCheckOk.mem">
  	<div class="text-center">
  		<h4>비밀번호 확인</h4>
			<div>(회원 탈퇴를 하기 위해 현재 비밀번호를 확인합니다.)</div>
		</div>
		<div>비밀번호
	  	<input type="password" name="pwd" id="pwd" placeholder="비밀번호를 입력하세요" class="form-control mb-2" autofocus required>
  	</div>
  	<div class="row text-center">
  		<div class="col"><button type="button" class="btn btn-success mb-2" onclick="pwdCheck()">회원탈퇴</button></div><!--현재화면에서 처리하고 싶다=동적폼  -->
  		<div class="col"><button type="reset" class="btn btn-warning mb-2">다시입력</button></div>
  		<!-- 메세지로 가는게 아니라 MemberJoin.mem 앞에/를 빼줌 -->
  		<div class="col"><button type="button" onclick="location.href='MemberMain.mem'" class="btn btn-info">돌아가기</button></div>
  	</div>
  </form>
</div>
<p><br /></p>
<jsp:include page="/include/footer.jsp" />
</body>
</html>