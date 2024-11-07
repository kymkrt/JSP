<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>memberUpdate.jsp</title>
  <jsp:include page="/include/bs4.jsp" />
  <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  <script src="${ctp}/js/woo.js"></script>
  <script type="text/javascript">
  	'use strict'
  	
	  	let swNick = 0;
  	
/* 		 $(function(){
	  	let nickName = document.getElementById('myform').nickName.value;
  	});  */
  	
  	const regexNick = /^[a-zA-Z0-9가-힣]{2,20}$/; 
  	const regexName = /^[가-힣a-zA-Z0-9]{2,10}$/; 
  	const regexTel = /^[0-9]{2,3}\-{1}[0-9]{3,4}\-{1}[0-9]{3,4}$/; 
  	//const regexAddress = /^[0-9]{3,4}\-{1}[0-9]{3,4}$/; 
  	const regexEmail = /^[a-zA-Z0-9]{2,15}\@{1}[a-z]{2,10}\.{1}[a-z]{2,10}$/; 
  	
  	function fCheck() {
  	    
  		let nickName = myform.nickName.value;
  		
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
  		let address = myform.postcode.value+" /"+myform.address.value+" /"+myform.detailAddress.value+" /"+myform.extraAddress.value+" ";
  		/* 이렇게 해도됨
  		let tel2 = myform.tel2.value;
  		let tel3 = myform.tel3.value;
  		let email1 = myform.email1.value;
  		let email2 = myform.email2.value; */
  		
  		//유효성검사(정규식으로 처리) 프론트체크는 requierd부분에서 반드시 처리
  		
  		//alert(tel +" : "+email);
		if(swNick == 0) {
			alert("닉네임 중복을 확인해주세요");
			myform.nickName.focus();
			return false;
		} 
			else if(!regexNick.test(nickName.trim())) {
			alert("닉네임 형식을 확인해주세요");
			myform.nickName.focus();
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
			
			swNick = 0;
			
			let photo = document.getElementById("photo").value;
			let maxSize = 1024*1024*10; //저장파일의 최대용량을 10MByte까지로 제한 
			let ext = photo.substring(photo.lastIndexOf(".")+1).toLowerCase(); //.다음부터 찾아야 해서 +1
			
			if(photo.trim() == ""){
				alert("업로드할 파일을 선택하세요");
				return false;
			}
			//여러개가 올수 있기 때문에 배열로 봐야함  그래서 files, size 둘다 예약어임
			let fileSize = document.getElementById("file").files[0].size;
			if(fileSize > maxSize){
				alert("업로드할 파일의 최대용량은 10MB 입니다")
			}
			// 안되는거 목록이면 확장자가 너무 많아서 안된다  되는거로 생각해야됨
			else if(ext != 'jpg' && ext != 'png' && ext != 'gif' && ext != 'jpeg' && ext != 'bmp'){
				alert("업로드 가능한 파일은 'jpg/png/gif/jpeg/bmp'만 가능합니다");
			}
			else{
				myform.submit();
			}
		}
	}
  	
  	// 아이디 중복 체크
