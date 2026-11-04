<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="그린시네마 포트폴리오 웹사이트 JSP/CSS 시안">
<meta name="theme-color" content="#11151a">
<title>FAQ | 그린시네마</title>
<link rel="stylesheet" href="/css/style.css">
</head>
<body>
	<a class="skip-link" href="#main">본문으로 건너뛰기</a>
	<main id="main">
		<div class="page-content">
			<div class="container">
				<div class="page-heading">
					<p class="page-heading__eyebrow">CUSTOMER SERVICE</p>
					<h1 class="page-heading__title">자주 묻는 질문</h1>
					<p class="page-heading__description">궁금한 내용을 클릭하면 답변을 확인할 수
						있습니다.</p>
				</div>
				<nav class="cs-tabs" aria-label="고객센터 메뉴">
					<a href="index.jsp?section=notice/notice.jsp">공지사항</a>
					<a href="index.jsp?section=faq/faq.jsp" aria-current="page">FAQ</a>
					<a href="index.jsp?section=inquiry/inquiry.jsp">1:1 문의</a>
				</nav>
				<div class="faq-list">
					<details class="faq-item">
						<summary>영화 예매는 누가 할 수 있나요?</summary>
						<div class="faq-item__answer">요구사항상 예매는 로그인한 회원만 가능합니다. 현재는
							HTML/CSS 시안이므로 실제 로그인·예매 기능은 연결되어 있지 않습니다.</div>
					</details>
					<details class="faq-item">
						<summary>한 번에 몇 명까지 예매할 수 있나요?</summary>
						<div class="faq-item__answer">성인과 청소년을 합하여 최대 8명까지 예매할 수 있도록
							계획되어 있습니다.</div>
					</details>
					<details class="faq-item">
						<summary>예매 취소는 어떻게 하나요?</summary>
						<div class="faq-item__answer">기획상 마이페이지에서 예매 취소가 가능하며, 결제 후
							3일 이내 취소 가능합니다. 부분 취소는 허용하지 않습니다.</div>
					</details>
					<details class="faq-item">
						<summary>결제 수단은 어떤 것이 있나요?</summary>
						<div class="faq-item__answer">신용카드와 계좌이체 두 종류를 지원하도록 설계되어
							있습니다.</div>
					</details>
					<details class="faq-item">
						<summary>상영 일정은 언제까지 확인할 수 있나요?</summary>
						<div class="faq-item__answer">요구사항에 따르면 오늘 기준 7일치 상영 일정을
							제공합니다.</div>
					</details>
				</div>
			</div>
		</div>
	</main>

</body>
</html>