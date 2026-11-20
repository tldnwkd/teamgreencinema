<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<div class="page-content">
    <div class="container movie-detail-container">

        <c:choose>
            <c:when test="${not empty rjdto and not empty rjdto.movieTitle}">
                <!-- 상단 영화 상세 정보 레이아웃 -->
                <div class="movie-info-top">
                    <!-- 좌측 포스터 이미지 -->
                    <div class="movie-poster-box">
                        <img src="./${rjdto.imgPath}" alt="${rjdto.movieTitle}" class="movie-poster-box__img">
                    </div>

                    <!-- 우측 정보 및 액션 영역 -->
                    <div class="movie-detail-meta">
                        <h1 class="movie-detail-heading">${rjdto.movieTitle}</h1>
                        
                        <p class="movie-meta-line">
                            <span>개봉일 2026.11.04</span>
                            <span class="meta-separator">|</span>
                            <span>🕒 ${rjdto.runTime}분</span>
                            <span class="meta-separator">|</span>
                            
                            <!-- 연령 등급 텍스트 색상 동적 적용 -->
                            <c:choose>
                                <c:when test="${rjdto.movieRate == 19}">
                                    <span class="movie-rate-text movie-rate-text--19">19세이상관람가</span>
                                </c:when>
                                <c:when test="${rjdto.movieRate == 15}">
                                    <span class="movie-rate-text movie-rate-text--15">15세이상관람가</span>
                                </c:when>
                                <c:when test="${rjdto.movieRate == 12}">
                                    <span class="movie-rate-text movie-rate-text--12">12세이상관람가</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="movie-rate-text movie-rate-text--all">전체관람가</span>
                                </c:otherwise>
                            </c:choose>
                        </p>

                        <!-- 버튼 그룹 (예고편, 좋아요, 공유) -->
                        <div class="movie-action-group">
                            <button type="button" class="movie-pill-btn movie-pill-btn--trailer">
                                ▶ 예고편 재생
                            </button>
                            <button type="button" class="movie-pill-btn">
                                ♡ 3,268
                            </button>
                            <button type="button" class="movie-pill-btn movie-pill-btn--share">
                                🔗
                            </button>
                        </div>

                        <!-- 줄거리 요약 -->
                        <div class="movie-synopsis-box">
                            ${rjdto.movieContent}
                        </div>

                        <!-- 예매하기 버튼 -->
                        <a href="selectMovieReserveProc.do?movieId=${rjdto.movieId }" class="btn-reserve-action">
                            예매하기
                        </a>
                    </div>
                </div>

                <!-- 탭 메뉴 (상세정보 / 관람평) -->
                <div class="movie-tab-menu">
                    <button type="button" class="movie-tab-btn is-active">상세정보</button>
                    <button type="button" class="movie-tab-btn">관람평 (624)</button>
                </div>

                <!-- 하단 영화 세부정보 영역 -->
                <div class="movie-spec-section">
                    <h3 class="movie-spec-title">영화정보</h3>
                    <ul class="movie-spec-list">
                        <li>· <strong>장르</strong> : 애니메이션 / 일본</li>
                        <li>· <strong>감독</strong> : 신보 아키유키</li>
                        <li>· <strong>출연</strong> : 유키 아오이, 사이토 치와</li>
                    </ul>
                </div>

            </c:when>
            <c:otherwise>
                <div class="movie-detail-empty">
                    해당 영화 정보를 찾을 수 없습니다.
                </div>
            </c:otherwise>
        </c:choose>

    </div>
</div>

<script type="text/javascript">
	function reservebtn(movieId) {
	    if (${sessionScope.id == null} || ${sessionScope.id == ""}) {
	        alert('로그인 후 이용 가능합니다.');
	        location.href = 'index.jsp?section=user/login.jsp';
	        return;
	    }
	    var targetId = movieId ? movieId : "1";
	    location.href = "selectMovieReserveProc.do?movieId=" + targetId;
	}
</script>