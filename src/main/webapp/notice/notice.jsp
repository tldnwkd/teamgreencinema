<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="그린시네마 포트폴리오 웹사이트 JSP/CSS 시안">
<meta name="theme-color" content="#11151a">
<title>공지사항 | 그린시네마</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/style.css">
</head>
<body>
	<section class="notice">
	<a class="skip-link" href="#main">본문으로 건너뛰기</a>
	<main id="main">
		<div class="page-content">
			<div class="container">
				<div class="page-heading">
					<p class="page-heading__eyebrow">CUSTOMER SERVICE</p>
					<h1 class="page-heading__title">공지사항</h1>
					<p class="page-heading__description">그린시네마의 공지사항 화면입니다.</p>
				</div>
				<nav class="cs-tabs" aria-label="고객센터 메뉴">
					<a href="index.jsp?section=notice/notice.jsp" aria-current="page">공지사항</a>
					<a href="index.jsp?section=faq/faq.jsp">FAQ</a>
					<a href="index.jsp?section=inquiry/inquiry.jsp">1:1문의</a>
				</nav>
				<div class="demo-note">
					<span class="demo-note__dot" aria-hidden="true"></span>공지사항 제목과
					게시일은 UI 예시 데이터입니다.
				</div>
				<div class="table-scroll">
					<table class="notice-table">
						<thead>
							<tr>
								<th>번호</th>
								<th>제목</th>
								<th>등록일</th>
								<th>조회수</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>3</td>
								<td>그린시네마 포트폴리오 시안 안내</td>
								<td>2026.10.29</td>
								<td>24</td>
							</tr>
							<tr>
								<td>2</td>
								<td>예매 및 결제 시스템 안내</td>
								<td>2026.10.28</td>
								<td>18</td>
							</tr>
							<tr>
								<td>1</td>
								<td>고객센터 이용 안내</td>
								<td>2026.10.27</td>
								<td>36</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</main>
	</section>
</body>
</html>