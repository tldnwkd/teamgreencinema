<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import = "java.util.*"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
    <link rel="stylesheet" href="css/inquiry.css">
    <section>
	<table border="1">
		<tr>
			<th>글번호</th>
			<th>문의종류</th>
			<th>문의분류</th>
			<th>제목</th>
			<th>답변상태</th>
		</tr>
			<c:set var="number" value="${number}"/>
			<c:forEach var= "iList" items="${iList}">
					<tr>
						<td>${number }</td>
						<td>${iList.inquiryType }</td>
						<td>${iList.inquirySort }</td>
						<td>${iList.inquiryTitle }</td>
						<td>
						<c:choose >
							<c:when test="${iList.answerStatus eq 1 }">
								<a href="#">답변 완료</a>
							</c:when>
							<c:otherwise>
								<p>답변 대기</p>
							</c:otherwise>
						</c:choose>
						</td>
					</tr>
				<c:set var="number" value="${number-1}"/>
			</c:forEach>
	</table>
	<%-- 페이징 부분 --%>
	<div class ="paging">
	<%-- [이전] 링크 만들지 파악 --%>
		<c:if test="${startpage > pageBlock }">
			<a href="InquiryProc.do?pageNum=${startpage-pageBlock}">[이전]</a>
		</c:if>
	<%-- 페이징 --%>
	<c:forEach var="i" begin="${startpage}" end ="${endpage}">
		<a href="InquiryProc.do?pageNum=${i }">[${i }]</a>
	</c:forEach>	
	
	<%-- [다음] 링크 만들지 파악 --%>
	<c:if test="${endpage> pageBlock }">
		<a href ="InquiryProc.do?pageNum=${startpage+pageBlock}">[다음]</a>
	</c:if>
	
	
		
	</div>
	</section>