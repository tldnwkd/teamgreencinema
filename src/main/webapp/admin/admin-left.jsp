<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<aside class="admin-side">
	<a class="admin-logo" href="${pageContext.request.contextPath}/admin/admin-index.jsp">GREEN<span>CINEMA</span><small>HOUSE DESK</small></a>
	<p class="admin-side__kicker">CONTROL</p>
	<nav class="admin-nav" aria-label="관리자 메뉴">
		<a class="${empty param.section ? 'is-active' : ''}" href="${pageContext.request.contextPath}/admin/admin-index.jsp">대시보드</a>
		<a class="${param.section == 'admin-movie.jsp' ? 'is-active' : ''}" href="/greencinema/admin/admin-index.jsp?section=admin-movie.jsp">상영작 <span class="admin-nav__count">${movieCount}</span></a>
		<a class="${param.section == 'admin-notice.jsp' ? 'is-active' : ''}" href="${pageContext.request.contextPath}/NoticeProc.do?id='${sessionScope.id }'">공지사항 <span class="admin-nav__count">${noticeCount}</span></a>
		<a class="${param.section == 'admin-inquiry.jsp' ? 'is-active' : ''}" href="${pageContext.request.contextPath }/InquiryProc.do?id='${sessionScope.id }'">1:1 문의 <span class="admin-nav__count">${waitingCount}</span></a>
		<a class="${param.section == 'admin-faq.jsp' ? 'is-active' : ''}" href="${pageContext.request.contextPath}/FaqProc.do?id='${sessionScope.id}'">FAQ<span class="admin-nav__count">${faqCount}</span></a>
	</nav>
	<div class="admin-side__foot">
		<a href="${pageContext.request.contextPath}/UserLogout.do">로그아웃</a>
		<a href="${pageContext.request.contextPath}/index.jsp?section=user/login.jsp">다른 계정으로 로그인</a>
	</div>
</aside>
