<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<aside class="admin-side">
	<a class="admin-logo" href="${pageContext.request.contextPath}/admin/admin-index.jsp">GREEN<span>CINEMA</span><small>HOUSE DESK</small></a>
	<p class="admin-side__kicker">CONTROL</p>
	<nav class="admin-nav" aria-label="관리자 메뉴">
		
		<a class="${param.section == 'admin-movie.jsp' || param.section == 'admin-movie-form.jsp' ? 'is-active' : ''}" href="${pageContext.request.contextPath}/AdminMovieProc.do">영화관리<span class="admin-nav__count">${movieCount}</span></a>
		<a class="${param.section == 'admin-user.jsp' || param.section == 'admin-user-form.jsp' ? 'is-active' : ''}" href="${pageContext.request.contextPath}/UserProc.do">회원관리<span class="admin-nav__count">${userCount }</span></a>
		<a class="${param.section == 'admin-notice.jsp' || param.section == 'Admin-One-Notice.jsp' || param.section == 'Admin-Notice-Insert.jsp' ? 'is-active' : ''}" href="${pageContext.request.contextPath}/NoticeProc.do?id='${sessionScope.id }'">공지사항 관리<span class="admin-nav__count">${noticeCount}</span></a>
		<a class="${param.section == 'admin-inquiry.jsp' || param.section == 'Admin-Inquiry-Insert.jsp' ? 'is-active' : ''}" href="${pageContext.request.contextPath }/InquiryProc.do?id='${sessionScope.id }'">1:1 문의 관리<span class="admin-nav__count">${inquiryCount}</span></a>
		<a class="${param.section == 'admin-faq.jsp' || param.section == 'Admin-One-Faq.jsp' || param.section == 'Admin-FAQ-Insert.jsp' ? 'is-active' : ''}" href="${pageContext.request.contextPath}/FaqProc.do?id='${sessionScope.id}'">FAQ 관리<span class="admin-nav__count">${faqCount}</span></a>
	</nav>
	<div class="admin-side__foot">
		<a href="${pageContext.request.contextPath}/UserLogout.do">로그아웃</a>		
	</div>
</aside>
