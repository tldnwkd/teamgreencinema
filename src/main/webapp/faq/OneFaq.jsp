<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<section class="inquiry">
	<div class="page-content">
		<div class="container">
			<div class="page-heading">
				<p class="page-heading__eyebrow">CUSTOMER SERVICE</p>
				<h1 class="page-heading__title">FAQ</h1>
			</div>
			<nav class="cs-tabs" aria-label="고객센터 메뉴">
				<a href="NoticeProc.do">공지사항</a>
				<a href="FaqProc.do" aria-current="page">FAQ</a>
				<a href="InquiryProc.do">1:1 문의</a>
			</nav>

			<section class="inquiry-form">
				<div class="form-grid">
					<div class="form-group">
						<p class="form-label">문의 분류</p>
						<p>${fOneList.faqType }</p>
					</div>
					<div class="form-group form-group--full">
						<p class="form-label">문의 제목</p>
						<p>${fOneList.faqInquery}</p>
					</div>
					<div class="form-group form-group--full">
						<p class="form-label">답변 내용</p>
						<textarea id="inqText" class="form-control" name="faqAnswer" readonly>${fOneList.faqAnswer}</textarea>
					</div>
				</div>
				<div class="form-actions">
					<a href="FaqProc.do" class="btn btn--outline">FAQ 목록보기</a>
				</div>
			</section>
		</div>
	</div>
</section>
