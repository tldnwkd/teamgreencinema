<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:choose>
    <c:when test="${param.csView eq 'detail'}">
        <section class="inquiry-form">
            <div class="form-grid">
                <div class="form-group">
                    <p class="form-label">문의 분류</p>
                    <p><c:out value="${fOneList.faqType}" /></p>
                </div>
                <div class="form-group form-group--full">
                    <p class="form-label">문의 제목</p>
                    <p><c:out value="${fOneList.faqInquery}" /></p>
                </div>
                <div class="form-group form-group--full">
                    <p class="form-label">답변 내용</p>
                    <textarea class="form-control" readonly><c:out value="${fOneList.faqAnswer}" /></textarea>
                </div>
            </div>
            <div class="form-actions">
                <a class="btn btn--outline" href="${pageContext.request.contextPath}/FaqProc.do">FAQ 목록보기</a>
            </div>
        </section>
    </c:when>
    <c:otherwise>
        <section class="board-page board-page--faq ${param.csView eq 'search' ? 'is-search' : ''}">
            <form action="${pageContext.request.contextPath}/SearchFaqProc.do" method="get">
                <select name="type" aria-label="FAQ 검색 항목" required>
                    <option value="">선택</option>
                    <option value="faq_inquery" ${type eq 'faq_inquery' ? 'selected' : ''}>제목으로 검색</option>
                    <option value="faq_answer" ${type eq 'faq_answer' ? 'selected' : ''}>내용으로 검색</option>
                </select>
                <input type="text" name="content" value="<c:out value='${content}'/>" placeholder="검색어를 입력해주세요" required>
                <input type="submit" value="검색">
                <input type="button" class="btn-all" value="전체보기"
                       onclick="location.href='${pageContext.request.contextPath}/FaqProc.do'">
            </form>

            <table>
                <thead><tr><th>질문</th></tr></thead>
                <tbody>
                    <c:choose>
                        <c:when test="${empty fList}">
                            <tr><td>등록된 FAQ가 없습니다.</td></tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="f" items="${fList}">
                                <tr><td><a href="${pageContext.request.contextPath}/OneFaqProc.do?faq_id=${f.faqId}"><c:out value="${f.faqInquery}" /></a></td></tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>

            <div class="paging">
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
                        <a href="${purl}"><c:out value="${i}" /></a>
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
