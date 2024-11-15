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
  <title>ajaxTest2.jsp</title>
  <jsp:include page="/include/bs4.jsp" />
  <script type="text/javascript">
  	'use strict'
  	
  	//아이디 체크 함수
  	function idCheck(mid){
			if(mid == "") {
				alert("아이디를 입력하세요");
				myform.mid.focus();
				return "0";
			}
		}
  	
  	//일반 AJAX 처리
  	function idCheck1(){
			let mid = myform.mid.value;
			if(idCheck(mid)== "0") return false;
			
			$.ajax({
				type: "get",
				url: "${ctp}/AjaxIdCheck2_1", /*디렉토리방식 ctp있어야 함 없으면 도메인으로 본다 */
				data: {
					mid:mid
				},
				success: function(res) {
					let str = "성명 : "+res;
					$("#demo").html(str);
				},
				error: function() {
					alert("전송실패");
				}
			});
		}
  	
  	//vo객체형식으로 자료 전달해보기(vo객체를 넘길수는 없다 넘겨봐야 문자로 옴)
  	function idCheck2(){
			let mid = myform.mid.value;
			if(idCheck(mid)== "0") return false;
			
			$.ajax({
				type: "get",
				url: "${ctp}/AjaxIdCheck2_2", /*디렉토리방식 ctp있어야 함 없으면 도메인으로 본다 */
				data: {
					mid:mid
				},
				success: function(res) {
					$("#demo").html(res);
					
					if(res.indexOf("/") != -1){
						let str = res.split("/");
						$("#imsiMid").html(str[0]);
						$("#imsiName").html(str[1]);
						$("#imsiAge").html(str[2]);
						$("#imsiGender").html(str[3]);
						$("#imsiAddress").html(str[4]);
					}
				},
				error: function() {
					alert("전송실패");
				}
			});
		}
  	
  	//vo객체를 JSON 형식으로 변경후 전달받아 처리하기
  	function idCheck3(){
			let mid = myform.mid.value;
			if(idCheck(mid)== "0") return false;
			
			$.ajax({
				type: "get",
				url: "${ctp}/AjaxIdCheck2_3", /*디렉토리방식 ctp있어야 함 없으면 도메인으로 본다 */
				data: {
					mid:mid
				},
				success: function(res) {
					console.log("res : "+res);
					$("#demo").html(res);
					
					//넘어온 JSON자료를 자바스크립트에서 사용하기 위한 Object로 변환한다(파싱한다)
					let js = JSON.parse(res);//자바스크립트의 오브젝트로 바뀐다
					//parse 문자열로 넘어온걸 자바스크립트 객체로 바꾸는것
					//문자로 바꾸는것 toJSONString() 서블릿에서 사용
					console.log("js : ", js); //관리자도구에서 보면 오브젝트로 바뀌어있음

					let str = res.split("/");
					$("#imsiMid").html(js.mid);
					$("#imsiName").html(js.name);
					$("#imsiAge").html(js.age);
					$("#imsiGender").html(js.gender);
					$("#imsiAddress").html(js.address);
					
				},
				error: function() {
					alert("전송실패");
				}
			});
		}
  	
  	//vos객체를 JSON 형식으로 변경후 전달받아 처리하기
  	function idCheck4(){
			let mid = myform.mid.value;
			if(idCheck(mid)== "0") return false;
			
			$.ajax({
				type: "get",
				url: "${ctp}/AjaxIdCheck2_4", /*디렉토리방식 ctp있어야 함 없으면 도메인으로 본다 */
				data: {
					mid:mid
				},
				success: function(res) {
					console.log("res : "+res);
					$("#demo").html(res);
										
					//json형태의 데이터는 파싱 시키면 자바스크립트 오브젝트가 되는것 배열이 된다?
					//넘어온 JSON자료를 자바스크립트에서 사용하기 위한 Object로 변환한다(파싱한다)
					let js = JSON.parse(res);//자바스크립트의 오브젝트로 바뀐다
					//parse 문자열로 넘어온걸 자바스크립트 객체로 바꾸는것
					//문자로 바꾸는것 toJSONString() 서블릿에서 사용
					console.log("js : ", js); //관리자도구에서 보면 오브젝트로 바뀌어있음
					
					let tMid = "", tName="", tAge="", tGender="", tAddress="";					
					for(let j of js) {
						tMid += j.mid+"/";
						tName += j.name+"/";
						tAge += j.age+"/";
						tGender += j.gender+"/";
						tAddress += j.address+"/";
					}
						$("#imsiMid").html(tMid);
						$("#imsiName").html(tName);
						$("#imsiAge").html(tAge);
						$("#imsiGender").html(tGender);
						$("#imsiAddress").html(tAddress);
				},
				error: function() {
					alert("전송실패");
				}
			});
		}
  	
  	//vos객체를 JSON 형식으로 변경후 전달받아 처리하기
  	function idCheck5(){
			let mid = myform.mid.value;
			if(idCheck(mid)== "0") return false;
			
			$.ajax({
				type: "get",
				url: "${ctp}/AjaxIdCheck2_5", /*디렉토리방식 ctp있어야 함 없으면 도메인으로 본다 */
				data: {
					mid:mid
				},
				success: function(res) {
					console.log("res : "+res);
					$("#demo").html(res);
										
					//json형태의 데이터는 파싱 시키면 자바스크립트 오브젝트가 되는것 배열이 된다?
					//넘어온 JSON자료를 자바스크립트에서 사용하기 위한 Object로 변환한다(파싱한다)
					let js = JSON.parse(res);//자바스크립트의 오브젝트로 바뀐다
					//parse 문자열로 넘어온걸 자바스크립트 객체로 바꾸는것
					//문자로 바꾸는것 toJSONString() 서블릿에서 사용
					console.log("js : ", js); //관리자도구에서 보면 오브젝트로 바뀌어있음
					
					let tMid = "", tName="", tAge="", tGender="", tAddress="";					
					for(let j of js) {
						tMid += j.mid+"/";
						tName += j.name+"/";
						tAge += j.age+"/";
						tGender += j.gender+"/";
						tAddress += j.address+"/";
					}
						$("#imsiMid").html(tMid);
						$("#imsiName").html(tName);
						$("#imsiAge").html(tAge);
						$("#imsiGender").html(tGender);
						$("#imsiAddress").html(tAddress);
						
						//앞에서 넘어온 JSON 형식의 자료를 자바스크립트 Object로 변경후 보기좋게 출력한다 여기선 tabel 사용
						let i = 0;
						let	str = "";
						str += '<table class="table table-hover text-center">';
						str += '<tr class="table-secondary"><th>번호</th><th>아이디</th><th>성명</th><th>나이</th><th>성별</th><th>주소</th></tr>';
						for(let j of js) {
							str += '<tr>';
							str += '<td>'+(++i)+'</td>';
							str += '<td>'+j.mid+'</td>';
							str += '<td>'+j.name+'</td>';
							str += '<td>'+j.age+'</td>';
							str += '<td>'+j.gender+'</td>';
							str += '<td>'+j.address+'</td>';
							str += '</tr>';
						}
						str += '';
						str += '<tr><td colspan="6" class="m-0 p-0"></td></tr>';
						str += '</table>';
						demo2.innerHTML = str;
				},
				error: function() {
					alert("전송실패");
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
  <h2>AJAX 값 전달 응용</h2>
  <form name="myform">
  	아이디: 
  	<input type="text" name="mid" id="mid" value="admin" class="form-control mb-2" />
  	<div>
  		<input type="button" value="아이디검색1" onclick="idCheck1()" class="btn btn-success" />
  		<input type="button" value="아이디검색2" onclick="idCheck2()" class="btn btn-primary" />
  		<input type="button" value="아이디검색3" onclick="idCheck3()" class="btn btn-secondary" />
  		<input type="button" value="아이디검색4" onclick="idCheck4()" class="btn btn-info" />
  		<input type="button" value="아이디검색5" onclick="idCheck5()" class="btn btn-dark" />
  	</div>
  	<hr/>
  		<div>
  			1.일반 값의 전달처리<br/>
  			2.vo를 편집하여(백엔드) 전달받아서 처리(프론트)<br/>
  			3.vo를 JSON 형식으로 변환시켜(백엔드) 전달받아서 처리(프론트)<br/>
  			4.vos형식의 자료로 만들어서 JSON 형식으로 변환시켜(백엔드) 전달받아서 처리(자바 오브젝트로 변환 프론트)<br/>
  			5.vos형식의 자료를 JSON 형식으로 변환시켜(백엔드) 전달받아서 처리(프론트)<br/>
  		</div>
  	<hr/>
  	<div id="demo"></div>
  	<hr/>
  	<div>
  		<div>아이디: <span id="imsiMid"></span></div>
  		<div>성명: <span id="imsiName"></span></div>
  		<div>나이: <span id="imsiAge"></span></div>
  		<div>성별: <span id="imsiGender"></span></div>
  		<div>주소: <span id="imsiAddress"></span></div>
  	</div>
  	<hr/>
  	<div id="demo2"></div>
  	<hr/>
  </form>
</div>
<p><br /></p>
<jsp:include page="/include/footer.jsp" />
</body>
</html>