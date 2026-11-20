<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<section class="admin-board">
	<div class="admin-panel">
		<form class="admin-form" action="${pageContext.request.contextPath}/FaqInsertProc.do" method="post" id="fform" name="fform">
			<div class="admin-form__row">
				<label for="faqType">문의 종류</label>
				<select id="faqType" name="faqType">
					<option value=""selected>선택</option>
					<option value="1">예매·취소</option>
					<option value="2">결제·환불</option>
					<option value="3">할인·포인트</option>
					<option value="4">회원·계정</option>
					<option value="5">관람·시설</option>
				</select>
			</div>
			<div class="admin-form__row">
				<label for="faqTitle">글제목</label>
				<input id="faqTitle" name="faqTitle" type="text" placeholder="제목을 입력하세요">
			</div>
			<div class="admin-form__row">
				<label for="faqContent">글내용</label>
				<textarea id="faqContent" name="faqContent" rows="5" placeholder="문의 내용을 입력하세요"></textarea>
			</div>
			<div class="admin-form__actions">
				<input type="hidden" name="btn" value="inq">
				<a href="${pageContext.request.contextPath}/FaqProc.do">목록</a>
				<button type="button" onclick="chk()">등록</button>
			</div>
		</form>
	</div>
</section>
<script type="text/javascript">
	function chk(){
		let f = document.fform;

		if(f.faqType.value == ""){
			alert("FAQ 종류를 입력해주세요");
			f.faqType.focus();
			return;
		}
		if(f.faqTitle.value == ""){
			alert("제목을 선택해주세요");
			f.faqTitle.focus();
			return;
		}
		if(f.faqContent.value == ""){
			alert("내용을 선택해주세요");
			f.faqContent.focus();
			return;
		}
		if(confirm('FAQ를 등록하시겠습니까?')){
			f.submit();
		}
	}
</script>
