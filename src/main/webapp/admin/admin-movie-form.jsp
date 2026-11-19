<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<section class="admin-board">
	<div class="admin-panel">
		<form class="admin-form" action="AdminMovieProc.do" method="post" name="movieForm" enctype="multipart/form-data">
			<c:if test="${not empty mdto}">
				<input type="hidden" name="movieId" value="${mdto.movieId}">
			</c:if>

			<div class="admin-form__row">
				<label for="beforeTitle">제목</label>
				<input id="afterTitle" type="hidden" value="${mdto.movieTitle}">
				<input id="beforeTitle" name="movieTitle" type="text" maxlength="20" value="${mdto.movieTitle}" placeholder="영화 제목 (20자 이내)">
			</div>
			<div class="admin-form__row">
				<label for="beforeRate">관람등급</label>
				<input id="afterRate" type="hidden" value="${mdto.movieRate}">
				<select id="beforeRate" name="movieRate">
					<option value="0" ${empty mdto || mdto.movieRate == 0 ? 'selected' : ''}>전체</option>
					<option value="12" ${mdto.movieRate == 12 ? 'selected' : ''}>12세</option>
					<option value="15" ${mdto.movieRate == 15 ? 'selected' : ''}>15세</option>
					<option value="19" ${mdto.movieRate == 19 ? 'selected' : ''}>19세</option>
				</select>
			</div>
			<div class="admin-form__row">
				<label for="beforeRunTime">상영시간</label>
				<input id="afterRunTime"  type="hidden" value="${mdto.runTime}" >
				<input id="beforeRunTime" name="runTime" type="number" min="1" max="255" value="${mdto.runTime}" placeholder="분">
			</div>
			<div class="admin-form__row">
				<label for="poster">포스터 이미지</label>
				<input id="poster" name="poster" type="file" accept=".jpg,.jpeg,.png,.gif,.webp,image/*">
				<input type="hidden" name="imgPath" value="${mdto.imgPath}">
				<p class="admin-form__hint">jpg, png, gif, webp 파일을 올려 주세요. 수정할 때 파일을 비우면 지금 이미지가 유지됩니다.</p>
				<c:if test="${not empty mdto.imgPath}">
					<img class="admin-form__poster" src="${pageContext.request.contextPath}${mdto.imgPath}" alt="${mdto.movieTitle}">
				</c:if>
			</div>
			<div class="admin-form__row">
				<label for="beforeContent">내용</label>
				<textarea id="afterContent" hidden><c:out value="${mdto.movieContent}"/></textarea>
				<textarea id="beforeContent" name="movieContent" rows="5"><c:out value="${mdto.movieContent}"/></textarea>
			</div>

			<div class="admin-form__actions">
				<a href="AdminMovieProc.do">목록</a>
				<c:choose>
					<c:when test="${empty mdto}">
						<button type="submit" name="btn" value="ins">등록</button>
					</c:when>
					<c:otherwise>
						<input type="hidden" name="btn" id="btn" value="">
						<button type="button" onclick="updateMovie()">수정</button>
						<button type="button" class="is-danger" onclick="deleteMovie()">삭제</button>
					</c:otherwise>
				</c:choose>
			</div>
		</form>
	</div>
</section>

<script>
function updateMovie() {
	let form = document.movieForm;
	let afterRate = document.getElementById("afterRate").value;
	let beforeRate = document.getElementById("beforeRate").value;
	let afterTitle = document.getElementById("afterTitle").value;
	let beforeTitle = document.getElementById("beforeTitle").value;
	let afterRunTime = document.getElementById("afterRunTime").value;
	let beforeRunTime = document.getElementById("beforeRunTime").value;
	let afterContent = document.getElementById("afterContent").value;
	let beforeContent = document.getElementById("beforeContent").value;
	let poster = document.getElementById("poster").value;

	if(afterRate == beforeRate
		&& afterTitle == beforeTitle
		&& afterRunTime == beforeRunTime
		&& afterContent == beforeContent
		&& poster == "") {
		alert("수정된 값이 없습니다.");
		form.movieContent.focus();
		return;
	}

	if(confirm("수정을 완료하시겠습니까?")) {
		document.getElementById("btn").value = "upd";
		form.submit();
	}
}

function deleteMovie() {
	if(confirm("이 영화를 삭제할까요?")) {
		document.getElementById("btn").value = "del";
		document.movieForm.submit();
	}
}
</script>

