<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<section class="inquiry">
	<form action="InquiryInsertProc.do" method="post" name="iform">
		<div class="page-content">
			<div class="container">
				<div class="page-heading">
					<p class="page-heading__eyebrow">CUSTOMER SERVICE</p>
					<h1 class="page-heading__title">1:1 문의</h1>
					<p class="page-heading__description">회원 전용 1:1 문의 작성 화면입니다.</p>
				</div>

				<section class="inquiry-form">
					<div class="form-grid">
						<div class="form-group">
							<p class="form-label">문의 분류</p>
							<p>${idto.inquirySort }</p>
						</div>
						<div class="form-group">
							<p class="form-label">문의 종류</p>
							<p>${idto.inquiryType }</p>
						</div>
						<div class="form-group form-group--full">
							<label class="form-label" for="inqTitle">문의 제목</label>
							<input class="form-control" id="inqTitle" name="inquiryTitle" value="${idto.inquiryTitle}" readonly>
						</div>
						<div class="form-group form-group--full">
							<label class="form-label" for="inqText">문의 내용</label>
							<textarea id="inqText" class="form-control" name="inquiryContent" readonly>${idto.inquiryContent}</textarea>
						</div>
						<div class="form-group form-group--full">
							<p class="form-label">답변 수신 방법</p>
							<c:if test="${idto.receptionType eq 1}"><p>Email</p></c:if>
							<c:if test="${idto.receptionType eq 2}"><p>SMS</p></c:if>
						</div>
						<div class="form-group form-group--full">
								<p class="form-label">답변 내용</p>
								<textarea id="answerText" class="form-control" name="answerContent" ${idto.answerStatus==1?'readonly':''}>${idto.answerContent}</textarea>
							</div>
					</div>
					<div class="form-actions">
						<input type="hidden" name="id" value="${sessionScope.id }">
						<input type="hidden" name="inquiryId" value="${idto.inquiryId}">
						<a href="InquiryProc.do" class="btn btn--outline">전체 문의내역보기</a>
						<button name="btn" type="submit" class="btn btn--primary" value="updOk" onclick="return confirm('답변을 완료하시겠습니까?');" >답변</button>
					</div>
				</section>
			</div>
		</div>
	</form>
</section>
