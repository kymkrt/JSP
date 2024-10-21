<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>jtll3_res2.jsp</title>
  <jsp:include page="/include/bs4.jsp" />
  <style type="text/css">
  	th,td {
  		text-align: center;
  	}
  </style>
</head>
<body>
<p><br /></p>
<div class="container">
	<h5>Database에서 가져온 여러건의 자료를 출력(vos)</h5>
	<table class="table table-hover">
		<tr class="table-secondary">
			<th>번호</th>
			<th>성명</th>
			<th>나이</th>
			<th>성별</th>
			<th>직업</th>
			<th>주소</th>
		</tr>		
		<!--vos이므로 tr이 여러개 반복되야 한다 = 반복문  -->
		<!--향상된for문으로 vo에 vos한줄씩을 받아서 쓴다 그래서 vo  -->
		<c:forEach var="vo" items="${vos}" varStatus="st"> <!--객체가 왔으므로 아이템 아이템은 EL 번호를 쓰니까 count -->
		<tr>
			<td>${st.count}</td>
			<td>${vo.name}</td>
			<td>${vo.age}</td>
			<td>${vo.gender}</td>
			<td>${vo.job}</td>
			<td>${vo.address}</td>
		</tr>
		</c:forEach>
		<tr><td colspan="6" class="m-0 p-0"></td></tr>
	</table>
  <!--디스패처로 보냈을때는 다른 위치다?  -->
  <div><a href="${ctp}/study/1018_JSTL/jstl3_vo.jsp" class="btn btn-success">돌아가기</a></div>
</div>
<p><br /></p>
</body>
</html>