<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:choose>
    <c:when test="${param.csView eq 'detail'}">
        <article class="cs-panel">
            <span class="cs-chip">
                <c:choose>
                    <c:when test="${fOneList.faqType == 1}">예매 · 결제</c:when>
                    <c:when test="${fOneList.faqType == 2}">영화관</c:when>
                    <c:when test="${fOneList.faqType == 3}">회원정보</c:when>
                    <c:when test="${fOneList.faqType == 4}">이벤트</c:when>
                    <c:when test="${fOneList.faqType == 5}">관람 · 시설</c:when>
                    <c:otherwise>FAQ</c:otherwise>
                </c:choose>
            </span>
            <h2 class="cs-article__title"><c:out value="${fOneList.faqInquiry}" /></h2>
            <div class="cs-answer">
                <span class="cs-chip">답변</span>
                <div class="cs-body"><c:out value="${fOneList.faqAnswer}" /></div>
            </div>
            <div class="form-actions">
                <a class="btn btn--outline" href="${pageContext.request.contextPath}/FaqProc.do">목록</a>
            </div>
        </article>
    </c:when>
    <c:otherwise>
        <section class="cs-panel">
            <div class="cs-panel__head">
                <span class="cs-chip">${param.csView eq 'search' ? '검색 결과' : '자주 묻는 질문'}</span>
            </div>
            <form class="cs-search" action="${pageContext.request.contextPath}/SearchFaqProc.do" method="get">
                <select name="type" aria-label="FAQ 검색 항목" required>
                    <option value="">선택</option>
                    <option value="faq_inquiry" ${type eq 'faq_inquiry' ? 'selected' : ''}>제목으로 검색</option>
                    <option value="faq_answer" ${type eq 'faq_answer' ? 'selected' : ''}>내용으로 검색</option>
                </select>
                <input type="text" name="content" value="<c:out value='${content}'/>" placeholder="검색어를 입력해주세요" required>
                <input type="submit" value="검색">
                <input type="button" class="btn-all" value="전체보기" onclick="location.href='${pageContext.request.contextPath}/FaqProc.do'">
            </form>
            <div class="cs-table-wrap">
                <table class="cs-table">
                    <thead><tr><th>질문</th></tr></thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${empty fList}">
                                <tr><td class="cs-empty">등록된 FAQ가 없습니다.</td></tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="f" items="${fList}">
                                    <tr>
                                        <td>
                                            <button type="button" class="cs-acc" aria-expanded="false">
                                                <span><c:out value="${f.faqInquiry}" /></span>
                                                <span class="cs-acc__chev" aria-hidden="true"></span>
                                            </button>
                                        </td>
                                    </tr>
                                    <tr class="cs-drop" hidden>
                                        <td><div class="cs-body"><c:out value="${f.faqAnswer}" /></div></td>
                                    </tr>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>
            <div class="cs-paging">
                <c:if test="${startpage gt pageBlock}">
                    <c:url var="prev" value="/${param.csView eq 'search' ? 'SearchFaqProc.do' : 'FaqProc.do'}">
                        <c:param name="pageNum" value="${startpage-pageBlock}" />
                        <c:if test="${param.csView eq 'search'}"><c:param name="type" value="${type}"/><c:param name="content" value="${content}"/></c:if>
                    </c:url>
                    <a href="${prev}">이전</a>
                </c:if>
                <c:if test="${not empty startpage and not empty endpage and startpage le endpage}">
                    <c:forEach var="i" begin="${startpage}" end="${endpage}">
                        <c:url var="purl" value="/${param.csView eq 'search' ? 'SearchFaqProc.do' : 'FaqProc.do'}">
                            <c:param name="pageNum" value="${i}" />
                            <c:if test="${param.csView eq 'search'}"><c:param name="type" value="${type}"/><c:param name="content" value="${content}"/></c:if>
                        </c:url>
                        <a href="${purl}" class="${i == param.pageNum || (empty param.pageNum && i == 1) ? 'is-current' : ''}"><c:out value="${i}" /></a>
                    </c:forEach>
                </c:if>
                <c:if test="${endpage lt pageCount}">
                    <c:url var="next" value="/${param.csView eq 'search' ? 'SearchFaqProc.do' : 'FaqProc.do'}">
                        <c:param name="pageNum" value="${startpage+pageBlock}" />
                        <c:if test="${param.csView eq 'search'}"><c:param name="type" value="${type}"/><c:param name="content" value="${content}"/></c:if>
                    </c:url>
                    <a href="${next}">다음</a>
                </c:if>
            </div>
        </section>
    </c:otherwise>
</c:choose>
