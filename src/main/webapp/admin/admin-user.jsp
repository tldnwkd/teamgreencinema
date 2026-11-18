<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<section class="admin-board">
	<form class="admin-board__search admin-board__search--movie" action="UserProc.do" method="get" name="uform">
		<select name="type">
			<option value="">선택</option>
			<option value="user_id" ${type=='user_id'?'selected':''}>아이디로 검색</option>
			<option value="user_name" ${type=='user_name'?'selected':''}>이름으로 검색</option>
			<option value="user_phone" ${type=='user_phone'?'selected':''}>연락처로 검색</option>
		</select>
		<input name="content" type="text" value="${content}" placeholder="검색어를 입력해주세요">
		<button type="button" onclick="searchUser();">검색</button>
		<button type="button" class="is-ghost" onclick="location.href='UserProc.do'">전체보기</button>
		<button type="button" onclick="location.href='UserProc.do?menu=write'">회원 등록</button>
	</form>

	<div class="admin-panel">
		<c:choose>
			<c:when test="${empty uList}">
				<p class="admin-empty">표시할 회원이 없습니다.</p>
			</c:when>
			<c:otherwise>
				<div class="admin-table-wrap">
					<table class="admin-table admin-table--fit">
						<thead>
							<tr>
								<th>아이디</th>
								<th>이름</th>
								<th>연락처</th>
								<th>이메일</th>
								<th>상태</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="uList" items="${uList}">
								<tr>
									<td><a href="UserProc.do?user_Id=${uList.userId}">${uList.userId}</a></td>
									<td>${uList.userName}</td>
									<td>${uList.userPhone}</td>
									<td>${uList.userEmail}</td>
									<td>
										<c:choose>
											<c:when test="${uList.userDelete == 1}">탈퇴</c:when>
											<c:otherwise>정상</c:otherwise>
										</c:choose>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</c:otherwise>
		</c:choose>

		<div class="admin-paging">
			<c:if test="${startpage > pageBlock}">
				<c:url var="prevUrl" value="UserProc.do">
					<c:param name="pageNum" value="${startpage-pageBlock}"/>
					<c:if test="${not empty type}">
						<c:param name="type" value="${type}"/>
						<c:param name="content" value="${content}"/>
					</c:if>
				</c:url>
				<a href="${prevUrl}">이전</a>
			</c:if>
			<c:forEach var="i" begin="${startpage}" end="${endpage}">
				<c:url var="pageUrl" value="UserProc.do">
					<c:param name="pageNum" value="${i}"/>
					<c:if test="${not empty type}">
						<c:param name="type" value="${type}"/>
						<c:param name="content" value="${content}"/>
					</c:if>
				</c:url>
				<a href="${pageUrl}" class="${i == param.pageNum || (empty param.pageNum && i == 1) ? 'is-current' : ''}">${i}</a>
			</c:forEach>
			<c:if test="${endpage < pageCount}">
				<c:url var="nextUrl" value="UserProc.do">
					<c:param name="pageNum" value="${endpage+1}"/>
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
	function searchUser() {
		if(document.uform.type.value == "") {
			alert("검색 항목을 선택해주세요.");
			return;
		}
		document.uform.submit();
	}
</script>
