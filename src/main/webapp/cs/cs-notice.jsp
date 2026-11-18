<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:choose>
    <c:when test="${param.csView eq 'detail'}">
        <section class="inquiry-form">
            <div class="form-grid">
                <div class="form-group form-group--full">
                    <p class="form-label">제목</p>
                    <p><c:out value="${nOneList.noticeTitle}" /></p>
                </div>
                <div class="form-group">
                    <p class="form-label">게시일</p>
                    <p><c:out value="${nOneList.noticeDate}" /></p>
                </div>
                <div class="form-group">
                    <p class="form-label">조회수</p>
                    <p><c:out value="${nOneList.noticeHits}" /></p>
                </div>
                <div class="form-group form-group--full">
                    <p class="form-label">공지사항 내용</p>
                    <textarea class="form-control" readonly><c:out value="${nOneList.noticeText}" /></textarea>
                </div>
            </div>
            <div class="form-actions">
                <a class="btn btn--outline" href="${pageContext.request.contextPath}/NoticeProc.do">공지 목록보기</a>
            </div>
        </section>
    </c:when>
    <c:otherwise>
        <section class="board-page board-page--notice ${param.csView eq 'search' ? 'is-search' : ''}">
            <form action="${pageContext.request.contextPath}/SearchNoticeProc.do" method="post">
                <select name="type" aria-label="공지 검색 항목" required>
                    <option value="">선택</option>
                    <option value="notice_title" ${type eq 'notice_title' ? 'selected' : ''}>제목으로 검색</option>
                    <option value="notice_text" ${type eq 'notice_text' ? 'selected' : ''}>내용으로 검색</option>
                </select>
                <input type="text" name="content" value="<c:out value='${content}'/>" placeholder="검색어를 입력해주세요" required>
                <input type="submit" value="검색">
                <input type="button" class="btn-all" value="전체보기"
                       onclick="location.href='${pageContext.request.contextPath}/NoticeProc.do'">
            </form>

            <table>
                <thead><tr><th>제목</th><th>게시일</th><th>조회수</th></tr></thead>
                <tbody>
                    <c:choose>
                        <c:when test="${empty nList}">
                            <tr><td colspan="3">등록된 공지사항이 없습니다.</td></tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="n" items="${nList}">
                                <tr>
                                    <td><a href="${pageContext.request.contextPath}/OneNoticeProc.do?noticeId=${n.noticeId}"><c:out value="${n.noticeTitle}" /></a></td>
                                    <td><c:out value="${n.noticeDate}" /></td>
                                    <td><c:out value="${n.noticeHits}" /></td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>

            <div class="paging">
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
                        <a href="${purl}"><c:out value="${i}" /></a>
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
