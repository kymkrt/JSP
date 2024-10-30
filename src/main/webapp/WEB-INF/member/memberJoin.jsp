<%@	page import="java.time.LocalDate"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
	String today = LocalDate.now().toString(); //열거형이라 생성하는게 아님
	pageContext.setAttribute("today", today);
%>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>memberjoin.jsp</title>
  <jsp:include page="/include/bs4.jsp" />
  <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  <script src="${ctp}/js/woo.js"></script>
  <script type="text/javascript">
  	'use strict'
  	
  	let swId = 0;
  	let swNick = 0;
  	
  	const regexId = /^[a-zA-Z0-9]{2,20}$/; 
  	const regexNick = /^[a-zA-Z0-9가-힣]{2,20}$/; 
  	const regexName = /^[가-힣a-zA-Z0-9]{2,10}$/; 
  	const regexPwd = /^[a-zA-Z0-9\!\@\#\$\%\&\*]{2,20}$/; 
  	const regexTel = /^[0-9]{2,3}\-{1}[0-9]{3,4}\-{1}[0-9]{3,4}$/; 
  	//const regexAddress = /^[0-9]{3,4}\-{1}[0-9]{3,4}$/; 
  	const regexEmail = /^[a-zA-Z0-9]{2,15}\@{1}[a-z]{2,10}\.{1}[a-z]{2,10}$/; 
  	
  	function fCheck() {
  	    let mid = myform.mid.value;
  	    let nickName = myform.nickName.value;
  	    let pwd = myform.pwd.value;
  	    
  		let tel2 = myform.tel2.value.trim();
  		let tel3 = myform.tel3.value.trim();
  		if(tel2 == "") tel2 = " ";
  		if(tel3 == "") tel3 = " ";
  		/*이렇게 공백하고 -를 넣어줘야 널포인트익셉션이 안남 //는 여러개가 있어도 1개로 치기 때문에 여기 주소는 4개가 되어야 하는데 0////1 2개로만 보고 2번째에 넣을곳이 null이 된다  */
  		//위에 /하고 똑같다 단 이렇게 하면꺼낼때 공백이 보이기 때문에 trim 같은걸로 처리해줘야 한다 
  		//위의 if덕분에 공백추가됨
  		let tel = myform.tel1.value+"-"+tel2+"-"+tel3;
  		
  		let email = myform.email1.value+"@"+myform.email2.value;
  		/*이렇게 공백하고 /를 넣어줘야 널포인트익셉션이 안남 //는 여러개가 있어도 1개로 치기 때문에 여기 주소는 4개가 되어야 하는데 0////1 2개로만 보고 2번째에 넣을곳이 null이 된다  */
  		let address = myform.postcode.value+" /"+myform.address.value+" /"+myform.detailAddress.value+" /"+myform.extraAddress.value;
  		/* 이렇게 해도됨
  		let tel2 = myform.tel2.value;
  		let tel3 = myform.tel3.value;
  		let email1 = myform.email1.value;
  		let email2 = myform.email2.value; */
  		
  		//유효성검사(정규식으로 처리) 프론트체크는 requierd부분에서 반드시 처리
  		
  		//alert(tel +" : "+email);
		if(swId == 0){
			alert("아이디 중복을 확인해주세요");
			myform.mid.focus();
			return false;
		} else if(swNick == 0) {
			alert("닉네임 중복을 확인해주세요");
			myform.nickName.focus();
			return false;
		} else if(!regexId.test(mid.trim())) {
			alert("아이디 형식을 확인해주세요");
			myform.mid.focus();
			return false;
		} else if(!regexNick.test(nickName.trim())) {
			alert("닉네임 형식을 확인해주세요");
			myform.nickName.focus();
			return false;
		} else if(!regexPwd.test(pwd.trim())){
			alert("비밀번호 형식을 확인해주세요\\n 가능한 특수문자는 ! @ # $ % & * 뿐입니다");
			myform.pwd.focus();
			return false;
		} else if(!regexTel.test(tel.trim())){
			alert("전화번호 형식을 확인해주세요");
			myform.tel2.focus();
			return false;
		} else if(!regexEmail.test(email.trim())){
			alert("이메일 형식을 확인해주세요");
			myform.email1.focus();
			return false;
		}else {
			myform.tel.value = tel;
			myform.email.value = email;
			myform.address2.value = address;
			
			swId = 0;
			swNick = 0;
			
			myform.submit();
		}
	}
  	
  	// 아이디 중복 체크
  		function idCheck(flag) {
			let mid = myform.mid.value;
			let nickName = myform.nickName.value;
			
			if(mid.trim() == "" && flag==1) {
				alert("아이디를 입력하세요");
				myform.mid.focus();
			}else if(mid.trim() != "" && flag==1 && regexId.test(mid.trim())) {
				let url = "MemberIdCheck.mem?mid="+mid;
				swId = 1;
				window.open(url, "idCheckWindow", "width=400px, height=250px");
			}
			
			if(nickName.trim() == "" && flag==2) {
				alert("닉네임을 입력하세요");
				myform.nickName.focus();
			}else if(nickName.trim() != "" && flag==2 && regexNick.test(nickName.trim())) {
				let url = "MemberIdCheck.mem?nickName="+nickName;
				swNick = 1;
				window.open(url, "idCheckWindow", "width=400px, height=250px");
			}
		}
			
  	// 닉네임 중복 체크
  	/* function nickNameCheck() {
			let nickName = myform.nickName.value;
			
			if(nickName.trim() == "") {
				alert("닉네임을 입력하세요");
				myform.nickName.focus();
			}
			else {
				let url = "MemberNickNameCheck.mem?nickName="+nickName;
				window.open(url, "ncikNameCheckWindow", "width=400px, height=250px");
				
			}
		} */
		
		//닉네임 중복체크 (AJax처리)
		function nickNameAjaxCheck() {
			let nickName  = myform.nickName.value;
			if(!regexNick.test(nickName)){
				alert("닉네임은 2자리 이상 한글만 가능합니다");
				myform.nickName.focus();
				return false;
			}
			$.ajax({
				type : "get", //여기get은 restAPI 개념이라 URL에 데이터 붙어가는거랑은 다르다
				url : "NickNameAjaxCheck.mem",
				//			변수명				자바스크립트변수
				data : {nickName : nickName}, //제이슨 처리 할때는 키에 "" 꼭 붙여야한다 지금은 안붙여도 처리됨
				success:function(res){
					if(res != "0") alert("닉네임이 중복되었습니다.\n 다른 닉네임을 사용하세요");
					else alert("사용하실수 있는 닉네임입니다\n 계속 작성해주세요")
				},//명령어 이어질때는 무조건 , 
				error : function() {
					alert("전송오류");
				}
			});
		}
  </script>
  <style type="text/css">
  	th {
			width: 150px; 
			background-color: #eee;	
			padding: 10px;
  	}
  	
  	#subject {
			background-color: #eee;	
  	}
  </style>
