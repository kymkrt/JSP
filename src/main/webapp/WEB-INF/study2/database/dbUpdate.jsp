<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>dbUpdate.jsp</title>
  <jsp:include page="/include/bs4.jsp" />
  <style type="text/css">
  	th {
  		text-align: center;
  		background-color: #eee;
  	}
  </style>
  <script type="text/javascript">
  	'use strict'
  	
  	function deleteCheck() {
  		/*컴펌 얼러트 프롬프트 3가지가 자바스크립트에서 메세지를 처리 하는 방법   */
			let ans = confirm("삭제하시겠습니까?");//yes 면 true
			if(ans) location.href="${ctp}/study2/database/DbDeleteOk?idx=${vo.idx}"; //자바스크립트변수면 뒤에 넣어야 하지만 얘는 아니라서 안에 넣음
		}
  
  </script>
</head>
<body>
<jsp:include page="/include/header.jsp" />
<jsp:include page="/include/nav.jsp" />
<p><br /></p>
<div class="container">
  <h2 class="text-center">회 원 정 보 수 정</h2>
    <form name="myform" method="post" action="${ctp}/study2/database/DbUpdateOk">
  	<table class="table table-bordered">
  		<tr>
  			<th>성명</th>
				<td><input type="text" name="name" id="name" value="${vo.name}" class="form-control" autofocus required /></td>
			</tr>
			<tr>
				<th>나이</th>
	  		<td><input type="number" name="age" id="age" value="${vo.age}" class="form-control" required /></td>
	  	</tr>
  		<tr>
  			<th>성별</th>
				<td>
					<input type="radio" name="gender" id="gender" value="남자" <c:if test="${vo.gender=='남자'}">checked</c:if> required />남자 &nbsp;
					<input type="radio" name="gender" id="gender" value="여자" <c:if test="${vo.gender=='여자'}">checked</c:if> required  />여자
				</td>
			</tr>
  		<tr>
  			<th>주소</th>
				<td><input type="text" name="address" id="address" value="${vo.address}" class="form-control" /></td>
			</tr>
	  	<tr>
	  		<td colspan="2" class="text-center">
		  		<button type="submit" class="btn btn-info mr-2">회원정보수정</button>
		  		<button type="reset" class="btn btn-warning mr-2">다시입력</button>
		  		<button type="button" onclick="location.href='${ctp}/study2/database/DbList'" class="btn btn-primary mr-2">돌아가기</button>
		  		<button type="button" onclick="deleteCheck()" class="btn btn-danger">삭제</button>
	  		</td>
  		</tr>
  	</table>
  	<input type="hidden" name="idx" value="${vo.idx }" />
  </form>
</div>
<p><br /></p>
<jsp:include page="/include/footer.jsp" />
</body>
</html>