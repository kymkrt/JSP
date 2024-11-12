<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>scheduleMenu.jsp</title>
  <jsp:include page="/include/bs4.jsp" />
  <script type="text/javascript">
  	'use strict';
  	
  	//동적폼 처리
  	
  	$(function() {
  		$("#scheduleInputClose").hide();
		});
  	
  	function scheduleInputView() {
			let str = '<div id="scheduleInputForm">';
			str += '<form name="scheduleInputViewForm">';
			str += '<table class="table table-bordered">';
			str += '<tr>';
			str += '<th>일정분류</th><td>';
			str += '<select name="part" class="form-control">';
			str += '<option>모임</option>';
			str += '<option>업무</option>';
			str += '<option>학습</option>';
			str += '<option>여행</option>';
			str += '<option>기타</option>';
			str += '</select>';
			str += '</td></tr>';
			str += '<tr><th>내역</th><td>';
			str += '<textarea name="content" rows="4" class="form-control"></textarea>';
			str += '</td></tr>';
			str += '<tr><td colspan="2" class="text-center">';
			str += '<input type="button" value="일정등록" onclick="scheduleInputOk()" class="btn btn-success form-control" />';
			str += '</td></tr>';
			str += '</table>';
			str += '</form>';
			str += '</div>';
			
			$("#scheduleInputView").hide();
			$("#scheduleInputClose").show();
			$("#demo").html(str);
		}
  	
  	function scheduleInputClose() {
  	
	  	$("#scheduleInputView").show();
			$("#scheduleInputClose").hide();
			$("#scheduleInputViewForm").hide();
		}
  	
  	//일정등록하기
  	function scheduleInputOk() {
  		let part = scheduleInputViewForm.part.value;
  		let content = scheduleInputViewForm.content.value;
  		if(content.trim() == ""){
  			alert('일정을 등록하세요');
  			scheduleForm.content.focus();
  			return false;
  		}
  		let query = {
  				mid : '${sMid}',
  				sDate : '${ymd}',
  				part  : part, 
  				content : content
  		}
  		
			$.ajax({
				type: 'post',
				url : 'ScheduleInputOk.sc',
				data : query,
				success: function(res) {
					if(res != "0"){
						alert("일정이 등록되었습니다");
						location.reload();
					}
					else alert("등록실패");
				},
				error: function() {
					alert("전송오류");
				}
			});
		}
  	
  	//일정 폼보기
  	function scheduleUpdateView(idx, part, content) {
			$("#myModal #idx").val(idx);
			$("#myModal #part").val(part);
			$("#myModal #content").val(content);
		}
  	
  	//일정 수정하기
  	function scheduleUpdateOk() {
			let query = {
					idx : $("#myModal #idx").val(),
					part : $("#myModal #part").val(),
					content : $("#myModal #content").val()
			}
			
			$.ajax({
				type: "post",
				url: "ScheduleUpdateOk.sc",
				data: query,
				success: function(res) {
					if(res != "0"){
						alert("일정수정 완료");
						location.reload();
					}
					else{
						alert("수정실패");
					}
				},
				error: function() {
					alert("전송실패");
				}
			});
		}
  	
  	//일정삭제
  	function scheduleDeleteCheck(idx) {
			
  		$.ajax({
  			type: "get",
  			url: "ScheduleDeleteOk.sc",
  			data: {
  				idx: idx
  			},
  			success: function (res) {
					if(res != "0"){
						alert("일정 삭제 성공");
						location.reload();
					}					
					else{
						alert("일정 삭제 실패");
					}
				},
				error: function() {
					alert("일정 삭제 전송 실패");
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
  <h4>${ymd}의 일정입니다</h4>
  <p>오늘의 일정은 총${scheduleCnt}건이 있습니다</p>
  <hr/>
  <div>
  	<input type="button" value="일정등록" onclick="scheduleInputView()" id="scheduleInputView" class="btn btn-success mb-2" />
  	<input type="button" value="일정닫기" onclick="scheduleInputClose()" id="scheduleInputClose" class="btn btn-info mb-2" />
  	<c:set var="ymds" value="${fn:split(ymd, '-')}" />
		<input type="button" value="돌아가기" onclick="location.href='Schedule.sc?yy=${ymds[0]}&mm=${ymds[1]-1}'" class="btn btn-warning mb-2" />
	</div>
	<div id="demo"></div>
  <hr/>
  <c:if test="${scheduleCnt != 0}">
  	<table class="table table-hover text-center">
  		<tr class="table-secondary">
  			<th>번호</th>
  			<th>분류</th>
  			<th>내역</th>
  			<th>비고</th>
  		</tr>
  		<c:forEach var="vo" items="${vos}" varStatus="st">
	  		<tr>	
	  			<td>${st.count}</td>
	  			<td>${vo.part}</td>
	  			<td>${fn:replace(vo.content, newLine, '<br/>')}</td>
	  			<td>
	  				<!--한쪽이 문자면 다 문자로 보내야함? -->
	  				<input type="button" value="수정" onclick="scheduleUpdateView('${vo.idx}','${vo.part}','${fn:replace(vo.content, newLine, '<br/>')}')" data-toggle="modal" data-target="#myModal" class="btn btn-primary btn-sm" />
	  				<!--idx가 숫자라 '' 안씀  -->
	  				<input type="button" value="삭제" onclick="scheduleDeleteCheck(${vo.idx})" class="btn btn-danger btn-sm" />
	  			</td>
	  		</tr>
  		</c:forEach>
  		<tr><td colspan="4" class="m-0 p-0"></td></tr>
  	</table>
  </c:if>
</div>

<!-- 댓글달기를 위한 모달처리 -->
<div class="modal fade" id="myModal" style="font-size:0.9em;">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h4 class="modal-title">>> ${ymd}</h4>
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>
      <div class="modal-body">
        <form name="scheduleForm" id="scheduleForm">
          <table class="table table-bordered">
            <tr>
              <th style="width:25%">분류</th>
              <td style="width:75%">
              	<select name="part" id="part" class="form-control">
              		<option>모임</option>
									<option>업무</option>
									<option>학습</option>
									<option>여행</option>
									<option>기타</option>
              	</select>
              </td>
            </tr>
            <tr>
              <th>내용</th>
              <td><textarea name="content" id="content" class="form-control"></textarea></td>
            </tr>
          </table>
          <hr/>
          <input type="button" value="일정수정" onclick="scheduleUpdateOk()" class="btn btn-success form-control"/>
          <input type="hidden" name="idx" id="idx" />
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>

<p><br /></p>
<jsp:include page="/include/footer.jsp" />
</body>
</html>