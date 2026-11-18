<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<section class="admin-board">
	<div class="admin-panel">
		<form class="admin-form" action="${pageContext.request.contextPath}/NoticeInsertProc.do" method="post">
			<div class="admin-form__row">
				<label for="Noticetitle">제목</label>
				<input id="Noticetitle" name="Noticetitle" type="text" maxlength="30" placeholder="공지 제목">
			</div>
			<div class="admin-form__row">
				<label for="NoticeContent">공지사항 내용</label>
				<textarea id="NoticeContent" name="NoticeContent" rows="5"></textarea>
			</div>
			<div class="admin-form__actions">
				<a href="NoticeProc.do">목록</a>
				<button type="submit">공지사항 등록하기</button>
			</div>
		</form>
	</div>
</section>
