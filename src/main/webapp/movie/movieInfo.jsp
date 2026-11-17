<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<div class="page-content">
    <div class="container" style="max-width: 1000px; margin: 40px auto; padding: 0 20px;">

        <c:choose>
            <c:when test="${not empty rjdto and not empty rjdto.movieTitle}">
                <!-- 상단 영화 상세 정보 레이아웃 -->
                <div class="movie-info-top" style="display: flex; gap: 40px; align-items: flex-start; margin-bottom: 50px;">
                    <!-- 좌측 포스터 이미지 -->
                    <div class="movie-poster-box" style="width: 260px; height: 370px; border-radius: 12px; overflow: hidden; box-shadow: 0 6px 20px rgba(0,0,0,0.15); flex-shrink: 0;">
                        <img src="./${rjdto.imgPath}" alt="${rjdto.movieTitle}" style="width: 100%; height: 100%; object-fit: cover;">
                    </div>

                    <!-- 우측 정보 및 액션 영역 -->
                    <div class="movie-detail-meta" style="flex-grow: 1;">
                        <h1 style="font-size: 26px; font-weight: bold; margin-bottom: 15px; color: #222;">${rjdto.movieTitle}</h1>
                        
                        <p style="font-size: 14px; color: #666; margin-bottom: 20px;">
                            <span>개봉일 2026.11.04</span> &nbsp;|&nbsp; 
                            <span>🕒 ${rjdto.runTime}분</span> &nbsp;|&nbsp; 
                            
                            <!-- 💡 연령 등급 텍스트 색상 동적 적용 -->
                            <span style="font-weight: bold; color: 
                                <c:choose>
                                    <c:when test='${rjdto.movieRate == 19}'>#ff4757;</c:when>
                                    <c:when test='${rjdto.movieRate == 15}'>#ff9800;</c:when>
                                    <c:when test='${rjdto.movieRate == 12}'>#f39c12;</c:when>
                                    <c:otherwise>#03c75a;</c:otherwise>
                                </c:choose>">
                                <c:choose>
                                    <c:when test="${rjdto.movieRate == 19}">19세이상관람가</c:when>
                                    <c:when test="${rjdto.movieRate == 15}">15세이상관람가</c:when>
                                    <c:when test="${rjdto.movieRate == 12}">12세이상관람가</c:when>
                                    <c:otherwise>전체관람가</c:otherwise>
                                </c:choose>
                            </span>
                        </p>

                        <!-- 버튼 그룹 (예고편, 좋아요, 공유) -->
                        <div style="display: flex; gap: 10px; align-items: center; margin-bottom: 25px;">
                            <button type="button" style="padding: 8px 16px; border: 1px solid #ddd; border-radius: 20px; background: #fff; cursor: pointer; font-size: 13px; font-weight: 500;">
                                ▶ 예고편 재생
                            </button>
                            <button type="button" style="padding: 8px 16px; border: 1px solid #ddd; border-radius: 20px; background: #fff; cursor: pointer; font-size: 13px;">
                                ♡ 3,268
                            </button>
                            <button type="button" style="padding: 8px 12px; border: 1px solid #ddd; border-radius: 20px; background: #fff; cursor: pointer; font-size: 13px;">
                                🔗
                            </button>
                        </div>

                        <!-- 줄거리 요약 -->
                        <div style="font-size: 14px; color: #444; line-height: 1.6; margin-bottom: 30px; background: #f9f9f9; padding: 15px; border-radius: 8px; border: 1px solid #eee;">
                            ${rjdto.movieContent}
                        </div>

                        <!-- 예매하기 버튼 (그린시네마 포인트 컬러 #03c75a 적용) -->
                        <a href="selectMovieReserveProc.do?movieId=${rjdto.movieId}" class="btn-reserve-action" style="display: block; width: 100%; text-align: center; padding: 15px; background: #03c75a; color: #fff; font-size: 16px; font-weight: bold; border-radius: 8px; text-decoration: none; box-shadow: 0 4px 12px rgba(3,199,90,0.3);">
                            예매하기
                        </a>
                    </div>
                </div>

                <!-- 탭 메뉴 (상세정보 / 관람평) -->
                <div class="movie-tab-menu" style="border-bottom: 2px solid #ddd; display: flex; gap: 40px; margin-bottom: 30px;">
                    <button type="button" style="background: none; border: none; font-size: 16px; font-weight: bold; padding-bottom: 12px; border-bottom: 3px solid #222; cursor: pointer; margin-bottom: -2px;">상세정보</button>
                    <button type="button" style="background: none; border: none; font-size: 16px; color: #888; padding-bottom: 12px; cursor: pointer; margin-bottom: -2px;">관람평 (624)</button>
                </div>

                <!-- 하단 영화 세부정보 영역 -->
                <div class="movie-spec-section" style="padding-bottom: 50px;">
                    <h3 style="font-size: 18px; font-weight: bold; margin-bottom: 15px; color: #222;">영화정보</h3>
                    <ul style="list-style: none; padding: 0; font-size: 14px; color: #555; line-height: 2;">
                        <li>· <strong>장르</strong> : 애니메이션 / 일본</li>
                        <li>· <strong>감독</strong> : 신보 아키유키</li>
                        <li>· <strong>출연</strong> : 유키 아오이, 사이토 치와</li>
                    </ul>
                </div>

            </c:when>
            <c:otherwise>
                <div style="text-align: center; padding: 100px 0; color: #777;">
                    해당 영화 정보를 찾을 수 없습니다.
                </div>
            </c:otherwise>
        </c:choose>

    </div>
</div>