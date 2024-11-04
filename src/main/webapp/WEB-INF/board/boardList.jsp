<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<c:set var="hostIp" value="${pageContext.request.remoteAddr}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>boardList.jsp</title>
  <jsp:include page="/include/bs4.jsp" />
  <script type="text/javascript">
  	'use strict'
  
  	function pageSizeChange() {
			let pageSize = document.getElementById("pageSize").value;
			location.href="BoardList.bo?pageSize="+pageSize+"&pag=${pag}&level=${level}";			
		}
  </script>
</head>
<body>
<jsp:include page="/include/header.jsp" />
<jsp:include page="/include/nav.jsp" />
<p><br /></p>
<div class="container">
  <h2>게 시 판 리 스 트</h2>
  <table class="table table-borderless text-left">
		  <tr>
		  	<td><a href="BoardInput.bo" class="btn btn-success btn-sm">글쓰기</a></td>
		  </tr>
  </table>
  <table class="table table-hover text-center">
		  <tr class="table table-secondary">
		  	<th>글번호</th>
		  	<th>글제목</th>
		  	<th>글쓴이</th>
		  	<th>글쓴날짜</th>
		  	<th>조회수(좋아요)</th>
		  </tr>
		  <c:set var="curScrStartNo" value="${curScrStartNo}" />
		  <c:forEach var="vo" items="${vos}" varStatus="st">
		  	<c:if test="${vo.openSw == '공개' || sMid == vo.mid || sLevel == 0}">
				  <tr>
				  	<td>${curScrStartNo}</td>
				  	<td class="text-left"><a href="BoardContent.bo?idx=${vo.idx}&pag=${pag}&hostIp=${hostIp}">${vo.title}</a></td>
				  	<td>${vo.nickName }</td>
				  	<td>${vo.wDate }</td>
				  	<td>${vo.readNum }</td>
				  </tr>
			  </c:if>
			  <c:set var="curScrStartNo" value="${curScrStartNo - 1}" />
		  </c:forEach>
		  <tr><td colspan="5" class="m-0 p-0"></td></tr>
  </table>
  <br/>
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
 	<br/>
  <!-- 블록페이지 시작-->	
  <div class="text-center">
  <!-- []은 구별용으로 해둔것 나중에 꾸미면 좋다 -->
  	<c:if test="${pag > 1}">[<a href="BoardList.bo?pageSize=${pageSize}&pag=1">첫페이지</a>]</c:if>
  	<c:if test="${curBlock > 0}">[<a href="BoardList.bo?pageSize=${pageSize}&pag=${(curBlock - 1)*blockSize + 1}">이전 블록</a>]</c:if>
  	<c:forEach var="i" begin="${(curBlock*blockSize)+1}" end="${(curBlock*blockSize)+blockSize}" varStatus="st">
  		<c:if test="${i <= totPage && i == pag}">[<a href="BoardList.bo?pageSize=${pageSize}&pag=${i}"><font color="red"><b>${i}</b></font></a>]</c:if>
  	<!--배타적으로 해야한다  -->
  		<c:if test="${i <= totPage && i != pag}">[<a href="BoardList.bo?pageSize=${pageSize}&pag=${i}">${i}</a>]</c:if>
  	</c:forEach>
  	<c:if test="${curBlock < lastBlock}">[<a href="BoardList.bo?pageSize=${pageSize}&pag=${(curBlock + 1)*blockSize + 1}">다음 블록</a>]</c:if>
  	<c:if test="${pag < totPage}">[<a href="BoardList.bo?pageSize=${pageSize}&pag=${totPage}">마지막페이지</a>]</c:if>
  </div>
  <!-- 블록페이지 끝 -->
</div>
<p><br /></p>
<jsp:include page="/include/footer.jsp" />
</body>
</html>