<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <!--core 라이브러리 사용  -->
<!--태그인데 html 바깥이라 자동완성이 안됨  -->
<c:set var="ctp" value="${pageContext.request.contextPath}" /> <!--value는 EL  -->
<!--
자료구조에 나옴
prefix(Rt-L-R) 접두어 위에서 시작 왼쪽 다음 오른쪽
postfix(Rt-R-L) 접미어
infix(L-Rt-R)
  -->
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>jstl2.jsp</title>
  <jsp:include page="/include/bs4.jsp" />
</head>
<body>
<p><br /></p>
<div class="container">
  <h2>JSTL반복문(core 라이브러리 사용 : forEach문)</h2>
  <pre>
  	사용법 1 : < c : forEach var="변수" begin="초기값" end="최종값" step="증감값" varStatus="매개변수"> ~~ < / c : forEach >
  	step이 1이면 생략가능. varStatus="변수" 는 매개값을 필요로 할 경우에만 표기하면 됨
  	<!--이렇게 EL 표기 다른곳에 할때 $ 여기 무조건 공백이 있어야한다 {}  -->
  	사용법 2 : < c : forEach var="변수" items="$ {객체명}" (배열도 객체) varStatus="매개변수"> ~~ < / c : forEach > <!--일종의 향상된 포문  -->
  	사용법 3 : < c : forTokens var="변수" items="$ {객체명}" (배열도 객체) delims="구분기호"> ~~ < / c : forTokens >
  </pre>
  <hr/>
  <p>사용법1</p>
  <c:forEach var="i" begin="1" end="10" step="1">
  <!--c r 대신 EL 사용  -->
  	${i} /
  </c:forEach>
  <br/><br/>
  <p>사용법2</p>
<%
	String[] cards = {"국민", "BC", "LG", "현대", "삼성", "농협", "신한"};
/*저장소에 담아야 EL 사용가능 그래서 pageContext  */
	pageContext.setAttribute("cards", cards);
%>
	<c:forEach var="card" items="${cards}">
		${card} /
	</c:forEach>
  <br/><br/>
  <p>사용법3</p>
  <c:set var="hobbys" value="등산/수영/낚시/바둑/독서/승마/바이크" />
  취미 : ${hobbys}<br/>
  '/'를 구분기호로 분리해서 ','로 출력 :
  <!-- items는 EL사용 -->
  <c:forTokens var="hobby" items="${hobbys}" delims="/">
  	${hobby} ,
  </c:forTokens>
  <br/><br/>
  <p>사용법4(상태변수 사용예)</p>
	<div>count / index(0부터) / current / first / last</div>
	<!--상태 변수 쓰려면 varStatus 넣어야함  -->
	<c:forEach var="card" items="${cards}" varStatus="st">
		${st.count} <!-- 현재 지나가는 번호 -->(${st.index}) : ${card} 카드 , 조건? a.${st.current}, b.${st.first} , c.${st.last}<br/>
	</c:forEach>
	<hr/>
	<h5>1.구구단 5단을 출력하세요</h5>
	*5단 *<br />
	<c:forEach var="i" begin="1" end="9" step="1">
  <!--c r 대신 EL 사용  -->
  	5*${i} = ${i*5} <br/>
  </c:forEach>
  <hr/>
	<h5>2.구구단 2~5단을 출력하세요</h5>
	<c:forEach var="i" begin="2" end="5" step="1">
	${i}단 : 
		<c:forEach var="j" begin="1" end="9">
  <!--c r 대신 EL 사용  -->
  	${i}*${j} = ${i*j} <br/>
  	</c:forEach>
  </c:forEach>
  <hr/>
	<h5>3.저장된 6장의 사진을 출력하세요</h5>
	<c:forEach var="i" begin="1" end="6" step="1">
		<!-- <img src="<%=request.getContextPath()%>/images/${i}.jpg" width="100px" />&nbsp; -->
		<!-- <img src="${pageContext.request.contextPath}/images/${i}.jpg" width="100px" />&nbsp; -->
		<img src="${ctp}/images/${i}.jpg" width="100px" />&nbsp;
	</c:forEach>
  <hr/>
	<h5>4.저장된 6장의 사진을 배열에 저장시킨후 1줄에 3장씩 출력하세요</h5>
	<!--구분자가 /로 구별되어있으니 배열 그러면 forTokens로 해야한다  -->
	<c:set var="images" value="2/3/4/5/6/7" />
	<!--상태 변수 쓰려면 varStatus 넣어야함  -->
	<c:forTokens var="i" items="${images}" delims="/" varStatus="st">
		<!-- <img src="<%=request.getContextPath()%>/images/${i}.jpg" width="100px" />&nbsp; -->
		<img src="${pageContext.request.contextPath}/images/${i}.jpg" width="100px" />&nbsp;
		<c:if test="${st.count % 3 == 0}"><br/><br/></c:if>
	</c:forTokens>
	<br/><br/>
	
	<h5>4. 2차원 배열에 저장된 자료를 한행에 3개씩 출력해보자</h5>
