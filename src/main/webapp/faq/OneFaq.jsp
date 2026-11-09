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
<title>FAQ | 그린시네마</title>
<link rel="stylesheet" href="css/inquiry.css">
</head>
<body>
	<section class="inquiry">
			<a class="skip-link" href="#main">본문으로 건너뛰기</a>
			<main id="main">
				<div class="page-content">
					<div class="container">
						<div class="page-heading">
							<p class="page-heading__eyebrow">CUSTOMER SERVICE</p>
							<h1 class="page-heading__title">FAQ</h1>
						</div>
						<nav class="cs-tabs" aria-label="고객센터 메뉴">
							<a href="NoticeProc.do">공지사항</a> <a href="FaqProc.do">FAQ</a> <a
								href="InquiryProc.do" aria-current="page">1:1 문의</a>
						</nav>

						<section class="inquiry-form">
							<div class="form-grid">
								<div class="form-group">
									<p class="form-label">문의 분류</p>
									<p>${fOneList.faqType }</p>
								</div>
								<div class="form-group form-group--full">
									<p>문의 제목</p>
									<P>${fOneList.faqInquery}</p>
								</div>
								<div class="form-group form-group--full">
									<p>답변 내용</p>
									<textarea id="inqText" class="form-control" name="faqAnswer"
										readonly>${fOneList.faqAnswer}</textarea>
								</div>
							</div>
							<div class="form-actions">
								<input type="hidden" name="faqId" value="${fOneList.faqId }">
								<input type="hidden" name="faqType" value="${fOneList.faqType}">
								<input type="hidden" name="faqAnswer"value="${fOneList.faqAnswer}"> 
								<input type="hidden"name="faqAnswer" value="${fOneList.faqAnswer}"> 
								<a href=FaqProc.do class="btn btn--outline">FAQ 목록보기</a>
							</div>
						</section>
					</div>
				</div>
			</main>
	</section>
</body>
</html>