<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<section class="inquiry-form">
	<form action="MyPageProc.do" method="post" name="iform">
		<div class="form-grid">
			<div class="form-group">
				<p class="form-label">문의 회원</p>
				<p>${idto.userId}</p>
			</div>
			<div class="form-group">
				<p class="form-label">문의 분류</p>
				<p>${idto.inquirySort}</p>
			</div>
			<div class="form-group">
				<p class="form-label">문의 종류</p>
				<p>${idto.inquiryType}</p>
			</div>
			<div class="form-group form-group--full">
				<p class="form-label">문의 제목</p>
				<p>${idto.inquiryTitle}</p>
			</div>
			<div class="form-group form-group--full">
				<p class="form-label">문의 내용</p>
				<textarea class="form-control" readonly>${idto.inquiryContent}</textarea>
			</div>
			<c:if test="${idto.answerStatus eq 1}">
				<div class="form-group form-group--full">
					<p class="form-label">답변 내용</p>
					<textarea class="form-control" readonly>${idto.answerContent}</textarea>
				</div>
			</c:if>
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
			<c:if test="${idto.answerStatus eq 0}">
				<a class="btn btn--outline" href="MyPageProc.do?userId=${sessionScope.id}&amp;menu=inquiry-edit&amp;inquiryId=${idto.inquiryId}">수정</a>
			</c:if>
			<button type="submit" class="btn btn--primary" name="btn" value="mydel" onclick="return confirm('정말 삭제하시겠습니까?');">삭제</button>
		</div>
	</form>
</section>
