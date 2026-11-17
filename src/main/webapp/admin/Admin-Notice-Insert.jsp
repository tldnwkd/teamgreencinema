<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<section class="inquiry">
	<form action="${pageContext.request.contextPath}/NoticeInsertProc.do"
		method="post">
		<div class="page-content">
			<div class="container">
				<div class="page-heading">
					<p class="page-heading__eyebrow">CUSTOMER SERVICE</p>
					<h1 class="page-heading__title">공지사항</h1>
				</div>
				<section class="inquiry-form">
					<div class="form-grid">
						<div class="form-group">
							<p class="form-label">제목</p>
							<input name="Noticetitle">
						</div>
						<div class="form-group form-group--full">
							<p class="form-label">공지사항 내용</p>
							<textarea id="inqText" class="form-control" name="NoticeContent"></textarea>
						</div>
					</div>
					<div class="form-actions">
						<a href="NoticeProc.do" class="btn btn--outline">공지 목록보기</a>
						<button type="submit" class="btn btn--primary">공지사항 등록하기</button>
					</div>
				</section>
			</div>
		</div>
	</form>
</section>
