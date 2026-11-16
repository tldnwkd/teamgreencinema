<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<section class="admin-board">
	<div class="admin-panel">
		<form class="admin-form" action="AdminMovieProc.do" method="post" name="movieForm">
			<c:if test="${not empty mdto}">
				<input type="hidden" name="movieId" value="${mdto.movieId}">
			</c:if>

			<div class="admin-form__row">
				<label for="movieTitle">제목</label>
				<input id="movieTitle" name="movieTitle" type="text" maxlength="20" value="${mdto.movieTitle}" placeholder="영화 제목 (20자 이내)">
			</div>
			<div class="admin-form__row">
				<label for="movieRate">관람등급</label>
				<select id="movieRate" name="movieRate">
					<option value="0" ${empty mdto || mdto.movieRate == 0 ? 'selected' : ''}>전체</option>
					<option value="12" ${mdto.movieRate == 12 ? 'selected' : ''}>12세</option>
					<option value="15" ${mdto.movieRate == 15 ? 'selected' : ''}>15세</option>
					<option value="19" ${mdto.movieRate == 19 ? 'selected' : ''}>19세</option>
				</select>
			</div>
			<div class="admin-form__row">
				<label for="runTime">상영시간</label>
				<input id="runTime" name="runTime" type="number" min="1" max="255" value="${mdto.runTime}" placeholder="분">
			</div>
			<div class="admin-form__row">
				<label for="imgPath">이미지 경로</label>
				<input id="imgPath" name="imgPath" type="text" maxlength="20" value="${mdto.imgPath}" placeholder="/img/m01.jpg">
				<c:if test="${not empty mdto.imgPath}">
					<img class="admin-form__poster" src="${pageContext.request.contextPath}${mdto.imgPath}" alt="${mdto.movieTitle}">
				</c:if>
			</div>
			<div class="admin-form__row">
				<label for="movieContent">내용</label>
				<textarea id="movieContent" name="movieContent" rows="5">${mdto.movieContent}</textarea>
			</div>

			<div class="admin-form__actions">
				<a href="AdminMovieProc.do">목록</a>
				<c:choose>
					<c:when test="${empty mdto}">
						<button type="submit" name="btn" value="ins">등록</button>
					</c:when>
					<c:otherwise>
						<button type="submit" name="btn" value="upd" onclick="return confirm('영화 정보를 수정할까요?');">수정</button>
						<button type="submit" name="btn" value="del" class="is-danger" onclick="return confirm('이 영화를 삭제할까요?');">삭제</button>
					</c:otherwise>
				</c:choose>
			</div>
		</form>
	</div>
</section>
