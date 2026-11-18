<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<section class="inquiry-form">
	<form action="MyPageProc.do" method="post" name="iform">
		<div class="form-grid">
			<div class="form-group">
				<p class="form-label">문의 분류</p>
				<p>${idto.inquirySort}</p>
			</div>
			<div class="form-group">
				<p class="form-label">문의 종류</p>
				<p>${idto.inquiryType}</p>
			</div>
			<div class="form-group form-group--full">
				<label class="form-label" for="inqTitle">문의 제목</label>
				<input class="form-control" id="inqTitle" name="inquiryTitle" maxlength="30" value="${idto.inquiryTitle}">
			</div>
			<div class="form-group form-group--full">
				<label class="form-label" for="inqText">문의 내용</label>
				<textarea id="inqText" class="form-control" name="inquiryContent">${idto.inquiryContent}</textarea>
			</div>
			<div class="form-group form-group--full">
				<p class="form-label">답변 수신 방법</p>
				<c:if test="${idto.receptionType eq 1}"><p>Email</p></c:if>
				<c:if test="${idto.receptionType eq 2}"><p>SMS</p></c:if>
			</div>
		</div>
		<div class="form-actions">
			<input type="hidden" name="userId" value="${sessionScope.id}">
			<input type="hidden" name="menu" value="inquiry-one">
			<input type="hidden" name="inquiryId" value="${idto.inquiryId}">
			<button type="submit" class="btn btn--primary" name="btn" value="myupdOk" onclick="return confirm('수정을 완료하시겠습니까?');">수정</button>
		</div>
	</form>
</section>
