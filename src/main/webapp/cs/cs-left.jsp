<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<aside class="cs-left">
    <div class="page-heading">
        <p class="page-heading__eyebrow">CUSTOMER SERVICE</p>
        <c:choose>
            <c:when test="${param.csSection eq 'notice'}">
                <h1 class="page-heading__title">공지사항</h1>
                <p class="page-heading__description">그린시네마의 공지사항입니다.</p>
            </c:when>
            <c:when test="${param.csSection eq 'faq'}">
                <h1 class="page-heading__title">FAQ</h1>
                <p class="page-heading__description">자주 묻는 질문과 답변입니다.</p>
            </c:when>
            <c:otherwise>
                <h1 class="page-heading__title">1:1 문의</h1>
                <p class="page-heading__description">나의 1:1 문의 내역을 확인하세요.</p>
            </c:otherwise>
        </c:choose>
    </div>

    <nav class="cs-tabs" aria-label="고객센터 메뉴">
        <a href="${pageContext.request.contextPath}/NoticeProc.do"
           class="${param.csSection eq 'notice' ? 'is-active' : ''}"
           aria-current="${param.csSection eq 'notice' ? 'page' : 'false'}">공지사항</a>
        <a href="${pageContext.request.contextPath}/FaqProc.do"
           class="${param.csSection eq 'faq' ? 'is-active' : ''}"
           aria-current="${param.csSection eq 'faq' ? 'page' : 'false'}">FAQ</a>
        <a href="${pageContext.request.contextPath}/InquiryProc.do"
           class="${empty param.csSection or param.csSection eq 'inquiry' ? 'is-active' : ''}"
           aria-current="${empty param.csSection or param.csSection eq 'inquiry' ? 'page' : 'false'}">1:1 문의</a>
    </nav>
</aside>
