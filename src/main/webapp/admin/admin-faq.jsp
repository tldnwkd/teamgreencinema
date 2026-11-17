<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<section class="admin-board">
	<form class="admin-board__search" action="SearchFaqProc.do" method="get" name="fform">
		<select name="type">
			<option value="">선택</option>
			<option value="faq_inquery" ${type=='faq_inquery'?'selected':''}>제목으로 검색</option>
			<option value="faq_answer" ${type=='faq_answer'?'selected':''}>내용으로 검색</option>
		</select>
		<input name="content" type="text" value="${content}" placeholder="검색어를 입력해주세요">
		<button type="button" onclick="searchFaq();">검색</button>
		<button type="button" class="is-ghost" onclick="location.href='FaqProc.do'">전체보기</button>
	</form>

	<div class="admin-panel">
		<c:choose>
			<c:when test="${empty fList}">
				<p class="admin-empty">표시할 FAQ가 없습니다.</p>
			</c:when>
			<c:otherwise>
				<div class="admin-table-wrap">
					<table class="admin-table">
						<thead>
							<tr>
								<th>글번호</th>
								<th>글종류</th>
								<th>질문</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="fList" items="${fList}">
								<tr>
									<td>${fList.faqId}</td>
									<td>${fList.faqType}</td>
									<td><a href="OneFaqProc.do?faq_id=${fList.faqId}">${fList.faqInquery}</a></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</c:otherwise>
		</c:choose>

		<div class="admin-paging">
			<c:if test="${startpage > pageBlock}">
				<c:url var="prevUrl" value="${empty type ? 'FaqProc.do' : 'SearchFaqProc.do'}">
					<c:param name="pageNum" value="${startpage-pageBlock}"/>
					<c:if test="${not empty type}">
						<c:param name="type" value="${type}"/>
						<c:param name="content" value="${content}"/>
					</c:if>
				</c:url>
				<a href="${prevUrl}">이전</a>
			</c:if>
			<c:forEach var="i" begin="${startpage}" end="${endpage}">
				<c:url var="pageUrl" value="${empty type ? 'FaqProc.do' : 'SearchFaqProc.do'}">
					<c:param name="pageNum" value="${i}"/>
					<c:if test="${not empty type}">
						<c:param name="type" value="${type}"/>
						<c:param name="content" value="${content}"/>
					</c:if>
				</c:url>
				<a href="${pageUrl}" class="${i == param.pageNum || (empty param.pageNum && i == 1) ? 'is-current' : ''}">${i}</a>
			</c:forEach>
			<c:if test="${endpage < pageCount}">
				<c:url var="nextUrl" value="${empty type ? 'FaqProc.do' : 'SearchFaqProc.do'}">
					<c:param name="pageNum" value="${startpage+pageBlock}"/>
					<c:if test="${not empty type}">
						<c:param name="type" value="${type}"/>
						<c:param name="content" value="${content}"/>
					</c:if>
				</c:url>
				<a href="${nextUrl}">다음</a>
			</c:if>
			<button type="button" onclick="return location.href='admin/admin-index.jsp?section=Admin-FAQ-Insert.jsp'">글작성</button>
		</div>
	</div>
</section>
<script>
function searchFaq() {
	let form = document.fform;
	if (form.type.value === "") {
		alert("검색 항목을 선택해주세요.");
		form.type.focus();
		return;
	}
	form.submit();
}
</script>
