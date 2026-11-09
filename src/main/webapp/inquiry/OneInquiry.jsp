<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<!doctype html>
	<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="그린시네마 포트폴리오 웹사이트 JSP/CSS 시안">
<meta name="theme-color" content="#11151a">
<title>1:1 문의 | 그린시네마</title>
<link rel="stylesheet" href="css/inquiry.css">
</head>
<body>
	<section class="inquiry"> 
		<form action="OneInquiryProc.do" method="post" name="iform">
		<a class="skip-link" href="#main">본문으로 건너뛰기</a>
		<main id="main">
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
								<p>문의 제목</p>
								<p>${idto.inquiryTitle }</p>
							</div>
							<div class="form-group form-group--full">
								<p>문의 내용</p>
								<textarea id="inqText" class="form-control" name="inquiryContent" readonly>${idto.inquiryContent}</textarea>
							</div>
							<c:if test="${idto.answerStatus eq 1}">
							<div class="form-group form-group--full">
								<p>답변 내용</p>
								<textarea id="inqText" class="form-control" name="answerContent" readonly>${idto.answerContent}</textarea>
							</div>
							</c:if>
							<div class="form-group form-group--full">
								<p>답변 수신 방법</p>
									<c:if test="${idto.receptionType eq 1}">
										<p>Email</p>
									</c:if>
									<c:if test="${idto.receptionType eq 2}">
										<p>SMS</p>
									</c:if>
							</div>
						</div>
						<div class="form-actions">
							<input type="hidden" name = "id" value="${sessionScope.id }"> 
							<input type="hidden" name = "inquiryId" value="${idto.inquiryId}"> 
							<input type="hidden" name = "inquirySort" value="${idto.inquirySort}"> 
							<input type="hidden" name = "inquiryType" value="${idto.inquiryType}"> 
							<input type="hidden" name = "inquiryTitle" value="${idto.inquiryTitle}"> 
							<input type="hidden" name = "inquiryContent" value="${idto.inquiryContent}"> 
							<input type="hidden" name = "receptionType" value="${idto.receptionType}"> 
							<a href=InquiryProc.do  class="btn btn--outline">내 문의내역보기</a>
							<c:if test="${idto.answerStatus eq 0}">
								<input name="btn" type="submit" class="btn btn--primary" value="수정">
							</c:if>
						</div>
					</section>
				</div>
			</div>
		</main>
		</form>
	</section>
</body>
	</html>