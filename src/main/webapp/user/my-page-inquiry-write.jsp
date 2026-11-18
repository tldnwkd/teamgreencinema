<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<section class="inquiry-form">
	<form action="MyPageProc.do" method="post" name="iform">
		<input type="hidden" name="btn" value="myinq">
		<input type="hidden" name="userId" value="${sessionScope.id}">
		<input type="hidden" name="menu" value="inquiry-write">
		<div class="form-grid">
			<div class="form-group">
				<label for="inqSort" class="form-label">문의 분류</label>
				<select id="inqSort" name="inquirySort" class="form-control">
					<option selected>선택</option>
					<option value="영화관">영화관</option>
					<option value="회원정보">회원정보</option>
					<option value="예매/결제">예매/결제</option>
					<option value="이벤트">이벤트</option>
				</select>
			</div>
			<div class="form-group">
				<label for="inqType" class="form-label">문의 종류</label>
				<select id="inqType" name="inquiryType" class="form-control">
					<option selected>선택</option>
					<option value="문의">문의</option>
					<option value="칭찬">칭찬</option>
					<option value="불만">불만</option>
					<option value="건의">건의</option>
				</select>
			</div>
			<div class="form-group form-group--full">
				<label class="form-label" for="inqTitle">문의 제목</label>
				<input class="form-control" id="inqTitle" name="inquiryTitle" maxlength="30" placeholder="제목을 입력하세요">
			</div>
			<div class="form-group form-group--full">
				<label class="form-label" for="inqText">문의 내용</label>
				<textarea id="inqText" class="form-control" name="inquiryContent" placeholder="문의 내용을 입력하세요"></textarea>
			</div>
			<div class="form-group form-group--full">
				<label class="form-label" for="inqReception">답변 수신 방법</label>
				<select id="inqReception" name="receptionType" class="form-control">
					<option selected>선택</option>
					<option value="1">Email</option>
					<option value="2">SMS</option>
				</select>
			</div>
		</div>
		<div class="form-actions">
			<input type="button" class="btn btn--primary" value="문의" onclick="chk()">
		</div>
	</form>
	<script type="text/javascript">
		function chk(){
			let f = document.iform;

			if(f.inquirySort.value == "선택"){
				alert("문의 분류를 입력해주세요");
				f.inquirySort.focus();
				return;
			}
			if(f.inquiryType.value == "선택"){
				alert("문의 종류를 입력해주세요");
				f.inquiryType.focus();
				return;
			}
			if(f.inquiryTitle.value == ""){
				alert("제목을 선택해주세요");
				f.inquiryTitle.focus();
				return;
			}
			if(f.inquiryContent.value == ""){
				alert("내용을 선택해주세요");
				f.inquiryContent.focus();
				return;
			}
			if(f.receptionType.value == "선택"){
				alert("수신 방법을 선택해주세요");
				f.receptionType.focus();
				return;
			}
			if(confirm("1:1문의를 신청하시겠습니까?")){
				f.submit();
			}
		}
	</script>
</section>
