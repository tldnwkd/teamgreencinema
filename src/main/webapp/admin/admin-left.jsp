<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    
<aside class="admin-side">
			<a class="admin-logo" href="${pageContext.request.contextPath}/admin/admin-index.jsp">GREEN<span>CINEMA</span><small>HOUSE DESK</small></a>
			<p class="admin-side__kicker">CONTROL</p>
			<nav class="admin-nav" aria-label="관리자 메뉴">
				<a class="is-active" href="#overview">대시보드</a>
				<a href="admin-index.jsp?section=admin-movie.jsp">상영작 <span class="admin-nav__count">${movieCount}</span></a>
				<a href="admin-index.jsp?section=admin-notice.jsp">공지사항 <span class="admin-nav__count">${noticeCount}</span></a>
				<a href="admin-index.jsp?section=admin-inquiry.jsp">1:1 문의 <span class="admin-nav__count">${waitingCount}</span></a>
				<a href="admin-index.jsp?section=admin-faq.jsp">FAQ <span class="admin-nav__count">${faqCount}</span></a>
			</nav>
			<div class="admin-side__foot">
				<a href="${pageContext.request.contextPath}/UserLogout.do">로그아웃</a>
				<a href="${pageContext.request.contextPath}/index.jsp?section=user/login.jsp">다른 계정으로 로그인</a>
			</div>
		</aside>