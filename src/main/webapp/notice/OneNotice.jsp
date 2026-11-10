<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<section class="inquiry">
	<div class="page-content">
		<div class="container">
			<div class="page-heading">
				<p class="page-heading__eyebrow">CUSTOMER SERVICE</p>
				<h1 class="page-heading__title">공지사항</h1>
			</div>
			<nav class="cs-tabs" aria-label="고객센터 메뉴">
				<a href="NoticeProc.do" aria-current="page">공지사항</a>
				<a href="FaqProc.do">FAQ</a>
				<a href="InquiryProc.do">1:1 문의</a>
			</nav>

			<section class="inquiry-form">
				<div class="form-grid">
					<div class="form-group">
						<p class="form-label">제목</p>
						<p>${nOneList.noticeTitle }</p>
					</div>
					<div class="form-group">
						<p class="form-label">게시일</p>
						<p>${nOneList.noticeDate }</p>
					</div>
					<div class="form-group form-group--full">
						<p class="form-label">조회수</p>
						<p>${nOneList.noticeHits}</p>
					</div>
					<div class="form-group form-group--full">
						<p class="form-label">공지사항 내용</p>
						<textarea id="inqText" class="form-control" name="faqAnswer" readonly>${nOneList.noticeText}</textarea>
					</div>
				</div>
				<div class="form-actions">
					<a href="NoticeProc.do" class="btn btn--outline">공지 목록보기</a>
				</div>
			</section>
		</div>
	</div>
</section>
