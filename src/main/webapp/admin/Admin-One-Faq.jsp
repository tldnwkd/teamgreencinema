<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<section class="admin-board">
	<div class="admin-panel">
		<form class="admin-form" action="OneFaqProc.do" method="post" name="fform">
			<input type="hidden" name="faq_id" value="${fOneList.faqId}">
			<div class="admin-form__row">
			<input id="afterType" type="hidden" value="${fOneList.faqType}" >
				<label for="beforetype">문의 분류</label>
				<select id="beforeType" name="faqType">
					<option value="1" ${fOneList.faqType == 1 ? 'selected' : ''}>예매·취소</option>
					<option value="2" ${fOneList.faqType == 2 ? 'selected' : ''}>결제·환불</option>
					<option value="3" ${fOneList.faqType == 3 ? 'selected' : ''}>할인·포인트</option>
					<option value="4" ${fOneList.faqType == 4 ? 'selected' : ''}>회원·계정</option>
					<option value="5" ${fOneList.faqType == 5 ? 'selected' : ''}>관람·시설</option>
				</select>
			</div>
			<div class="admin-form__row">
				<label for="beforeTitle">문의 제목</label>
				<input id="afterTitle" type="hidden" value="${fOneList.faqInquiry}" >
				<input id="beforeTitle" name="faqTitle" type="text" value="${fOneList.faqInquiry}">
			</div>
			<div class="admin-form__row">
				<label for="beforeContent">답변 내용</label>
				<input id="afterContent" type="hidden" value="${fOneList.faqAnswer}" >
				<textarea id="beforeContent" name="faqContent" rows="5">${fOneList.faqAnswer}</textarea>
			</div>
			<div class="admin-form__actions">
				<a href="FaqProc.do">목록</a>
				<button type="submit" name="btn" value="del" onclick="return confirm('FAQ를 삭제할까요?');">삭제</button>
				<input type="hidden" name="btn" value="update">
				<button type="button" value="update" onclick="modify()">수정</button>
			</div>
		</form>
	</div>
</section>

<script>
function modify(){
	let i = document.fform;
	let afterType = document.getElementById("afterType").value;
	let beforeType = document.getElementById("beforeType").value;
	let afterTitle = document.getElementById("afterTitle").value;
	let beforeTitle = document.getElementById("beforeTitle").value;
	let afterContent = document.getElementById("afterContent").value;
	let beforeContent = document.getElementById("beforeContent").value;

	if(afterType == beforeType && afterTitle == beforeTitle	&&	afterContent == beforeContent){
		alert('수정된 값이 없습니다.');
		i.faqContent.focus();
		return;
	}

	if(confirm('수정을 완료하시겠습니까?'))	{
		i.submit();
	}
}

</script>