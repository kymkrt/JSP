<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>memberList.jsp(admin)</title>
  <jsp:include page="/include/bs4.jsp" />
  <style>
    th, td {
      text-align: center;
    }
  </style>
  <script type="text/javascript">
  	'use strict';
  	
  	function levelchange(e) {
  		//let level = document.getElementById("level").value;
			let ans = confirm("선택한 회원의 등급을 변경하시겠습니까");
			if(!ans) {
				location.reload();//새로고침
				return false;
			}
			//alert("level : "+e.value);
			
			let items = e.value.split("/");
			
			$.ajax({
				type : "post", //get도 상관없음
				url : "MemberLevelChange.ad",
				data : {
					level : items[0],
					idx : items[1]
				},
				success:function(res){
					if(res != 0){
						alert("등급 수정 완료");
						location.reload();//새로고침
					}
					else alert("등급 수정 실패");
				},
				error : function(){
					alert("전송오류");
				}
			});
		}
  </script>
</head>
<body>
<p><br/></p>
<div class="container">
  <h2 class="text-center">회 원 리 스 트</h2>
  <table class="table table-hover">
    <tr class="table-secondary">
      <th>번호</th>
      <th>닉네임</th>
      <th>아이디</th>
      <th>성명</th>
      <th>성별</th>
      <th>생일</th>
      <th>이메일</th>
      <th>최종방문일</th>
      <th>활동여부</th>
      <th>현재레벨</th>
    </tr>
	  <c:forEach var="vo" items="${vos}" varStatus="st">
	    <tr <c:if test="${vo.userInfo != '공개'}"> style="background-color:#fcc" </c:if>>
	      <td>${st.count}</td>
	      <td>${vo.nickName}</td>
		      <td>${vo.mid}</td>
		      <td>${vo.name}</td>
		      <td>${vo.gender}</td>
		      <td>${fn:substring(vo.birthday,0,10)}</td>
		      <td>${vo.email}</td>
		      <td>
		        <c:if test="${sMid == vo.mid}">${fn:substring(sLastDate,0,16)}</c:if>
		        <c:if test="${sMid != vo.mid}">${fn:substring(vo.lastDate,0,16)}</c:if>
		      </td>
	      <td>
	        <c:if test="${vo.userDel == 'NO'}">활동중</c:if>
	        <c:if test="${vo.userDel != 'NO'}"><font color='red'>탈퇴신청중</font></c:if>
	      </td>
	      <td>
	      	<select name="level" id="level" onchange="levelchange(this)">
	      		<option value="1/${vo.idx}" ${vo.level == 1 ? 'selected' : ''}>준회원</option>
	      		<option value="2/${vo.idx}" ${vo.level == 2 ? 'selected' : ''}>정회원</option>
	      		<option value="3/${vo.idx}" ${vo.level == 3 ? 'selected' : ''}>우수회원</option>
	      		<option value="0/${vo.idx}" ${vo.level == 0 ? 'selected' : ''}>관리자</option>
	      		<option value="99/${vo.idx}" ${vo.level == 99 ? 'selected' : ''}>탈퇴신청회원</option>
	      	</select>
	      </td>
	    </tr>
  	</c:forEach>
  	<tr><td colspan="8" class="m-0 p-0"></td></tr>
  </table>
</div>
<p><br/></p>
</body>
</html>