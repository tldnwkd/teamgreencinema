<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<section class="admin-board">
	<div class="admin-panel">
		<form class="admin-form" action="OneFaqProc.do" method="post" name="fform">
			<input type="hidden" name="faq_id" value="${fOneList.faqId}">
			<div class="admin-form__row">
				<label for="faqType">문의 분류</label>
				<select id="faqType" name="faqType">
					<option value="1" ${fOneList.faqType == 1 ? 'selected' : ''}>예매·취소</option>
					<option value="2" ${fOneList.faqType == 2 ? 'selected' : ''}>결제·환불</option>
					<option value="3" ${fOneList.faqType == 3 ? 'selected' : ''}>할인·포인트</option>
					<option value="4" ${fOneList.faqType == 4 ? 'selected' : ''}>회원·계정</option>
					<option value="5" ${fOneList.faqType == 5 ? 'selected' : ''}>관람·시설</option>
				</select>
			</div>
			<div class="admin-form__row">
				<label for="faqTitle">문의 제목</label>
				<input id="faqTitle" name="faqTitle" type="text" value="${fOneList.faqInquery}">
			</div>
			<div class="admin-form__row">
				<label for="faqContent">답변 내용</label>
				<textarea id="faqContent" name="faqContent" rows="5">${fOneList.faqAnswer}</textarea>
			</div>
			<div class="admin-form__actions">
				<a href="FaqProc.do">목록</a>
				<button type="submit" name="btn" value="upd" onclick="return confirm('FAQ를 수정할까요?');">수정</button>
				<button type="submit" name="btn" value="del" onclick="return confirm('FAQ를 삭제할까요?');">삭제</button>
			</div>
		</form>
	</div>
</section>
