<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<section class="admin-board">
	<form class="admin-board__search admin-board__search--movie" action="SearchAdminMoiveProc.do" method="get" name="mform">
		<select name="type">
			<option value="">선택</option>
			<option value="movie_title" ${type=='movie_title'?'selected':''}>제목으로 검색</option>
			<option value="movie_content" ${type=='movie_content'?'selected':''}>내용으로 검색</option>
		</select>
		<input name="content" type="text" value="${content}" placeholder="검색어를 입력해주세요">
		<button type="button" onclick="searchMovie();">검색</button>
		<button type="button" class="is-ghost" onclick="location.href='AdminMovieProc.do'">전체보기</button>
		<button type="button" onclick="location.href='AdminMovieProc.do?menu=write'">영화 등록</button>
	</form>

	<div class="admin-panel">
		<c:choose>
			<c:when test="${empty mList}">
				<p class="admin-empty">표시할 영화가 없습니다.</p>
			</c:when>
			<c:otherwise>
				<div class="admin-table-wrap">
					<table class="admin-table admin-table--fit">
						<thead>
							<tr>
								<th>영화번호</th>
								<th>제목</th>
								<th>관람등급</th>
								<th>상영시간</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="mList" items="${mList}">
								
								<tr>
									<td>${mList.movieId}</td>
									<td><a href="AdminMovieProc.do?movie_Id=${mList.movieId}">${mList.movieTitle}</a></td>
									<td>
										<c:choose>
											<c:when test="${mList.movieRate == 0}">전체</c:when>
											<c:when test="${mList.movieRate == 12}">12세</c:when>
											<c:when test="${mList.movieRate == 15}">15세</c:when>
											<c:when test="${mList.movieRate == 19}">19세</c:when>
											<c:otherwise>${mList.movieRate}</c:otherwise>
										</c:choose>
									</td>
									<td>${mList.runTime}분</td>
								</tr>								
							</c:forEach>
						</tbody>
					</table>
				</div>
			</c:otherwise>
		</c:choose>

		<div class="admin-paging">
			<c:if test="${startpage > pageBlock}">
				<c:url var="prevUrl" value="${empty type ? 'AdminMovieProc.do' : 'SearchAdminMoiveProc.do'}">
					<c:param name="pageNum" value="${startpage-pageBlock}"/>
					<c:if test="${not empty type}">
						<c:param name="type" value="${type}"/>
						<c:param name="content" value="${content}"/>
					</c:if>
				</c:url>
				<a href="${prevUrl}">이전</a>
			</c:if>
			<c:forEach var="i" begin="${startpage}" end="${endpage}">
				<c:url var="pageUrl" value="${empty type ? 'AdminMovieProc.do' : 'SearchAdminMoiveProc.do'}">
					<c:param name="pageNum" value="${i}"/>
					<c:if test="${not empty type}">
						<c:param name="type" value="${type}"/>
						<c:param name="content" value="${content}"/>
					</c:if>
				</c:url>
				<a href="${pageUrl}" class="${i == param.pageNum || (empty param.pageNum && i == 1) ? 'is-current' : ''}">${i}</a>
			</c:forEach>
			<c:if test="${endpage < pageCount}">
				<c:url var="nextUrl" value="${empty type ? 'AdminMovieProc.do' : 'SearchAdminMoiveProc.do'}">
					<c:param name="pageNum" value="${startpage+pageBlock}"/>
					<c:if test="${not empty type}">
						<c:param name="type" value="${type}"/>
						<c:param name="content" value="${content}"/>
					</c:if>
				</c:url>
				<a href="${nextUrl}">다음</a>
			</c:if>
		</div>
	</div>
</section>
<script>
function searchMovie() {
	var form = document.mform;
	if (form.type.value === "") {
		alert("검색 항목을 선택해주세요.");
		form.type.focus();
		return;
	}
	form.submit();
}
</script>
