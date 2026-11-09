<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>



			<section class="admin-stats" aria-label="운영 현황">
				<article class="admin-stat">
					<div class="admin-stat__label">상영작</div>
					<div class="admin-stat__value admin-stat__value--green">${movieCount}</div>
					<p class="admin-stat__hint">movie 테이블</p>
				</article>
				<article class="admin-stat">
					<div class="admin-stat__label">공지</div>
					<div class="admin-stat__value">${noticeCount}</div>
					<p class="admin-stat__hint">notice 테이블</p>
				</article>
				<article class="admin-stat">
					<div class="admin-stat__label">답변 대기</div>
					<div class="admin-stat__value admin-stat__value--green">${waitingCount}</div>
					<p class="admin-stat__hint">문의 ${inquiryCount}건 중</p>
				</article>
				<article class="admin-stat">
					<div class="admin-stat__label">FAQ</div>
					<div class="admin-stat__value">${faqCount}</div>
					<p class="admin-stat__hint">faq 테이블</p>
				</article>
			</section>