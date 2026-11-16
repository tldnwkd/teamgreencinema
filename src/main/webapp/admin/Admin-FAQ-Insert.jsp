<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<section class="inquiry">
	<form action="FaqInsertProc.do" method="post" id="fform" name="fform">
		<div class="page-content">
			<div class="container">
				<div class="page-heading">
					<p class="page-heading__eyebrow">CUSTOMER SERVICE</p>
					<h1 class="page-heading__title">FAQ</h1>
					<p class="page-heading__description">FAQ 작성 화면입니다.</p>
				</div>
				<section class="inquiry-form">
					<div class="form-grid">
						<div class="form-group">
							<label for="Type" class="form-label">문의 종류</label>
							<select id="faqType" name="faqType" class="form-control">
								<option selected>선택</option>
								<option value="1">예매·취소</option>
								<option value="2">결제·환불</option>
								<option value="3">할인·포인트</option>
								<option value="4">회원·계정</option>
								<option value="5">관람·시설</option>
							</select>
						</div>
						<div class="form-group form-group--full">
							<label class="form-label" for="faqTitle">글제목</label>
							<input class="form-control" id="faqTitle" name="faqTitle" placeholder="제목을 입력하세요">
						</div>
						<div class="form-group form-group--full">
							<label class="form-label" for="inqText">글내용</label>
							<textarea id="inqText" class="form-control" name="faqContent" placeholder="문의 내용을 입력하세요"></textarea>
						</div>
					</div>
					<div class="form-actions">
						<input type="hidden" name="btn" value="inq">
						<input type="button" class="btn btn--outline" value="FAQ 전체보기" onclick="location.href='FaqProc.do'">
						<input type="button" class="btn btn--primary" value="등록" onclick="chk()">
					</div>
				</section>
			</div>
		</div>
	</form>
	<script type="text/javascript">
	

		function chk(){
			let f = document.fform


			if(f.faqType.value =="선택"){
				alert("FAQ 종류를 입력해주세요");
				f.faqType.focus();
				return
			}
			if(f.faqTitle.value ==""){
				alert("제목을 선택해주세요");
				f.faqTitle.focus();
				return
			}
			if(f.faqContent.value ==""){
				alert("내용을 선택해주세요");
				f.faqContent.focus();
				return
			}

			}
			if(confirm('FAQ를 등록하시겠습니까?')){
			f.submit();
			}else{
				return;
			}
			
			

		}
	</script>
</section>
