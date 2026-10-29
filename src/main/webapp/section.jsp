<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<section class="content-section" id="movies">
	<div class="container">
		<div class="section-header">
			<div>
				<p class="tiny-eyebrow">NOW SHOWING</p>
				<h2 class="section-title">현재 상영작</h2>
				<p class="section-subtitle">그린시네마의 가상 영화 컬렉션</p>
			</div>
			<a class="section-link" href="#">전체 예매 보기 ↗</a>
		</div>

		<div class="movie-grid">
			<article class="movie-card">
				<div class="movie-card__poster-wrap">
					<a href="#" aria-label="다시, 봄 상세정보"><img
						class="movie-card__poster"
						src="assets/posters/greencinema_poster_01.png"
						alt="가상 영화 다시, 봄 포스터" loading="lazy"></a><span
						class="movie-card__rank">01</span>
					<div class="movie-card__actions">
						<a class="btn btn--primary btn--small" href="#">예매하기</a> <a
							class="btn btn--dark btn--small" href="#">상세보기</a>
					</div>
				</div>
				<h3 class="movie-card__title">
					<a href="#">다시, 봄</a>
				</h3>
				<div class="movie-card__meta">
					<span class="age-badge age-badge--12">12</span><span
						class="meta-separator" aria-hidden="true">·</span><span>112분</span>
				</div>
			</article>
			<article class="movie-card">
				<div class="movie-card__poster-wrap">
					<a href="#" aria-label="어나더 월드 상세정보"><img
						class="movie-card__poster"
						src="assets/posters/greencinema_poster_02.png"
						alt="가상 영화 어나더 월드 포스터" loading="lazy"></a><span
						class="movie-card__rank">02</span>
					<div class="movie-card__actions">
						<a class="btn btn--primary btn--small" href="#">예매하기</a><a
							class="btn btn--dark btn--small" href="#">상세보기</a>
					</div>
				</div>
				<h3 class="movie-card__title">
					<a href="#">어나더 월드</a>
				</h3>
				<div class="movie-card__meta">
					<span class="age-badge age-badge--12">12</span><span
						class="meta-separator" aria-hidden="true">·</span><span>124분</span>
				</div>
			</article>
			<article class="movie-card">
				<div class="movie-card__poster-wrap">
					<a href="#" aria-label="바람의 기사 상세정보"><img
						class="movie-card__poster"
						src="assets/posters/greencinema_poster_03.png"
						alt="가상 영화 바람의 기사 포스터" loading="lazy"></a><span
						class="movie-card__rank">03</span>
					<div class="movie-card__actions">
						<a class="btn btn--primary btn--small" href="#">예매하기</a><a
							class="btn btn--dark btn--small" href="#">상세보기</a>
					</div>
				</div>
				<h3 class="movie-card__title">
					<a href="#">바람의 기사</a>
				</h3>
				<div class="movie-card__meta">
					<span class="age-badge age-badge--all">전체</span><span
						class="meta-separator" aria-hidden="true">·</span><span>118분</span>
				</div>
			</article>
			<article class="movie-card">
				<div class="movie-card__poster-wrap">
					<a href="#" aria-label="그림자 속의 진실 상세정보"><img
						class="movie-card__poster"
						src="assets/posters/greencinema_poster_04.png"
						alt="가상 영화 그림자 속의 진실 포스터" loading="lazy"></a><span
						class="movie-card__rank">04</span>
					<div class="movie-card__actions">
						<a class="btn btn--primary btn--small" href="#">예매하기</a><a
							class="btn btn--dark btn--small" href="#">상세보기</a>
					</div>
				</div>
				<h3 class="movie-card__title">
					<a href="#">그림자 속의 진실</a>
				</h3>
				<div class="movie-card__meta">
					<span class="age-badge age-badge--15">15</span><span
						class="meta-separator" aria-hidden="true">·</span><span>106분</span>
				</div>
			</article>
			<article class="movie-card">
				<div class="movie-card__poster-wrap">
					<a href="#" aria-label="행복한 동행 상세정보"><img
						class="movie-card__poster"
						src="assets/posters/greencinema_poster_05.png"
						alt="가상 영화 행복한 동행 포스터" loading="lazy"></a><span
						class="movie-card__rank">05</span>
					<div class="movie-card__actions">
						<a class="btn btn--primary btn--small" href="#">예매하기</a><a
							class="btn btn--dark btn--small" href="#">상세보기</a>
					</div>
				</div>
				<h3 class="movie-card__title">
					<a href="#">행복한 동행</a>
				</h3>
				<div class="movie-card__meta">
					<span class="age-badge age-badge--all">전체</span><span
						class="meta-separator" aria-hidden="true">·</span><span>95분</span>
				</div>
			</article>
			<article class="movie-card">
				<div class="movie-card__poster-wrap">
					<a href="#" aria-label="달빛 고양이 상세정보"><img
						class="movie-card__poster"
						src="assets/posters/greencinema_poster_06.png"
						alt="가상 영화 달빛 고양이 포스터" loading="lazy"></a><span
						class="movie-card__rank">06</span>
					<div class="movie-card__actions">
						<a class="btn btn--primary btn--small" href="#">예매하기</a><a
							class="btn btn--dark btn--small" href="#">상세보기</a>
					</div>
				</div>
				<h3 class="movie-card__title">
					<a href="#">달빛 고양이</a>
				</h3>
				<div class="movie-card__meta">
					<span class="age-badge age-badge--all">전체</span><span
						class="meta-separator" aria-hidden="true">·</span><span>101분</span>
				</div>
			</article>
			<article class="movie-card">
				<div class="movie-card__poster-wrap">
					<a href="#" aria-label="너의 계절 상세정보"><img
						class="movie-card__poster"
						src="assets/posters/greencinema_poster_07.png"
						alt="가상 영화 너의 계절 포스터" loading="lazy"></a><span
						class="movie-card__rank">07</span>
					<div class="movie-card__actions">
						<a class="btn btn--primary btn--small" href="#">예매하기</a><a
							class="btn btn--dark btn--small" href="#">상세보기</a>
					</div>
				</div>
				<h3 class="movie-card__title">
					<a href="#">너의 계절</a>
				</h3>
				<div class="movie-card__meta">
					<span class="age-badge age-badge--12">12</span><span
						class="meta-separator" aria-hidden="true">·</span><span>109분</span>
				</div>
			</article>
			<article class="movie-card">
				<div class="movie-card__poster-wrap">
					<a href="#" aria-label="열 번째 증인 상세정보"><img
						class="movie-card__poster"
						src="assets/posters/greencinema_poster_08.png"
						alt="가상 영화 열 번째 증인 포스터" loading="lazy"></a><span
						class="movie-card__rank">08</span>
					<div class="movie-card__actions">
						<a class="btn btn--primary btn--small" href="#">예매하기</a><a
							class="btn btn--dark btn--small" href="#">상세보기</a>
					</div>
				</div>
				<h3 class="movie-card__title">
					<a href="#">열 번째 증인</a>
				</h3>
				<div class="movie-card__meta">
					<span class="age-badge age-badge--15">15</span><span
						class="meta-separator" aria-hidden="true">·</span><span>127분</span>
				</div>
			</article>
			<article class="movie-card">
				<div class="movie-card__poster-wrap">
					<a href="#" aria-label="더 라스트 데이 상세정보"><img
						class="movie-card__poster"
						src="assets/posters/greencinema_poster_09.png"
						alt="가상 영화 더 라스트 데이 포스터" loading="lazy"></a><span
						class="movie-card__rank">09</span>
					<div class="movie-card__actions">
						<a class="btn btn--primary btn--small" href="#">예매하기</a><a
							class="btn btn--dark btn--small" href="#">상세보기</a>
					</div>
				</div>
				<h3 class="movie-card__title">
					<a href="#">더 라스트 데이</a>
				</h3>
				<div class="movie-card__meta">
					<span class="age-badge age-badge--15">15</span><span
						class="meta-separator" aria-hidden="true">·</span><span>132분</span>
				</div>
			</article>
			<article class="movie-card">
				<div class="movie-card__poster-wrap">
					<a href="#" aria-label="별이 되는 노래 상세정보"><img
						class="movie-card__poster"
						src="assets/posters/greencinema_poster_10.png"
						alt="가상 영화 별이 되는 노래 포스터" loading="lazy"></a><span
						class="movie-card__rank">10</span>
					<div class="movie-card__actions">
						<a class="btn btn--primary btn--small" href="#">예매하기</a><a
							class="btn btn--dark btn--small" href="#">상세보기</a>
					</div>
				</div>
				<h3 class="movie-card__title">
					<a href="#">별이 되는 노래</a>
				</h3>
				<div class="movie-card__meta">
					<span class="age-badge age-badge--12">12</span><span
						class="meta-separator" aria-hidden="true">·</span><span>114분</span>
				</div>
			</article>
		</div>
	</div>
