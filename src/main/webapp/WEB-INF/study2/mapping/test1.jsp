<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>test1.jsp</title>
  <jsp:include page="/include/bs4.jsp" />
  <script type="text/javascript">
  	'use strict'	
  	
  	$(function () {
			$("#demo1").hide();
			$("#demo2").hide();
			$("#demo3").hide();
  	
	  	if('${hap}' != "") {
	  		$("#demo1").show();
	  	}
	  	else if('${gob}' != ""){
	  		$("#demo2").show();
	  	}
	  	else if('${today}' != "") {
	  		$("#demo3").show();
	  	}
		})
  	
		/*플래그를 넘겨서   */
  	function fCheck(flag) {
  		let su1 = myform.su1.value;		
  		let su2 = myform.su1.value;
  		if(flag==1 || flag==3){
	  		if(su1 == "" || su2 == ""){
	  			alert("수를 입력하세요");
	  			myform.su1.focus();
	  		}
	  		else{
	  			//post방식
	  			myform.flag.value = flag;
	  			myform.submit();
	  		}
  		} else if(flag == 2){
  			/* location.href = "${ctp}/mapping/Test1Ok" */
	  			myform.flag.value = flag;
	  			myform.submit();
  		} else if(flag == 4) {
					//Get방식  			
	  			location.href = "${ctp}/mapping/Test1Ok?flag=4"
  		}
		}
  	
  </script>
</head>
<body>
<jsp:include page="/include/header.jsp" />
<jsp:include page="/include/nav.jsp" />
<p><br /></p>
<div class="container">
  <h2>이곳은 test1.jsp 입니다(/WEB-INF/study2/mapping) - URL 패턴(디렉토리 패턴)</h2>
  <hr/>
  <div>전송된 메세지 : ${msg}</div>
  <hr/>
  <div class="row">
  	<div class="col"><input type="button" value="두수의 합/차" onclick="fCheck(1)" class="btn btn-success mr-2" /></div>
  	<div class="col"><input type="button" value="돌아가기" onclick="fCheck(2)" class="btn btn-primary mr-2" /></div>
  	<div class="col"><input type="button" value="두수의 곱/몫" onclick="fCheck(3)" class="btn btn-warning mr-2" /></div>
  	<div class="col"><input type="button" value="현재시간" onclick="fCheck(4)" class="btn btn-info mr-2" /></div>
  </div>
  <hr/>
  <form name="myform" method="post" action="${ctp}/study2/mapping/Test1Ok">
  	<input type="number" name="su1" value="${su1}" placeholder="첫번째 수를 입력하세요" class="form-control mb-2" />
  	<input type="number" name="su2" value="${su2}" placeholder="두번째 수를 입력하세요" class="form-control mb-2" />
  	<!-- 히든은 마지막 폼 위에 -->
  	<input type="hidden" name="flag" >
  </form>
	<hr/>
	<!-- <div id="demo" style="display: none;"> -->
	<div id="demo1">
		<div>두수의 합 : ${hap}</div>
		<div>두수의 차 : ${cha}</div>
	</div>
	<div id="demo2">
		<div>두수의 곱 : ${gob}</div>
		<div>두수의 몫 : ${mok}</div>
	</div>
	<div id="demo3">
	<!-- jstl에서는 변수 먼저 -->
	<c:set var="strDate" value="${fn:substring(today,0,10)}" />
	<!--이렇게 JSTL을 썼을때   -->
	<c:set var="strTime" value="${fn:substring(today,11,19)}" />
		<div>전송된 today : ${today}</div>
		<!--< c out 를 써도 되지만 어차피 그안에서도 EL을 써야하기 때문에 그냥 처음부터 EL 표기하는게 좋다  -->
		<div>오늘날짜 : ${strDate}</div>
		<div>현재시간 : ${strTime} : <c:out value="${strTime}" /></div>
	</div>
</div>
<p><br /></p>
<jsp:include page="/include/footer.jsp" />
</body>
</html>