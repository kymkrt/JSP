<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
	String mid = (String)session.getAttribute("sMid"); //세션은 객체(object) 타입이라 캐스팅 필요
	pageContext.setAttribute("mid",mid);
	//if(mid ==null || mid.equals("")) response.sendRedirect(request.getContextPath()+"/");
%>

<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>ajaxTest.jsp</title>
  <jsp:include page="/include/bs4.jsp" />
  <script type="text/javascript">
  	'use strict'
  	
  	if(('${mid}' == null) || ('${mid}' == '')) {
  		alert("로그인 후 사용하세요");
  		location.href='${ctp}/';
  	}
  	
  	//숫자만 체크하는 함수
  	//이렇게 만들어만 두고 JS 파일로 써도 된다
  	function idCheck(mid) {
			if(mid == "") {
				alert("아이디를 입력하세요");
				myform.mid.focus();
				return "0";
			}
		}
  	
  	function idCheck0() {
			let mid  = myform.mid.value.trim();
			let flag = idCheck(mid);
			if(flag != "0") location.href = "AjaxIdCheck0.st?mid="+mid;
		}
  	
  	//브라우저 프로토콜중(객체)중 하나인 XMLHttpRequest 사용방식
  	function idCheck1() {
			let mid  = myform.mid.value.trim();
			let flag = idCheck(mid);
			//비동기식은 이렇게 끝내는게 깔끔하다
			if(flag == "0") return false;
			//비동기식 처리는 여기서 처리 하는게 좋다
			//여기서 자료 처리(정규식, 빈칸 처리 등)을 다하고 서버에 보내야한다
			
			//서버에 요청
			let xhr = new XMLHttpRequest();
			//			method    action  부분
			xhr.open("GET", "AjaxIdCheck1.st?mid="+mid);
			xhr.send();
			//여기에 인코딩이나 리턴 타입 같은걸 더 실을수 있다
			
			//서버 응답 처리
			xhr.onreadystatechange = function() { //익명 클래스
				if(xhr.readyState == XMLHttpRequest.DONE && xhr.status == 200){
					document.getElementById("demo").innerHTML = xhr.responseText;
				}
			}
		}
  	
  	//JQuery의 비동기식($.ajax()) 사용방식
  	//객체로 보내도 텍스트로 받는다 = restAPI
  	function idCheck2() {
			let mid  = myform.mid.value.trim();
			let flag = idCheck(mid);
			//비동기식은 이렇게 끝내는게 깔끔하다
			if(flag == "0") return false;
			//비동기식 처리는 여기서 처리 하는게 좋다
			//여기서 자료 처리(정규식, 빈칸 처리 등)을 다하고 서버에 보내야한다
			
			//제이쿼리라 파일이나 cdn이 무조건 있어야 함
			//키와 밸류로 가는 JSON 방식을 지향한다
			$.ajax({ //function도 필요 없다
				//	키(변수명) : 데이터(value), _ : _, _ : _ 마지막은, 없음. JSon방식
				//이 아래 3가지는 꼭 보낸다 무조건 기억
				type : "get",
				url : "AjaxIdCheck2", //디렉토리 패턴
				data : {"mid" : mid}, //변수는 무조건 JSON 사용		
				//여기부터 추가 형식
				//dataType : "json", 기본 타입이 이거라서 굳이 쓰면 에러남
				contextType : "application/json", //위걸 굳이 쓰려면 이렇게 써야함
				charset : "utf-8", //생략가능
				timeout : 10000, // 초단위. 생략가능
				//전송전
				beforeSend: function() { //콜백 함수. 익명함수
					console.log("mid(전) : "+mid);
				},
				
				//이안에서 모든 처리를 해야한다 
				
				//응답 받을때 이 2가지 쓴다 
				//텍스트로만 받는다
				success: function(res) { //익명함수 성공했을때
					console.log("mid(ajax처리후) : "+res);
					let str = "<font color='blue'>검색아이디 : "+mid+", 성명 : <b>"+res+"</b></font>";
					$("#demo").html(str);
				},
				//실무에서는 잘 안쓰지만 쓰면 좋다 
				error: function() {//익명함수 실패했을때
					alert("전송오류");
				},
				//전송후
				complete: function() {
					console.log("mid(후) : "+mid);
				}
			});
			
		}
  	
  	//최대 포인트 수혜자의 아이돠 성명과 포인트를 출력
  	function pointCheck1() {
			$.ajax({ //function도 필요 없다
				type : "get",
				url : "AjaxPointCheck", //디렉토리 패턴
				
				success: function(res) { //익명함수 성공했을때
					$("#demo").html(res);
				},
				error: function() {//익명함수 실패했을때
					alert("전송오류");
				}
			});
		}
  	
  	function pointCheck2() {
			$.ajax({ //function도 필요 없다
				type : "get",
				//컨트롤러 만들어야함
				url : "AjaxPointCheck.st", //확장자 패턴
				
				success: function(res) { //익명함수 성공했을때
					let str = "";
					let resArray = res.split("/");
					str += '<div class="bg-secondary p-2"><font color="white">';
					str += '아이디 : <b>'+resArray[0]+'</b><br/>';
					str += '성명 : <b>'+resArray[1]+'</b><br/>';
					str += '포인트 : <b>'+resArray[2]+'</b>';
					str += '</font></div>';
					$("#demo").html(str);
				},
				error: function() {//익명함수 실패했을때
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
  <h2>HTTP 통신</h2>
  <div>
  	<form name="myform">
  		아이디 :
  		<input type="text" name="mid" id="mid" class="form-control mb-2" />
  		<div>
	  		<input type="button" value="아이디 검색(동기식)" onclick="idCheck0()" class="btn btn-success mr-2" />
	  		<input type="button" value="아이디 검색(비동기식1(XMLHttpRequest))" onclick="idCheck1()" class="btn btn-primary mr-2" />
	  		<input type="button" value="아이디 검색(비동기식-JQuery(ajax))" onclick="idCheck2()" class="btn btn-info mr-2" />
	  		<input type="button" value="최대 포인트 이름1(비동기식-JQuery(ajax))" onclick="pointCheck1()" class="btn btn-secondary mr-2" />
	  		<input type="button" value="최대 포인트 이름2(비동기식-JQuery(ajax))" onclick="pointCheck2()" class="btn btn-danger mr-2" />
  		</div> 
  	</form>
  	<hr/>
  	<div id="demo"><font color="blue">출력결과(검색된 성명) : <b>${param.name}</b></font></div>
  </div>
  <hr/>
  <pre>
  	☞동기식(Synchronous) : 먼저 시작된 하나의 작업이 끝날때 까지 다른 작업들은 시작하지 않고 기다렸다가 앞의 작업이 모두 완료 되면 
  	새로운 작업을 시작하는 방식이다 
  	☞비동기식(Asynchronous) : 먼저 시작된 작업의 완료 여부와 상관없이 새로운 작업을 시작하는 방식
  		-바닐라 자바스크립트(초창기 자바스크립트)의 비동기식 : 브라우저의 XMLHttpRequest
  		-ECMA6(여기부터 표준 12까지 나옴) 자바스크립트의 비동기식 : 콜백함수(타임아웃, 인터벌 등), 
  			Promise, Promise를 활용한 async/await, 그리고 fetch()방식
  		-JQuery에서 제공해주는 비동기식 : $.ajax()   
  		
  	<h4>AJax</h4>
  	☞AJAX(Asynchronous Javascript And Xml)
  		자바스크립트 라이브러리 중의 하나이며 브라우저의 XMLHttpRequest를 이용하지 않고도 페이지 일부를 새로 고칠수 있도록 하는 기술
  		예전에는 XML 방식을 많이 사용하였으나 지금은 JSON방식(키, 값(밸류))을 많이 사용하기에 AJAX기법을 많이 사용하고 있다 
  		
  	<h5>☞AJAX에서 사용(RestAPI)하는 메소드 종류</h5>
  	- GET : 데이터를 읽거나 주로 검색시에 사용한다
  	- POST : 새로운 리소스를 생성할때 사용한다
  	- PUT : 리소스를 생성/업데이트 할때 사용한다
  	- DELETE : 지정된 리소스를 삭제할때 사용한다
  </pre>
</div>
<p><br /></p>
<jsp:include page="/include/footer.jsp" />
</body>
</html>