</head>
<body>
<jsp:include page="/include/header.jsp" />
<jsp:include page="/include/nav.jsp" />
<p><br /></p>
<div class="container">
  <form name="myform" id="myform" method="post" action="MemberJoinOk.mem" onsubmit="return fCheck()">
	<table class="table table-bordered">
		<tr id="subject">
			<td class="text-center" colspan="7"><b>회원가입</b></td>
		</tr>
	  	<tr>
		  	<th class="text-center"><label for="mid" class="form-label">아이디</label></th>
		  	<td colspan="7">
		  		<div class="input-group">
			  		<input type="text" name="mid" id="mid" placeholder="아이디를 입력하세요" class="form-control" autofocus required />
			  		<div class="input-group-append ml-1">
			  			<input type="button" value="아이디중복체크" onclick="idCheck(1)" class="form-control btn-secondary" />
			  		</div>
		  		</div>
		  	</td>
	  	</tr>
	  	<tr>
		  	<th class="text-center"><label for="pwd" class="form-label">비밀번호</label></th>
		  	<td colspan="7"><input type="password" name="pwd" id="pwd" placeholder="비밀번호를 입력하세요" class="form-control" required /></td>
	  	</tr>
	  	<tr class="mb-2">
		  	<th class="text-center"><label for="name" class="form-label">성명</label></th>
		  	<td colspan="7"><input type="text" name="name" id="name" placeholder="성명을 입력하세요" class="form-control" required /></td>
	  	</tr>
	  	<tr class="mb-2">
		  	<th class="text-center"><label for="nickName" class="form-label">닉네임</label></th>
	  		<td colspan="7">
	  			<div class="input-group">
	  				<input type="text" name="nickName" id="nickName" placeholder="닉네임을 입력하세요" class="form-control" required />
	  				<div class="input-group-append ml-1">
			  			<!-- <input type="button" value="닉네임중복체크" onclick="idCheck(2)" class="form-control btn-secondary" /> -->
			  			<input type="button" value="닉네임중복체크" onclick="nickNameAjaxCheck()" class="form-control btn-secondary" />
			  		</div>
	  			</div>
	  		</td>
	  	</tr>
	  	<tr class="mb-2">
	  		<th class="text-center">성별</th>
			  	<td colspan="7" class="text-center">
				  	<input type="radio" name="gender" id="male" value="남자" checked /><label for="male" class="form-label mr-3">남자</label>
				  	<input type="radio" name="gender" id="female" value="여자" />	<label for="female" class="form-label">여자</label>
		  		</td>
	  	</tr>
	  	<tr class="mb-4">
	  		<th class="text-center"><label for="birthday" class="form-label">생일</label></th>
	  		<td colspan="7"><input type="date" name="birthday" id="birthday" value="${today}" class="form-control"></td>
	  	</tr>
	  	<tr class="mb-2">
	  		<th class="text-center"><label for="tel1" class="form-label">전화번호</label></th>
	  		<td>
	  		<select class="form-control" id="tel1" name="tel1">
				  <option>010</option>
				  <!--이런식으로 해도된다  -->
				  <option value="02">서울</option>
				  <option value="041">천안</option>
				  <option value="042">대전</option>
				  <option value="043">청주</option>
				  <option value="031">인천</option>
				</select>
				-<input type="text" class="" id="tel2" name="tel2" size="4" maxlength="4" />
				-<input type="text" class="" id="tel3" name="tel3" size="4" maxlength="4" />
			</td>
	  	</tr>
	  	<tr class="mb-2">
	  		<th class="text-center"><label for="address" class="form-label">주소</label></th>
	  		<td colspan="7">
	  			<div class="input-group mb-1">
	  			<!--readonly 에 onclick="sample6_execDaumPostcode()" 이렇게 넣어줄수 있음  -->
				  	<input type="text" name="postcode" id="sample6_postcode" onclick="sample6_execDaumPostcode()" placeholder="우편번호" class="form-control" readonly />
				  	<div class="input-group-append">
							<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br>
						</div>
					</div>
					<input type="text" name="address" id="sample6_address" placeholder="주소" class="form-control mb-1" readonly />
					<div class="input-group mb-1">
						<input type="text" name="detailAddress" id="sample6_detailAddress" placeholder="상세주소" class="form-control" />
						<div class="input-group-append">
							<input type="text" name="extraAddress" id="sample6_extraAddress" placeholder="참고항목" class="form-control" readonly />
						</div>
					</div>
	  		</td>
	  	</tr>
	  	<tr class="mb-2">
		    <th class="text-center">이메일</th>
		    <td colspan="3"><input type="text" name="email1" id="email1" class="form-control" required /></td>
		    <td class="text-center"><b>@</b></td>
		    <td colspan="3">
		        <select class="form-control" id="email2" name="email2" required >
		            <option value="naver.com">naver.com</option>
		            <option value="daum.net">daum.net</option>
		            <option value="gmail.com">gmail.com</option>
		        </select>
		    </td>
		</tr>
	  	<tr class="mb-2">
		  	<th class="text-center"><label for="content" class="form-label">자기소개</label></th>
		  	<td colspan="7"><textarea cols="5" name="content" id="content" class="form-control"></textarea></td>
	  	</tr>
	  	<tr class="mb-2">
		  	<th class="text-center"><label for="photo" class="form-label">사진</label></th>
	  		<td colspan="7"><input type="file" name="photo" id="photo" class="form-control-file border" /></td>
	  	</tr>
	  	<tr class="mb-2">
		  	<th class="text-center"><label for="userInfor" class="form-label">정보공개</label></th>
		  	<td colspan="7" class="text-center">
		  		<input type="radio" name="userInfor" id="YES" value="공개" class="btn-check" checked /><label for="YES" class="form-label mr-3">공개</label>
		  		<input type="radio" name="userInfor" id="NO" value="비공개" class="btn-check" /><label for="NO" class="form-label">비공개</label>
		  	</td>
	  	</tr>
  	</table>
  	<button type="submit" class="form-control btn btn-success mb-2">제출</button>
  	<button type="reset" class="form-control btn btn-warning mb-2">다시입력</button>
  	<%-- <button type="button" onclick="location.href='${ctp}/'" class="form-control btn btn-info mb-2">돌아가기</button> --%>
  	<!--히스토리백은 사용에 주의해야한다  -->
  	<button type="button" onclick="history.back()" class="form-control btn btn-info mb-2">돌아가기</button>
  	<input type="hidden" name="tel" id="tel" />
  	<input type="hidden" name="email" id="email" />
  	<input type="hidden" name="address2" id="address2" />
  </form>
  <div name="demo" id="demo">
  </div>
</div>
<p><br /></p>
<jsp:include page="/include/footer.jsp" />
</body>
</html>