<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

    <section class="board-page board-page--inquiry">
   <h1>1:1 문의사항</h1>
    <form action="SearchInquiryProc.do" method="get" name="iform">
    	<select id="type_i" name="type">
    		<option>선택</option>
    		<option value="inquiry_type"  ${type==inquiry_type?'selected':''}>문의종류로 검색</option>
    		<option value="inquiry_Sort"  ${type=='inquiry_Sort'?'selected':''}>문의분류로 검색</option>
    		<option value="inquiry_title"  ${type=='inquiry_title'?'selected':''}>제목으로 검색</option>
    	</select>
		<input name="content" id="ch" type="text" onchange="change()" placeholder="검색어를 입력해주세요" value="${content }">
    	<input type="button" value="검색" onclick="search()">
    	<input type="button" value ="전체보기" class="btn-all"
				onclick="location.href='InquiryProc.do'">
    </form>
    <table>
			<tr>
				<th>글번호</th>
				<th>회원아이디</th>
				<th>문의종류</th>
				<th>문의분류</th>
				<th>문의제목</th>
				<th>수신방법</th>
				<th>답변상태</th>
				<th>문의 게시일</th>
			</tr>
				<c:forEach var= "iList" items="${iList}">
						<tr>
							<td>${iList.inquiryId }</td>
							<td>${iList.userId }</td>
							<td>${iList.inquiryType }</td>
							<td>${iList.inquirySort }</td>
							<td>${iList.receptionType }</td>
							<c:choose >
								<c:when test="${iList.answerStatus eq 1 }">
									<td><a href="OneInquiryProc.do?inquiryId=${iList.inquiryId}&answerStatus=${iList.answerStatus}">${iList.inquiryTitle }</a></td>
									<td><a href="OneInquiryProc.do?inquiryId=${iList.inquiryId}&answerStatus=${iList.answerStatus}">답변 완료</a></td>
								</c:when>
								<c:otherwise>
									<td><a href="OneInquiryProc.do?inquiryId=${iList.inquiryId}&answerStatus=${iList.answerStatus}">${iList.inquiryTitle }</a></td>
									<td><a href="OneInquiryProc.do?inquiryId=${iList.inquiryId}&answerStatus=${iList.answerStatus}">답변 대기</a></td>
								</c:otherwise>
							</c:choose>
							<td>${iList.inquiryDate }</td>
						</tr>
				</c:forEach>
		</table>
		<%-- 페이징 부분 --%>
		<div class ="paging">
		<%-- [이전] 링크 만들지 파악 --%>
			<c:if test="${startpage > pageBlock }">
				<a href="InquiryProc.do?pageNum=${startpage-pageBlock}">이전</a>
			</c:if>
		<%-- 페이징 --%>
			<c:forEach var="i" begin="${startpage}" end ="${endpage}">
				<a href="InquiryProc.do?pageNum=${i }">${i }</a>
			</c:forEach>	
			
			<%-- [다음] 링크 만들지 파악 --%>
			<c:if test="${endpage < pageCount }">
				<a href ="InquiryProc.do?pageNum=${startpage+pageBlock}">다음</a>
			</c:if>
		</div>
	</section>
		<script>
	function search(){
		let i = document.iform;
		if(i.type.value =="선택"){
			alert('검색 항목을 선택해주세요.');
			i.type.focus();
			return;
		}else{
			i.submit();
		}
		}
	</script>
	
