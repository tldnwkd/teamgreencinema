<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<section class="admin-board">
	<form class="admin-board__search" action="SearchInquiryProc.do" method="get" name="iform">
		<select name="type">
			<option value="">선택</option>
			<option value="inquiry_type" ${type=='inquiry_type'?'selected':''}>문의종류로 검색</option>
			<option value="inquiry_Sort" ${type=='inquiry_Sort'?'selected':''}>문의분류로 검색</option>
			<option value="inquiry_title" ${type=='inquiry_title'?'selected':''}>제목으로 검색</option>
		</select>
		<input name="content" type="text" value="${content}" placeholder="검색어를 입력해주세요">
		<button type="button" onclick="searchInquiry();">검색</button>
		<button type="button" class="is-ghost" onclick="location.href='InquiryProc.do'">전체보기</button>
	</form>

	<div class="admin-panel">
		<c:choose>
			<c:when test="${empty iList}">
				<p class="admin-empty">표시할 문의가 없습니다.</p>
			</c:when>
			<c:otherwise>
				<div class="admin-table-wrap">
					<table class="admin-table">
						<thead>
							<tr>
								<th>글번호</th>
								<th>회원아이디</th>
								<th>문의종류</th>
								<th>문의분류</th>
								<th>문의제목</th>
								<th>수신방법</th>
								<th>답변상태</th>
								<th>문의 게시일</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="iList" items="${iList}">
								<tr>
									<td>${iList.inquiryId}</td>
									<td>${iList.userId}</td>
									<td>${iList.inquiryType}</td>
									<td>${iList.inquirySort}</td>
									<td><a href="OneInquiryProc.do?inquiryId=${iList.inquiryId}&answerStatus=${iList.answerStatus}">${iList.inquiryTitle}</a></td>
									<td>
										<c:choose>
											<c:when test="${iList.receptionType eq 1}">Email</c:when>
											<c:when test="${iList.receptionType eq 2}">SMS</c:when>
											<c:otherwise>${iList.receptionType}</c:otherwise>
										</c:choose>
									</td>
									<td>
										<a href="OneInquiryProc.do?inquiryId=${iList.inquiryId}&answerStatus=${iList.answerStatus}">
											${iList.answerStatus eq 1 ? "답변 완료" : "답변 대기"}
										</a>
									</td>
									<td>${iList.inquiryDate}</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</c:otherwise>
		</c:choose>

		<div class="admin-paging">
			<c:if test="${startpage > pageBlock}">
				<c:url var="prevUrl" value="${empty type ? 'InquiryProc.do' : 'SearchInquiryProc.do'}">
					<c:param name="pageNum" value="${startpage-pageBlock}"/>
					<c:if test="${not empty type}">
						<c:param name="type" value="${type}"/>
						<c:param name="content" value="${content}"/>
					</c:if>
				</c:url>
				<a href="${prevUrl}">이전</a>
			</c:if>
			<c:forEach var="i" begin="${startpage}" end="${endpage}">
				<c:url var="pageUrl" value="${empty type ? 'InquiryProc.do' : 'SearchInquiryProc.do'}">
					<c:param name="pageNum" value="${i}"/>
					<c:if test="${not empty type}">
						<c:param name="type" value="${type}"/>
						<c:param name="content" value="${content}"/>
					</c:if>
				</c:url>
				<a href="${pageUrl}" class="${i == param.pageNum || (empty param.pageNum && i == 1) ? 'is-current' : ''}">${i}</a>
			</c:forEach>
			<c:if test="${endpage < pageCount}">
				<c:url var="nextUrl" value="${empty type ? 'InquiryProc.do' : 'SearchInquiryProc.do'}">
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
function searchInquiry() {
	var form = document.iform;
	if (form.type.value === "") {
		alert("검색 항목을 선택해주세요.");
		form.type.focus();
		return;
	}
	form.submit();
}
</script>
