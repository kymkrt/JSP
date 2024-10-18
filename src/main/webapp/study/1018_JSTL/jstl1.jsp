<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <!--prefix 접두어  -->
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>jstl1.jsp</title>
  <jsp:include page="/include/bs4.jsp" />
</head>
<body>
<p><br /></p>
<div class="container">
  <h2>JSTL(Java Standard Tag Library)</h2>
  <!--기본제공 JSTL 라이브러리  -->
  <div>
  	
  </div>
	<table class="table table-bordered">
	<!--CDN < c :같은 방식 -->
		<tr>
			<th>라이브러리</th>
			<th>주소(URL)</th>
			<th>접두어</th>
			<th>기본문법</th>
		</tr>
		<tr>
			<td>Core</td>
			<td>http://java.sun.com/jsp/jstl/core</td>
			<td>c</td>
			<!-- 원래는 다 붙어야됨 -->
			<td>< c : 태그명... ></td>
		</tr>
		<tr>
		<!-- ,(쉼표)나 날짜 형식같은거 -->
			<td>Formatting</td>
			<td>http://java.sun.com/jsp/jstl/fmt</td>
			<td>fmt</td>
			<td> < fmt : 태그명... ></td>
		</tr>
		<tr>
		<!--함수  -->
			<td>Function</td>
			<td>http://java.sun.com/jsp/jstl/function</td>
			<td>fn</td>
			<td>$ { fn : 태그명... }</td>
		</tr>
		<tr>
		<!--거의 안씀 select, insert등 과 같은걸 쓰기 때문  -->
			<td>SQL</td>
			<td>http://java.sun.com/jsp/jstl/sql</td>
			<td>sql</td>
			<td> < sql : 태그명... ></td>
		</tr>
	</table>  
	<hr/>
	<div>
		앞에 기술된 라이브러리를 사용할 경우에는 반드시 상단에 JSP지시자 'taglib지시자'를 사용하여 CDN을 기록해야 한다.(선언)
	</div>
	<hr/>
	<h2>Core 라이브러리 사용예</h2>
	<pre>
		<h4>용도 : 변수제어(선언/값(일반, 객체)할당/출력/제거), 제어문(조건문, 반복문)</h4>
		변수선언 : < c : set var="변수명" value="값" >< / c :set > <!--얘도 똑같이 뒤에 쓰는거 없으면 /로 마무리 할수 있다?  -->
		변수출력 : < c : out value="값/변수/수식" /> <!--/c~ 마무리 가능  -->
		변수제거 : < c : remove var="변수명" />
		
	</pre>
	<hr/>
	<!-- 설정할때나 출력할때는 EL로 해라 -->
	su1변수 선언후 초기값으로 100을 할당 <c:set var="su1" value="100"></c:set><br/> <!--숫자든 문자든 ""필요 타입도 없음-->
	<!--이제는 전부 EL을 써야함 값변수객체 다 올수 있음  -->
	값을 출력1 <c:out value="200"></c:out><br/>
	값을 출력2 <c:out value="${200}"></c:out><br/>
	su1변수값을 출력1 <c:out value="${su1}" /><br/> 
	su1변수값을 출력2 ${su1}<br/>
	<% String name = "홍길동"; %>
	문자열 출력1 <%=name %><br/>
	<%pageContext.setAttribute("name", name); %>
	문자열 출력2 <c:out value="${name}"></c:out><br/>
	<!--이걸로 가져오면 그냥 EL 가능 여기서는 이렇게 쓰자  -->
	문자열 출력3 ${name}<br/>
	<hr/>
	
	<h4>JSTL 제어문(조건문:if, 반복문:foreach)</h4>
	<pre>
	사용법 : < c : if test="$ {조건식}" >조건식이 참일때 수행내용< / c : if >
	단점 : else문이 없다. 숫자 데이터라도 문자형식으로 비교한다
	</pre>
	<p>su3=300, su4=400</p>
	<c:set var="su3" value="${300}" />	
	<!--그냥 수 같은건 빼도 됨 수식이나 객체는 무조건 EL -->
	<c:set var="su4" value="400" />	
	<div>su3 : ${su3} / su3 : ${su4}</div>
	<!--JSTL에는 else가 없어 항상 배타적으로 물어봐야한다  -->
	<div>1-1. su3 == su4 : <c:if test="${su3 == su4}">1-1.su3와 su4는 같다.</c:if></div>
	<div>1-2. su3 eq su4 : <c:if test="${su3 eq su4}">1-2.su3와 su4는 같다.</c:if></div>
	<div>2-1. su3 != su4 : <c:if test="${su3 != su4}">2-1.su3와 su4는 같지않다.</c:if></div>
	<div>2-2. su3 ne su4 : <c:if test="${su3 ne su4}">2-2.su3와 su4는 같지않다.</c:if></div>
	<div>3-1. su3 > su4 : <c:if test="${su3 > su4}">3-1.su3이 su4보다 크다.</c:if></div>
	<div>3-2. su3 gt su4 : <c:if test="${su3 gt su4}">3-2.su3이 su4보다 크다.</c:if></div>
	<div>4-1. su3 >= su4 : <c:if test="${su3 >= su4}">4-1.su3이 su4보다 크거나 같다.</c:if></div>
	<div>4-2. su3 ge su4 : <c:if test="${su3 ge su4}">4-2.su3이 su4보다 크거나 같다.</c:if></div>
	<div>5-1. su3 < su4 : <c:if test="${su3 < su4}">5-1.su3이 su4보다 작다.</c:if></div>
	<div>5-2. su3 lt su4 : <c:if test="${su3 lt su4}">5-2.su3이 su4보다 작다.</c:if></div>
	<div>6-1. su3 <= su4 : <c:if test="${su3 <= su4}">6-1.su3이 su4보다 작거나 같다.</c:if></div>
	<div>6-2. su3 le su4 : <c:if test="${su3 le su4}">6-1.su3이 su4보다 작거나 같다.</c:if></div>
	<br/>
	
	<p>su5=500, su6=60</p>
	<c:set var="su5" value="500" />	
	<c:set var="su6" value="60" />	
	<div>su5 : ${su5} / su6 : ${su6}</div>
	<!--문자 비교는 앞에서 부터 비교 예) 500 60 의 앞자리만 비교 5<6 그럼 더이상 비교 안함 같으면 다음자리로 넘겨서 계산 숫자 데이터라도 문자형식으로 비교한다  -->
	<div>7. su5 > su6 : <c:if test="${su5 > su6}">7. su5가 su6보다 크다.</c:if></div>
	<div>8. su5 <= su6 : <c:if test="${su5 <= su6}">8. su5가 su6 작거나 같다.</c:if></div> <!--위 조건의 배타적  -->
	<!--해결책: 연산을 하면 수치로 본다  EL은 내부에서 연산도 가능-->
	<div>9. su5 > su6 : <c:if test="${su5+0 > su6+0}">9. su5가 su6보다 크다.</c:if></div>
	<div>10. su5 <= su6 : <c:if test="${su5+0 <= su6+0}">10. su5가 su6 작거나 같다.</c:if></div> 
	
	<p>su7=500, su8=60</p>
	<c:set var="su7" value="${500}" />	
	<c:set var="su8" value="${60}" />	
	<!--다 EL로 하면 숫자로 본다  -->
	<div>su7 : ${su7} / su8 : ${su8}</div>
	<div>11. su7 > su8 : <c:if test="${su7 > su8}">11. su7가 su8보다 크다.</c:if></div>
	<div>12. su7 <= su8 : <c:if test="${su7 <= su8}">12. su7가 su8 작거나 같다.</c:if></div> <!--위 조건의 배타적  -->
	<hr/>
	
	<div>예제1 : URL에 점수(jumsu)를 QueryString 방식으로 입력후 학점을 구하시오</div>
	<div>변수명 : 입력점수는 jum, 학점은 grade로 처리 </div>
	<div>
		<!-- 여기 value에서는 EL안쓰고 그냥 쓴다 EL을 쓰면 변수로 보기 때문 -->
		<c:set var="jum" value="${param.jumsu}"></c:set>
		<!--가능하면 꼭 EL로 넣어야 한다 안그럼 +0 다해줘야한다  -->
		<!--else가 없기 때문에 이런식으로 거꾸로(배타적) 처리해야한다   -->
		<c:if test="${jum >= 60}"><c:set var="grade" value="D"></c:set></c:if>
		<c:if test="${jum >= 70}"><c:set var="grade" value="C"></c:set></c:if>
		<c:if test="${jum >= 80}"><c:set var="grade" value="B"></c:set></c:if>
		<c:if test="${jum >= 90}"><c:set var="grade" value="A"></c:set></c:if>
		<c:if test="${jum < 60}"><c:set var="grade" value="F"></c:set></c:if>
		입력받은 점수는 ${jum}의 학점은 ${grade} 입니다
	</div>
	<br/>
	
	<h4>다중조건비교 : choose ~ when(switch 랑 똑같이 작동)</h4>
	<pre>사용법: 
		< c : choose >
			< c : when test="조건식1">수행할내용1 < / c : when >
			< c : when test="조건식2">수행할내용2 < / c : when >
			< c : when test="조건식3">수행할내용3 < / c : when >
			< c : when test="조건식4">수행할내용4 < / c : when >
			~~~~~~~~~~
			< c : otherwise >기타 수행할 내용(default?) < / c : otherwise >
		< / c : choose>
	</pre>
	<div>학점은
		<c:choose>
			<c:when test="${jum >= 90}">A</c:when>
			<c:when test="${jum >= 80}">B</c:when>
			<c:when test="${jum >= 70}">C</c:when>
			<c:when test="${jum >= 60}">D</c:when>
			<c:otherwise>F</c:otherwise>
		</c:choose>
		학점입니다.
	</div>
	<br/>
	
	<div>예제2 : URL에 직급코드(code)를 QueryString방식으로 입력후 직급명을 출력하시오</div>
	<div>직급코드(kCode) : B(부장), K(과장), D(대리), S(사원) / 직급명(kName)</div>
	<div>직급코드가 앞의 코드 외의 값이 들어오면 '파견근로자'라고 출력한다</div>
	~~~~~<hr/>
	<div>
	
	<c:set var="code" value="${param.kCode }"></c:set>
	<c:choose>
		<c:when test="${code == 'B'}"><c:set var="kName" value="부장"></c:set></c:when>
		<c:when test="${code == 'K'}"><c:set var="kName" value="과장"></c:set></c:when>
		<c:when test="${code == 'D'}"><c:set var="kName" value="대리"></c:set></c:when>
		<c:when test="${code == 'S'}"><c:set var="kName" value="사원"></c:set></c:when>
		<c:otherwise><c:set var="kName" value="파견 근로자"></c:set></c:otherwise>
	</c:choose>	
	<div>직급코드 : ${code} / 직급명 : ${kName}</div>
	</div>
	
</div>
<p><br /></p>
</body>
</html>