</section>
<section class="promo-band">
	<div class="container promo-band__inner">
		<div>
			<p class="tiny-eyebrow">GREEN CINEMA GUIDE</p>
			<h2>
				취향에 맞는 영화를 찾고,<br>자리까지 간편하게 선택하세요.
			</h2>
			<p>영화 선택 → 극장·일정 선택 → 좌석 선택 → 결제 순서의 예매 화면을 둘러보세요.</p>
		</div>
		<a class="btn btn--primary btn--large" href="#">예매 화면
			보기 ↗</a>
	</div>
</section>
<section class="content-section content-section--white">
	<div class="container">
		<div class="section-header">
			<div>
				<p class="tiny-eyebrow">SERVICE</p>
				<h2 class="section-title">그린시네마 이용 안내</h2>
			</div>
		</div>
		<div class="service-grid">
			<a class="service-card" href="#">
			<span class="service-card__num">01</span><span class="service-card__icon">▦</span>
			<h3>영화 예매</h3>
			<p>영화·극장·상영일정을 고르는 화면</p> <strong>화면 보기 ↗</strong></a>
			
			<a class="service-card" href="#">
			<span class="service-card__num">02</span><span class="service-card__icon">▤</span>
			<h3>마이페이지</h3>
			<p>예매내역과 문의내역을 확인하는 화면</p> <strong>화면 보기 ↗</strong></a>
			
			
			<a class="service-card" href="#">
			<span class="service-card__num">03</span><span class="service-card__icon">?</span>
			<h3>고객센터</h3>
			<p>FAQ·공지사항·1:1 문의 안내</p> <strong>화면 보기 ↗</strong></a>
		</div>
	</div>
</section>