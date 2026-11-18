<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<form action="FaqUpdateProc.do" method="post" name = aFaqform>
	<input type="hidden" value="${fOneList.faqId}" name="faq_id">
	<section class="inquiry">
		<div class="page-content">
			<div class="container">
				<div class="page-heading">
					<p class="page-heading__eyebrow">CUSTOMER SERVICE</p>
					<h1 class="page-heading__title">공지사항</h1>
				</div>
				<section class="inquiry-form">
					<div class="form-grid">
						<div class="form-group">
							<p class="form-label">문의 분류</p>
							<input type="text" name="title" value="${fOneList.faqType }" readonly>
						</div>
						<div class="form-group">
							<p class="form-label">제목</p>
							<input type="text" name="title" value="${fOneList.faqInquery}">
						</div>
						<div class="form-group form-group--full">
							<p class="form-label">공지사항 내용</p>
							<textarea id="inqText" class="form-control" name="content" >${fOneList.faqAnswer}</textarea>
						</div>
					</div>
					<div class="form-actions">
						<a href="${pageContext.request.contextPath}/FaqProc.do" class="btn btn--outline">공지 목록보기</a>
						<button name="btn" type="submit" class="btn btn--primary" value="updOk" onclick="return confirm('수정을 완료하시겠습니까?');" >수정</button>
					</div>
				</section>
			</div>
		</div>
	</section>
</form>
<script>
	
</script>