/*   		function idCheck(flag) {
			let nickName = myform.nickName.value;
			
			if(nickName.trim() == "" && flag==2) {
				alert("닉네임을 입력하세요");
				myform.nickName.focus();
			}else if(nickName.trim() != "" && flag==2 && regexNick.test(nickName.trim())) {
				let url = "MemberIdCheck.mem?nickName="+nickName;
				swNick = 1;
				window.open(url, "idCheckWindow", "width=400px, height=250px");
			}
		} */
			
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
			else if(nickName == '${sNickName}') {
				alert("현재 닉네임을 그대로 사용합니다");
				swNick = 1;
				return false;
			}
			
			swNick = 1;
			
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
  <form name="myform" id="myform" method="post" action="MemberUpdateOk.mem" onsubmit="return fCheck()" enctype="multipart/form-data">
	<table class="table table-bordered">
		<tr id="subject">
			<td class="text-center" colspan="7"><b>회원 정보 수정</b></td>
		</tr>
	  	<tr>
		  	<th class="text-center"><label for="mid" class="form-label">아이디</label></th>
		  	<td colspan="7">
		  		<div class="input-group">
			  		<input type="text" name="mid" id="mid" value="${sMid}" class="form-control" readonly />
			  		<div class="input-group-append ml-1">
			  			<input type="button" value="아이디중복체크" onclick="idCheck(1)" class="form-control btn-secondary" />
			  		</div>
		  		</div>
		  	</td>
	  	</tr>
	  	<tr class="mb-2">
		  	<th class="text-center"><label for="name" class="form-label">성명</label></th>
		  	<td colspan="7"><input type="text" name="name" id="name" value="${vo.name}" class="form-control" required /></td>
	  	</tr>
	  	<tr class="mb-2">
		  	<th class="text-center"><label for="nickName" class="form-label">닉네임</label></th>
	  		<td colspan="7">
	  			<div class="input-group">
	  				<input type="text" name="nickName" id="nickName" value="${vo.nickName}" class="form-control" required />
	  				<div class="input-group-append ml-1">
			  			<input type="button" value="닉네임중복체크" onclick="nickNameAjaxCheck()" class="form-control btn-secondary" />
			  		</div>
	  			</div>
	  		</td>
	  	</tr>
	  	<tr class="mb-2">
	  		<th class="text-center">성별</th>
			  	<td colspan="7" class="text-center">
				  	<input type="radio" name="gender" id="male" value="남자" <c:if test="${vo.gender == '남자'}">checked</c:if> /><label for="male" class="form-label mr-3">남자</label>
				  	<input type="radio" name="gender" id="female" value="여자" <c:if test="${vo.gender == '여자'}">checked</c:if> />	<label for="female" class="form-label">여자</label>
		  		</td>
	  	</tr>
	  	<tr class="mb-4">
	  		<th class="text-center"><label for="birthday" class="form-label">생일</label></th>
	  		<!--둘다 된다 이유는 모르겠음  -->
	  		<%-- <td colspan="7"><input type="date" name="birthday" id="birthday" value="${vo.birthday.substring(0, 10)}" class="form-control"></td> --%>
	  		<td colspan="7"><input type="date" name="birthday" id="birthday" value="${fn:substring(vo.birthday,0, 10)}" class="form-control"></td>
	  	</tr>
	  	<tr class="mb-2">
	  		<th class="text-center"><label for="tel1" class="form-label">전화번호</label></th>
	  		<td>
	  		<select class="form-control" id="tel1" name="tel1">
				  <!-- <option <c:if test="${tel1=='010'}">selected</c:if> >010</option> -->
				  <!--문자로 넣어야 한다   위하고 같음 -->
				  <option ${tel1=='010' ? 'selected' : ''}>010</option>
				  <option ${tel1=='02' ? 'selected' : ''} value="02">서울</option>
				  <option ${tel1=='041' ? 'selected' : ''} value="041">천안</option>
				  <option ${tel1=='042' ? 'selected' : ''} value="042">대전</option>
				  <option ${tel1=='043' ? 'selected' : ''} value="043">청주</option>
				  <option ${tel1=='031' ? 'selected' : ''} value="031">인천</option>
				</select>
				-<input type="text" class="" id="tel2" value="${tel2}" name="tel2" size="4" maxlength="4" />
				-<input type="text" class="" id="tel3" value="${tel3}" name="tel3" size="4" maxlength="4" />
			</td>
	  	</tr>
	  	<tr class="mb-2">
	  		<th class="text-center"><label for="address" class="form-label">주소</label></th>
	  		<td colspan="7">
	  			<div class="input-group mb-1">
	  			<!--readonly 에 onclick="sample6_execDaumPostcode()" 이렇게 넣어줄수 있음  -->
				  	<input type="text" name="postcode" id="sample6_postcode" value="${postcode}" onclick="sample6_execDaumPostcode()" placeholder="우편번호" class="form-control" readonly />
				  	<div class="input-group-append">
							<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br>
						</div>
					</div>
					<input type="text" name="address" id="sample6_address" value="${address}" placeholder="주소" class="form-control mb-1" readonly />
					<div class="input-group mb-1">
						<input type="text" name="detailAddress" id="sample6_detailAddress" value="${detailAddress}" placeholder="상세주소" class="form-control" />
						<div class="input-group-append">
							<input type="text" name="extraAddress" id="sample6_extraAddress" value="${extraAddress}" placeholder="참고항목" class="form-control" readonly />
						</div>
					</div>
	  		</td>
	  	</tr>
	  	<tr class="mb-2">
		    <th class="text-center">이메일</th>
		    <td colspan="3"><input type="text" name="email1" id="email1" value="${email1}" class="form-control" required /></td>
		    <td class="text-center"><b>@</b></td>
		    <td colspan="3">
		        <select class="form-control" id="email2" name="email2"  required >
		            <option ${email2 == 'naver.com' ? 'selected' : ''} value="naver.com">naver.com</option>
		            <option ${email2 == 'daum.net' ? 'selected' : ''} value="daum.net">daum.net</option>
		            <option ${email2 == 'gmail.com' ? 'selected' : ''} value="gmail.com">gmail.com</option>
		        </select>
		    </td>
		</tr>
	  	<tr class="mb-2">
		  	<th class="text-center"><label for="content" class="form-label">자기소개</label></th>
		  	<!--textarea는 value가 없고 내용에 넣어야 한다   -->
		  	<td colspan="7"><textarea cols="5" name="content" id="content" class="form-control">${vo.content}</textarea></td><!--엔터키가 없음?  -->
	  	</tr>
	  	<tr class="mb-2">
		  	<th class="text-center"><label for="photo" class="form-label">사진</label></th>
	  		<td colspan="7">
		  		<img src="${ctp }/images/member/${vo.photo}" width="100px" />
		  		<input type="file" name="photo" id="photo" class="form-control-file border" />
	  		</td>
	  	</tr>
	  	<tr class="mb-2">
		  	<th class="text-center"><label for="userInfor" class="form-label">정보공개</label></th>
		  	<td colspan="7" class="text-center">
		  		<input type="radio" name="userInfor" id="YES" value="공개" <c:if test="${vo.userInfo == '공개'}">checked</c:if> class="btn-check" /><label for="YES" class="form-label mr-3">공개</label>
		  		<input type="radio" name="userInfor" id="NO" value="비공개" <c:if test="${vo.userInfo == '비공개'}">checked</c:if> class="btn-check" /><label for="NO" class="form-label">비공개</label>
		  	</td>
	  	</tr>
  	</table>
  	<button type="submit" class="form-control btn btn-success mb-2">회원 정보 수정</button>
  	<button type="reset" class="form-control btn btn-warning mb-2">다시입력</button>
  	<%-- <button type="button" onclick="location.href='${ctp}/'" class="form-control btn btn-info mb-2">돌아가기</button> --%>
  	<!--히스토리백은 사용에 주의해야한다  -->
  	<!-- <button type="button" onclick="history.back()" class="form-control btn btn-info mb-2">돌아가기</button> -->
  	<button type="button" onclick="location.href='MemberMain.mem'" class="form-control btn btn-info mb-2">돌아가기</button>
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