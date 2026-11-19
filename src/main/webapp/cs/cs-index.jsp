<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/cs-layout.css?v=20261118d">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/theme-unified.css?v=20261118">

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
<script>
document.addEventListener("click", function (event) {
    var button = event.target.closest(".cs-acc");
    if (!button) return;
    var row = button.closest("tr");
    var drop = row.nextElementSibling;
    var open = button.getAttribute("aria-expanded") === "true";
    button.setAttribute("aria-expanded", open ? "false" : "true");
    if (drop) drop.hidden = open;
});
</script>
