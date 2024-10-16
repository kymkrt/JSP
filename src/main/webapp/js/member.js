//memnber.js

'use strict'

function logoutCheck(url) {
	alert("로그아웃 합니다 ");
	location.href = url;
}

function fCheck() {
	let name = document.getElementById("name").value;
	let age = document.getElementById("age").value;
	
	if(name.trim() == "") {
		alert("name을 입력하세요");
		document.getElementById("name").focus();
		return false;
	}
	else if(age.trim() == "") {
		alert("age를 입력하세요");
		document.getElementById("age").focus();
		return false;
	}
	else {
		myform.action = "<%=request.getContextPath()%>/hw1";
		myform.submit(); 
	}
}