<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<section class="admin-board">
	<form class="admin-board__search" action="SearchNoticeProc.do" method="post" name="nform">
		<select name="type">
			<option value="">선택</option>
			<option value="notice_title" ${type=='notice_title'?'selected':''}>제목으로 검색</option>
			<option value="notice_text" ${type=='notice_text'?'selected':''}>내용으로 검색</option>
		</select>
		<input name="content" type="text" value="${content}" placeholder="검색어를 입력해주세요">
		<button type="button" onclick="searchNotice();">검색</button>
		<button type="button" class="is-ghost" onclick="location.href='NoticeProc.do'">전체보기</button>
	</form>

	<div class="admin-panel">
		<c:choose>
			<c:when test="${empty nList}">
				<p class="admin-empty">표시할 공지가 없습니다.</p>
			</c:when>
			<c:otherwise>
				<div class="admin-table-wrap">
					<table class="admin-table">
						<thead>
							<tr>
								<th>글번호</th>
								<th>제목</th>
								<th>게시일</th>
								<th>조회수</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="nList" items="${nList}">
								<tr>
									<td>${nList.noticeId}</td>
									<td><a href="OneNoticeProc.do?notice_Id=${nList.noticeId}">${nList.noticeTitle}</a></td>
									<td>${nList.noticeDate}</td>
									<td>${nList.noticeHits}</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</c:otherwise>
		</c:choose>

		<div class="admin-paging">
			<c:if test="${startpage > pageBlock}">
				<c:url var="prevUrl" value="${empty type ? 'NoticeProc.do' : 'SearchNoticeProc.do'}">
					<c:param name="pageNum" value="${startpage-pageBlock}"/>
					<c:if test="${not empty type}">
						<c:param name="type" value="${type}"/>
						<c:param name="content" value="${content}"/>
					</c:if>
				</c:url>
				<a href="${prevUrl}">이전</a>
			</c:if>
			<c:forEach var="i" begin="${startpage}" end="${endpage}">
				<c:url var="pageUrl" value="${empty type ? 'NoticeProc.do' : 'SearchNoticeProc.do'}">
					<c:param name="pageNum" value="${i}"/>
					<c:if test="${not empty type}">
						<c:param name="type" value="${type}"/>
						<c:param name="content" value="${content}"/>
					</c:if>
				</c:url>
				<a href="${pageUrl}" class="${i == param.pageNum || (empty param.pageNum && i == 1) ? 'is-current' : ''}">${i}</a>
			</c:forEach>
			<c:if test="${endpage < pageCount}">
				<c:url var="nextUrl" value="${empty type ? 'NoticeProc.do' : 'SearchNoticeProc.do'}">
					<c:param name="pageNum" value="${startpage+pageBlock}"/>
					<c:if test="${not empty type}">
						<c:param name="type" value="${type}"/>
						<c:param name="content" value="${content}"/>
					</c:if>
				</c:url>
				<a href="${nextUrl}">다음</a>
			</c:if>
			<a href="admin/admin-index.jsp?section=Admin-Notice-Insert.jsp" class="btn btn--outline">글작성</a>
		</div>
	</div>
</section>
<script>
function searchNotice() {
	var form = document.nform;
	if (form.type.value === "") {
		alert("검색 항목을 선택해주세요.");
		form.type.focus();
		return;
	}
	form.submit();
}
</script>
