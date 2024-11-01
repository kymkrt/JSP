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
  body {
  	font-size : 0.9em;
  }
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
  	
  	// 등급별 조회
  	function levelViewCheck() {
			let level = document.getElementById("levelView").value;
			location.href="MemberList.ad?pageSize=${pageSize}&pag=${pag}&level="+level;			
		}
  	
  	// 사용자 페이지 설정
  	function pageSizeChange() {
			let pageSize = document.getElementById("pageSize").value;
			location.href="MemberList.ad?pageSize="+pageSize+"&pag=${pag}&level=${level}";			
		}
  </script>
</head>
<body>
<p><br/></p>
<div class="container">
  <h2 class="text-center">회 원 리 스 트</h2>
  <table class="table table-borderless">
  	<tr>
  		<td class="text-right">등급별조회
  			<select name="levelView" id="levelView" onchange="levelViewCheck()"><!--온체인지 아니면 버튼 또 눌러야 됨  -->
  				<option value="" <c:if test="${empty level}">selected</c:if> >전체회원</option><!--이미 보는 페이지니까 비워서 넘어온값이 없으면 전체회원으로 만들기  -->
  				<option value="1" <c:if test="${level==1}">selected</c:if> >준회원</option>
  				<option value="2" <c:if test="${level==2}">selected</c:if> >정회원</option>
  				<option value="3" <c:if test="${level==3}">selected</c:if> >우수회원</option>
  				<option value="0" <c:if test="${level==0}">selected</c:if> >관리자</option>
  				<option value="99" <c:if test="${level==99}">selected</c:if> >탈퇴신청회원</option>
  			</select>
  		</td>
  	</tr>
  </table>
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
		      <td><a href="MemberDetailView.ad?idx=${vo.idx}">${vo.mid}</a></td>
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
	        <c:if test="${vo.userDel != 'NO'}"><font color='red'>탈퇴신청중</font>(${vo.elapsed_date})</c:if>
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
  	<tr><td colspan="10" class="m-0 p-0"></td></tr>
  </table>
  
  <!--사용자 페이지 설정  -->
  <table class="table table-borderless">
  	<tr>
  		<td class="text-right">
  			<select name="pageSize" id="pageSize" onchange="pageSizeChange()"><!--온체인지 아니면 버튼 또 눌러야 됨  -->
  				<option <c:if test="${pageSize == 3}">selected</c:if> >3</option>
  				<option <c:if test="${pageSize == 5}">selected</c:if> >5</option>
  				<option <c:if test="${pageSize == 10}">selected</c:if> >10</option>
  				<option <c:if test="${pageSize == 15}">selected</c:if> >15</option>
  				<option <c:if test="${pageSize == 20}">selected</c:if> >20</option>
  				<option <c:if test="${pageSize == 30}">selected</c:if> >30</option>
  			</select>
  		</td>
  	</tr>
  </table>
  
  <!-- 블록페이지 시작-->
  <div class="text-center">
  <!-- []은 구별용으로 해둔것 나중에 꾸미면 좋다 -->
  	<c:if test="${pag > 1}">[<a href="MemberList.ad?level=${level}&pageSize=${pageSize}&pag=1">첫페이지</a>]</c:if>
  	<c:if test="${curBlock > 0}">[<a href="MemberList.ad?level=${level}&pageSize=${pageSize}&pag=${(curBlock - 1)*blockSize + 1}">이전 블록</a>]</c:if>
  	<c:forEach var="i" begin="${(curBlock*blockSize)+1}" end="${(curBlock*blockSize)+blockSize}" varStatus="st">
  		<c:if test="${i <= totPage && i == pag}">[<a href="MemberList.ad?level=${level}&pageSize=${pageSize}&pag=${i}"><font color="red"><b>${i}</b></font></a>]</c:if>
  	<!--배타적으로 해야한다  -->
  		<c:if test="${i <= totPage && i != pag}">[<a href="MemberList.ad?level=${level}&pageSize=${pageSize}&pag=${i}">${i}</a>]</c:if>
  	</c:forEach>
  	<c:if test="${curBlock < lastBlock}">[<a href="MemberList.ad?level=${level}&pageSize=${pageSize}&pag=${(curBlock + 1)*blockSize + 1}">다음 블록</a>]</c:if>
  	<c:if test="${pag < totPage}">[<a href="MemberList.ad?level=${level}&pageSize=${pageSize}&pag=${totPage}">마지막페이지</a>]</c:if>
  </div>
  <!-- 블록페이지 끝 -->
</div>
<p><br/></p>
</body>
</html>