<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:choose>
    <c:when test="${param.csView eq 'detail'}">
        <article class="cs-panel">
            <div class="cs-meta">
                <span><c:out value="${idto.inquiryType}" /></span>
                <span><c:out value="${idto.inquirySort}" /></span>
                <span class="cs-status ${idto.answerStatus eq 1 ? 'is-done' : 'is-wait'}">${idto.answerStatus eq 1 ? '답변 완료' : '답변 대기'}</span>
            </div>
            <h2 class="cs-article__title"><c:out value="${idto.inquiryTitle}" /></h2>
            <div class="cs-body"><c:out value="${idto.inquiryContent}" /></div>
            <c:if test="${idto.answerStatus eq 1}">
                <div class="cs-answer">
                    <span class="cs-chip">답변</span>
                    <div class="cs-body"><c:out value="${idto.answerContent}" /></div>
                </div>
            </c:if>
            <p class="cs-meta" style="margin-top:16px">
                <span>수신 ${idto.receptionType eq 1 ? 'Email' : (idto.receptionType eq 2 ? 'SMS' : '-')}</span>
            </p>
            <form action="${pageContext.request.contextPath}/OneInquiryProc.do" method="post">
                <input type="hidden" name="inquiryId" value="${idto.inquiryId}">
                <input type="hidden" name="id" value="${sessionScope.id}">
                <div class="form-actions">
                    <a class="btn btn--outline" href="${pageContext.request.contextPath}/InquiryProc.do">목록</a>
                    <c:if test="${idto.answerStatus eq 0}">
                        <button class="btn btn--primary" name="btn" type="submit" value="upd">수정</button>
                    </c:if>
                    <button class="btn btn--outline" name="btn" type="submit" value="del" onclick="return confirm('정말 삭제하시겠습니까?');">삭제</button>
                </div>
            </form>
        </article>
    </c:when>

    <c:when test="${param.csView eq 'edit'}">
        <section class="cs-panel">
            <div class="cs-panel__head"><span class="cs-chip">문의 수정</span></div>
            <form action="${pageContext.request.contextPath}/InquiryInsertProc.do" method="post">
                <input type="hidden" name="id" value="${sessionScope.id}">
                <input type="hidden" name="inquiryId" value="${idto.inquiryId}">
                <input type="hidden" name="btn" value="updOk">
                <div class="form-grid">
                    <div class="form-group">
                        <p class="form-label">문의 분류</p>
                        <p><c:out value="${idto.inquirySort}" /></p>
                    </div>
                    <div class="form-group">
                        <p class="form-label">문의 종류</p>
                        <p><c:out value="${idto.inquiryType}" /></p>
                    </div>
                    <div class="form-group form-group--full">
                        <label class="form-label" for="inqTitle">문의 제목</label>
                        <input class="form-control" id="inqTitle" name="inquiryTitle" maxlength="30" value="<c:out value='${idto.inquiryTitle}'/>" required>
                    </div>
                    <div class="form-group form-group--full">
                        <label class="form-label" for="inqText">문의 내용</label>
                        <textarea class="form-control" id="inqText" name="inquiryContent" required><c:out value="${idto.inquiryContent}" /></textarea>
                    </div>
                </div>
                <div class="form-actions">
                    <a class="btn btn--outline" href="${pageContext.request.contextPath}/OneInquiryProc.do?inquiryId=${idto.inquiryId}">취소</a>
                    <button class="btn btn--primary" type="submit" onclick="return confirm('수정을 완료하시겠습니까?');">수정</button>
                </div>
            </form>
        </section>
    </c:when>

    <c:when test="${param.csView eq 'list' or param.csView eq 'search'}">
        <section class="cs-panel">
            <div class="cs-panel__head">
                <span class="cs-chip">${param.csView eq 'search' ? '검색 결과' : '내 문의'}</span>
                <a class="btn btn--primary" href="${pageContext.request.contextPath}/index.jsp?section=cs/cs-index.jsp&amp;csSection=inquiry">문의 작성</a>
            </div>
            <form class="cs-search" action="${pageContext.request.contextPath}/SearchInquiryProc.do" method="get">
                <select name="type" aria-label="문의 검색 항목" required>
                    <option value="">선택</option>
                    <option value="inquiry_type" ${type eq 'inquiry_type' ? 'selected' : ''}>문의 종류</option>
                    <option value="inquiry_Sort" ${type eq 'inquiry_Sort' ? 'selected' : ''}>문의 분류</option>
                    <option value="inquiry_title" ${type eq 'inquiry_title' ? 'selected' : ''}>제목</option>
                </select>
                <input type="text" name="content" value="<c:out value='${content}'/>" placeholder="검색어를 입력해주세요" required>
                <input type="submit" value="검색">
                <input class="btn-all" type="button" value="전체보기" onclick="location.href='${pageContext.request.contextPath}/InquiryProc.do'">
            </form>
            <div class="cs-table-wrap">
                <table class="cs-table">
                    <thead><tr><th>종류</th><th>분류</th><th>제목</th><th>상태</th></tr></thead>
                    <tbody>
                        <c:set var="rows" value="${param.csView eq 'search' ? sList : iList}" />
                        <c:choose>
                            <c:when test="${empty rows}">
                                <tr><td class="cs-empty" colspan="4">문의 내역이 없습니다.</td></tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="item" items="${rows}">
                                    <tr>
                                        <td><c:out value="${item.inquiryType}" /></td>
                                        <td><c:out value="${item.inquirySort}" /></td>
                                        <td><a href="${pageContext.request.contextPath}/OneInquiryProc.do?inquiryId=${item.inquiryId}"><c:out value="${item.inquiryTitle}" /></a></td>
                                        <td>
                                            <a class="cs-status ${item.answerStatus eq 1 ? 'is-done' : 'is-wait'}" href="${pageContext.request.contextPath}/OneInquiryProc.do?inquiryId=${item.inquiryId}">
                                                ${item.answerStatus eq 1 ? '답변 완료' : '답변 대기'}
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>
            <div class="cs-paging">
                <c:if test="${startpage gt pageBlock}">
                    <c:url var="prev" value="/${param.csView eq 'search' ? 'SearchInquiryProc.do' : 'InquiryProc.do'}">
                        <c:param name="pageNum" value="${startpage-pageBlock}" />
                        <c:if test="${param.csView eq 'search'}"><c:param name="type" value="${type}"/><c:param name="content" value="${content}"/></c:if>
                    </c:url>
                    <a href="${prev}">이전</a>
                </c:if>
                <c:if test="${not empty startpage and not empty endpage and startpage le endpage}">
                    <c:forEach var="i" begin="${startpage}" end="${endpage}">
                        <c:url var="purl" value="/${param.csView eq 'search' ? 'SearchInquiryProc.do' : 'InquiryProc.do'}">
                            <c:param name="pageNum" value="${i}" />
                            <c:if test="${param.csView eq 'search'}"><c:param name="type" value="${type}"/><c:param name="content" value="${content}"/></c:if>
                        </c:url>
                        <a href="${purl}" class="${i == param.pageNum || (empty param.pageNum && i == 1) ? 'is-current' : ''}"><c:out value="${i}" /></a>
                    </c:forEach>
                </c:if>
                <c:if test="${endpage lt pageCount}">
                    <c:url var="next" value="/${param.csView eq 'search' ? 'SearchInquiryProc.do' : 'InquiryProc.do'}">
                        <c:param name="pageNum" value="${startpage+pageBlock}" />
                        <c:if test="${param.csView eq 'search'}"><c:param name="type" value="${type}"/><c:param name="content" value="${content}"/></c:if>
                    </c:url>
                    <a href="${next}">다음</a>
                </c:if>
            </div>
        </section>
    </c:when>

    <c:otherwise>
        <section class="cs-panel">
            <div class="cs-panel__head"><span class="cs-chip">새 문의</span></div>
            <form action="${pageContext.request.contextPath}/InquiryInsertProc.do" method="post" name="iform">
                <div class="form-grid">
                    <div class="form-group">
                        <label for="inqSort" class="form-label">문의 분류</label>
                        <select id="inqSort" name="inquirySort" class="form-control" required>
                            <option value="">선택</option>
                            <option value="영화관">영화관</option>
                            <option value="회원정보">회원정보</option>
                            <option value="예매/결제">예매/결제</option>
                            <option value="이벤트">이벤트</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="inqType" class="form-label">문의 종류</label>
                        <select id="inqType" name="inquiryType" class="form-control" required>
                            <option value="">선택</option>
                            <option value="문의">문의</option>
                            <option value="칭찬">칭찬</option>
                            <option value="불만">불만</option>
                            <option value="건의">건의</option>
                        </select>
                    </div>
                    <div class="form-group form-group--full">
                        <label for="inqTitle" class="form-label">문의 제목</label>
                        <input id="inqTitle" class="form-control" name="inquiryTitle" maxlength="30" placeholder="제목을 입력하세요" required>
                    </div>
                    <div class="form-group form-group--full">
                        <label for="inqText" class="form-label">문의 내용</label>
                        <textarea id="inqText" class="form-control" name="inquiryContent" placeholder="문의 내용을 입력하세요" required></textarea>
                    </div>
                    <div class="form-group form-group--full">
                        <label for="inqReception" class="form-label">답변 수신 방법</label>
                        <select id="inqReception" name="receptionType" class="form-control" required>
                            <option value="">선택</option>
                            <option value="1">Email</option>
                            <option value="2">SMS</option>
                        </select>
                    </div>
                </div>
                <div class="form-actions">
                    <input type="hidden" name="id" value="${sessionScope.id}">
                    <input type="hidden" name="btn" value="inq">
                    <button type="button" class="btn btn--outline" onclick="csMyInquiry()">내 문의</button>
                    <button type="button" class="btn btn--primary" onclick="csSubmitInquiry()">문의 등록</button>
                </div>
            </form>
        </section>
        <script>
        function csMyInquiry() {
            const f = document.forms['iform'];
            if (!f.elements['id'].value.trim()) {
                alert('로그인 후 이용해주세요');
                location.href = '${pageContext.request.contextPath}/index.jsp?section=user/login.jsp';
                return;
            }
            location.href = '${pageContext.request.contextPath}/InquiryProc.do';
        }
        function csSubmitInquiry() {
            const f = document.forms['iform'];
            if (!f.elements['id'].value.trim()) {
                alert('로그인 후 이용해주세요');
                location.href = '${pageContext.request.contextPath}/index.jsp?section=user/login.jsp';
                return;
            }
            if (!f.reportValidity()) return;
            if (confirm('1:1문의를 신청하시겠습니까?')) f.submit();
        }
        </script>
    </c:otherwise>
</c:choose>