<%
	String[][] members = {
			{"홍길동","서울","23"},			
			{"김말숙","청주","31"},			
			{"이기자","제주","40"},			
			{"오하늘","서울","20"},			
			{"강감찬","인천","50"}		
	};
/* 담아야 사용가능 */
pageContext.setAttribute("members", members);
%>
<!--items나 test는 무조건 EL  -->
	<c:forEach var="member" items="${members}">
		<c:forEach var="m" items="${member}">
			${m} /
		</c:forEach>
		<br/>
	</c:forEach>
	<br/>
	
	<h5>5. 2차원 배열에 저장된 자료를 한행에 3개씩 출력해보자(서울에 사는 자료의 서울 단어만 빨간색으로 출력)</h5>
<!--items나 test는 무조건 EL  -->
	<c:forEach var="member" items="${members}">
		<c:forEach var="m" items="${member}" varStatus="st">
			<c:if test="${m == '서울'}"><font color="red">${m}</font></c:if> /
		<!--else가 없기 때문에 늘 배타적인것 추가 필요  -->
			<c:if test="${m != '서울'}">${m}</c:if> /
			<%-- <c:if test="${st.current == '서울'}">
				<font color="red"> ${m} /</font>
			</c:if> --%>
		</c:forEach>
		<br/>
	</c:forEach>
	<br/>
	<h5>6. 2차원 배열에 저장된 자료를 한행에 3개씩 출력해보자(나이가 25세 미만은 굵고 파란색 출력)</h5>
<!--items나 test는 무조건 EL  -->
	<c:forEach var="member" items="${members}">
		<c:forEach var="m" items="${member}" varStatus="st">
			<c:if test="${m < '25'}"><font color="blue"><b>${m}</b></font></c:if> /
		<!--else가 없기 때문에 늘 배타적인것 추가 필요  -->
			<c:if test="${m >= '25'}">${m}</c:if> /
			<%-- <c:if test="${st.current == '서울'}">
				<font color="red"> ${m} /</font>
			</c:if> --%>
		</c:forEach>
		<br/>
	</c:forEach>
	<br/>
	
	<h5>7. cards의 내용중 첫번째 카드의 배경색은 노랑 마지막 카드의 배경색은 하늘색으로 출력</h5>
	<c:forEach var="card" items="${cards}" varStatus="st">
		<c:if test="${st.first}"><span style="background-color:yellow">${card} /</span> </c:if>
		<c:if test="${st.last}"><span style="background-color:skyblue">${card} /</span> </c:if>
		<!--else가 없기 때문에 늘 배타적인것 추가 필요  -->
		<c:if test="${!st.first && !st.last}">${card} /</c:if>
	</c:forEach>
	<hr/>
	<h5>8. cards의 내용중 국민 카드 파랑색 삼성카드는 빨강색 첫번째 카드의 배경은 노랑 마지막 카드의 배경은 하늘색 출력하시오</h5>
	<c:forEach var="card" items="${cards}" varStatus="st">
		<c:if test="${st.first}"><span style="background-color:yellow">${card} /</span> </c:if>
		<c:if test="${st.last}"><span style="background-color:skyblue">${card} /</span> </c:if>
		<c:if test="${st.current == '국민'}"><span style="background-color:blue">${card} /</span> </c:if>
		<c:if test="${st.current == '삼성'}"><span style="background-color:red">${card} /</span> </c:if>
		<!--else가 없기 때문에 늘 배타적인것 추가 필요  -->
		<c:if test="${!st.first && !st.last && st.current != '삼성' && st.current != '국민'}">${card} /</c:if>
	</c:forEach>
</div>
<p><br /></p>
</body>
</html>