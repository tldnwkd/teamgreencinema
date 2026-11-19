<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<section class="admin-board">
	<div class="admin-panel">
		<form class="admin-form" action="InquiryInsertProc.do" method="post" name="iform" id="iform">
			<div class="admin-form__row">
				<label for="inquirySort">문의 분류</label>
				<input id="inquirySort" type="text" value="${idto.inquirySort}" readonly>
			</div>
			<div class="admin-form__row">
				<label for="inquiryType">문의 종류</label>
				<input id="inquiryType" type="text" value="${idto.inquiryType}" readonly>
			</div>
			<div class="admin-form__row">
				<label for="inqTitle">문의 제목</label>
				<input id="inqTitle" name="inquiryTitle" type="text" value="${idto.inquiryTitle}" readonly>
			</div>
			<div class="admin-form__row">
				<label for="inqText">문의 내용</label>
				<textarea id="inqText" name="inquiryContent" rows="5" readonly>${idto.inquiryContent}</textarea>
			</div>
			<div class="admin-form__row">
				<label for="receptionType">답변 수신 방법</label>
				<input id="receptionType" type="text" value="${idto.receptionType eq 1 ? 'Email' : 'SMS'}" readonly>
			</div>
			<div class="admin-form__row">
				<label for="before">답변 내용</label>
				<input type="hidden" id="after" value="${idto.answerContent}">
				<textarea id="before" name="answerContent" rows="5">${idto.answerContent}</textarea>
			</div>
			<div class="admin-form__actions">
				<input type="hidden" name="id" value="${sessionScope.id}">
				<input type="hidden" name="inquiryId" value="${idto.inquiryId}">
				<a href="InquiryProc.do">목록</a>
				<c:choose>
					<c:when test="${idto.answerStatus==0}">
						<button name="btn" type="button" value="upd" onclick="ans()">답변</button>
					</c:when>
					<c:otherwise>
						<button name="btn" type="button" value="upd" onclick="upd()">수정</button>
					</c:otherwise>
				</c:choose>
			</div>
		</form>
	</div>
</section>
<script>
	function ans(){
		let i = document.iform;

		if(i.answerContent.value==""){
			alert('답변을 입력해주세요');
			i.answerContent.focus();
			return;
		}
		if(confirm('답변을 완료하시겠습니까?')){
			i.submit();
		}
	}
	
	function upd(){
		let i = document.iform;
		let after = document.getElementById("after").value;
		let before = document.getElementById("before").value;

		if(after == before){
			alert('수정된 값이 없습니다.');
			i.answerContent.focus();
			return;
		}
		if(confirm('수정을 완료하시겠습니까?')){
			i.submit();
		}
	}
</script>
