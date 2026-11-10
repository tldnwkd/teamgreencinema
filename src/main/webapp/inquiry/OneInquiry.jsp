<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<section class="inquiry">
	<form action="OneInquiryProc.do" method="post" name="iform">
		<div class="page-content">
			<div class="container">
				<div class="page-heading">
					<p class="page-heading__eyebrow">CUSTOMER SERVICE</p>
					<h1 class="page-heading__title">1:1 문의</h1>
					<p class="page-heading__description">회원 전용 1:1 문의 작성 화면입니다.</p>
				</div>
				<nav class="cs-tabs" aria-label="고객센터 메뉴">
					<a href="NoticeProc.do">공지사항</a>
					<a href="FaqProc.do">FAQ</a>
					<a href="InquiryProc.do" aria-current="page">1:1 문의</a>
				</nav>

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
							<p class="form-label">문의 제목</p>
							<p>${idto.inquiryTitle }</p>
						</div>
						<div class="form-group form-group--full">
							<p class="form-label">문의 내용</p>
							<textarea id="inqText" class="form-control" name="inquiryContent" readonly>${idto.inquiryContent}</textarea>
						</div>
						<c:if test="${idto.answerStatus eq 1}">
							<div class="form-group form-group--full">
								<p class="form-label">답변 내용</p>
								<textarea id="answerText" class="form-control" name="answerContent" readonly>${idto.answerContent}</textarea>
							</div>
						</c:if>
						<div class="form-group form-group--full">
							<p class="form-label">답변 수신 방법</p>
							<c:if test="${idto.receptionType eq 1}"><p>Email</p></c:if>
							<c:if test="${idto.receptionType eq 2}"><p>SMS</p></c:if>
						</div>
					</div>
					<div class="form-actions">
						<input type="hidden" name="id" value="${sessionScope.id }">
						<input type="hidden" name="inquiryId" value="${idto.inquiryId}">
						<input type="hidden" name="inquirySort" value="${idto.inquirySort}">
						<input type="hidden" name="inquiryType" value="${idto.inquiryType}">
						<input type="hidden" name="inquiryTitle" value="${idto.inquiryTitle}">
						<input type="hidden" name="inquiryContent" value="${idto.inquiryContent}">
						<input type="hidden" name="receptionType" value="${idto.receptionType}">
						<a href="InquiryProc.do" class="btn btn--outline">내 문의내역보기</a>
						<c:if test="${idto.answerStatus eq 0}">
							<button type="submit" class="btn btn--primary" name="btn" value="upd">수정</button>
						</c:if>
							<button type="submit" class="btn btn--primary" name="btn" onclick="return confirm('정말 삭제하시겠습니까?');" value="del">삭제</button>
					</div>
				</section>
			</div>
		</div>
	</form>
</section>
