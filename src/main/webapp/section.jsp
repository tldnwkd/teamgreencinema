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
			<c:forEach items="${mdtoList}" var="list" begin="0">
				<article class="movie-card">
					<div class="movie-card__poster-wrap">
						<a href="MovieInfo.do" aria-label="${list.movieTitle }">
						<img class="movie-card__poster" src="./${list.imgPath}" alt="${list.movieTitle }"></a>
						<span class="movie-card__rank">${begin}</span>
						<div class="movie-card__actions">
							<a class="btn btn--primary btn--small" href="#">예매하기</a>
							<a class="btn btn--dark btn--small" href="#">상세보기</a>
						</div>					
					</div>				
				</article>
			</c:forEach>
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