<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:choose>
    <c:when test="${param.csView eq 'detail'}">
        <article class="cs-panel">
            <span class="cs-chip">공지</span>
            <h2 class="cs-article__title"><c:out value="${nOneList.noticeTitle}" /></h2>
            <div class="cs-meta">
                <span><c:out value="${nOneList.noticeDate}" /></span>
                <span>조회 <c:out value="${nOneList.noticeHits}" /></span>
            </div>
            <div class="cs-body"><c:out value="${nOneList.noticeText}" /></div>
            <div class="form-actions">
                <a class="btn btn--outline" href="${pageContext.request.contextPath}/NoticeProc.do">목록</a>
            </div>
        </article>
    </c:when>
    <c:otherwise>
        <section class="cs-panel">
            <div class="cs-panel__head">
                <span class="cs-chip">${param.csView eq 'search' ? '검색 결과' : '전체 공지'}</span>
            </div>
            <form class="cs-search" action="${pageContext.request.contextPath}/SearchNoticeProc.do" method="post">
                <select name="type" aria-label="공지 검색 항목" required>
                    <option value="">선택</option>
                    <option value="notice_title" ${type eq 'notice_title' ? 'selected' : ''}>제목으로 검색</option>
                    <option value="notice_text" ${type eq 'notice_text' ? 'selected' : ''}>내용으로 검색</option>
                </select>
                <input type="text" name="content" value="<c:out value='${content}'/>" placeholder="검색어를 입력해주세요" required>
                <input type="submit" value="검색">
                <input type="button" class="btn-all" value="전체보기" onclick="location.href='${pageContext.request.contextPath}/NoticeProc.do'">
            </form>
            <div class="cs-table-wrap">
                <table class="cs-table">
                    <thead><tr><th>제목</th><th>게시일</th><th class="is-center">조회수</th></tr></thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${empty nList}">
                                <tr><td class="cs-empty" colspan="3">등록된 공지사항이 없습니다.</td></tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="n" items="${nList}">
                                    <tr>
                                        <td>
                                            <button type="button" class="cs-acc" aria-expanded="false">
                                                <span><c:out value="${n.noticeTitle}" /></span>
                                                <span class="cs-acc__chev" aria-hidden="true"></span>
                                            </button>
                                        </td>
                                        <td class="is-muted"><c:out value="${n.noticeDate}" /></td>
                                        <td class="is-muted is-center"><c:out value="${n.noticeHits}" /></td>
                                    </tr>
                                    <tr class="cs-drop" hidden>
                                        <td colspan="3"><div class="cs-body"><c:out value="${n.noticeText}" /></div></td>
                                    </tr>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>
            <div class="cs-paging">
                <c:if test="${startpage gt pageBlock}">
                    <c:url var="prev" value="/${param.csView eq 'search' ? 'SearchNoticeProc.do' : 'NoticeProc.do'}">
                        <c:param name="pageNum" value="${startpage-pageBlock}" />
                        <c:if test="${param.csView eq 'search'}"><c:param name="type" value="${type}"/><c:param name="content" value="${content}"/></c:if>
                    </c:url>
                    <a href="${prev}">이전</a>
                </c:if>
                <c:if test="${not empty startpage and not empty endpage and startpage le endpage}">
                    <c:forEach var="i" begin="${startpage}" end="${endpage}">
                        <c:url var="purl" value="/${param.csView eq 'search' ? 'SearchNoticeProc.do' : 'NoticeProc.do'}">
                            <c:param name="pageNum" value="${i}" />
                            <c:if test="${param.csView eq 'search'}"><c:param name="type" value="${type}"/><c:param name="content" value="${content}"/></c:if>
                        </c:url>
                        <a href="${purl}" class="${i == param.pageNum || (empty param.pageNum && i == 1) ? 'is-current' : ''}"><c:out value="${i}" /></a>
                    </c:forEach>
                </c:if>
                <c:if test="${endpage lt pageCount}">
                    <c:url var="next" value="/${param.csView eq 'search' ? 'SearchNoticeProc.do' : 'NoticeProc.do'}">
                        <c:param name="pageNum" value="${startpage+pageBlock}" />
                        <c:if test="${param.csView eq 'search'}"><c:param name="type" value="${type}"/><c:param name="content" value="${content}"/></c:if>
                    </c:url>
                    <a href="${next}">다음</a>
                </c:if>
            </div>
        </section>
    </c:otherwise>
</c:choose>
