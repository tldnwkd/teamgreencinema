<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<section class="admin-board">
		<div class="admin-panel">
			<form class="admin-form" action="OneNoticeProc.do" method="post" name="nform">
				<input type="hidden" name="notice_Id" value="${nOneList.noticeId}">
				<div class="admin-form__row">
					<label for="noticeTitle">제목</label>
					<input id="noticeTitle" name="noticeTitle" type="text" maxlength="30" value="${nOneList.noticeTitle}">
				</div>
				<div class="admin-form__row">
					<label for="noticeDate">게시일</label>
					<input id="noticeDate" type="text" value="${nOneList.noticeDate}" readonly>
				</div>
				<div class="admin-form__row">
					<label for="noticeHits">조회수</label>
					<input id="noticeHits" type="text" value="${nOneList.noticeHits}" readonly>
				</div>
				<div class="admin-form__row">
					<label for="noticeText">공지사항 내용</label>
					<textarea id="noticeText" name="noticeText" rows="5">${nOneList.noticeText}</textarea>
				</div>
				<div class="admin-form__actions">
					<a href="${pageContext.request.contextPath}/NoticeProc.do">목록</a>
					<button type="submit" name="btn" value="upd" onclick="return confirm('공지를 수정할까요?');">수정</button>
				</div>
			</form>
		</div>
	</section>
