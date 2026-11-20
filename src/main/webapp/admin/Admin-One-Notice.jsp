<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<section class="admin-board">
	<div class="admin-panel">
		<form class="admin-form" action="OneNoticeProc.do" method="post" name="nform">
			<input type="hidden" name="notice_Id" value="${nOneList.noticeId}">
			<div class="admin-form__row">
				<label for="beforeTitle">제목</label>
				<input id="afterTitle" type="hidden" value="${nOneList.noticeTitle}">
				<input id="beforeTitle" name="noticeTitle" type="text" maxlength="30" value="${nOneList.noticeTitle}">
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
				<label for="beforeContent">공지사항 내용</label>
				<input id="afterContent" type="hidden" value="${nOneList.noticeText}">
				<textarea id="beforeContent" name="noticeText" rows="5">${nOneList.noticeText}</textarea>
			</div>
			<div class="admin-form__actions">
				<a href="${pageContext.request.contextPath}/NoticeProc.do">목록</a>
				<input type="hidden" name="btn" value="upd">
				<button type="button" value="upd" onclick="modify()">수정</button>
				<a onclick="deleteNotice(${nOneList.noticeId})" class="delete-notice-button">삭제</a>
			</div>
		</form>
	</div>
</section>

<script type="text/javascript">
	function modify(){
		let i = document.nform;
		let afterTitle = document.getElementById("afterTitle").value;
		let beforeTitle = document.getElementById("beforeTitle").value;
		let afterContent = document.getElementById("afterContent").value;
		let beforeContent = document.getElementById("beforeContent").value;

		if(afterTitle == beforeTitle && afterContent == beforeContent){
			alert('수정된 값이 없습니다.');
			i.noticeText.focus();
			return;
		}

		if(confirm('수정을 완료하시겠습니까?')){
			i.submit();
		}
	}

	function deleteNotice(noticeId){
		if(confirm("공지사항을 삭제하시겠습니까?")){
			location.href="${pageContext.request.contextPath}/NoticeDeleteProc.do?noticeId=" + noticeId;
			return;
		}
	}
</script>