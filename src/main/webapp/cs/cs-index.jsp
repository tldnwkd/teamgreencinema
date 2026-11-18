<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/cs-layout.css">

<section class="inquiry cs-shell">
    <div class="page-content">
        <div class="container cs-layout">
            <jsp:include page="/cs/cs-left.jsp" />

            <main class="cs-main" id="cs-main">
                <c:choose>
                    <c:when test="${param.csSection eq 'notice'}">
                        <jsp:include page="/cs/cs-notice.jsp" />
                    </c:when>
                    <c:when test="${param.csSection eq 'faq'}">
                        <jsp:include page="/cs/cs-faq.jsp" />
                    </c:when>
                    <c:otherwise>
                        <jsp:include page="/cs/cs-inquiry.jsp" />
                    </c:otherwise>
                </c:choose>
            </main>
        </div>
    </div>
</section>
