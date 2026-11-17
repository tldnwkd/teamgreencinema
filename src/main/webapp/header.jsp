<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"%>
<%@ page import="java.sql.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

	<header class="site-header">
		<div class="container site-header__inner">
				<a class="logo" href="index.jsp" aria-label="그린시네마 홈">GREEN<span>CINEMA</span><small
					class="logo__sub">CINEMA FOR EVERYONE</small></a>
				<nav class="main-nav" aria-label="주 메뉴">
					<a href="index.jsp" aria-current="page">영화</a>
					<a href="selectMovieReserveProc.do">예매</a>
					<div class="nav-dropdown">
					    <button type="button" class="nav-dropdown__title">고객센터</button>
					    <div class="nav-dropdown__menu">
					        <a href="InquiryLoginchkProc.do">1:1 문의</a>
					        <a href="FaqProc.do">FAQ</a>
					        <a href="NoticeProc.do">공지사항</a>
					    </div>
					</div>
				</nav>
				<div class="header-actions">
					<c:if test="${empty sessionScope.id}">
						<a class="header-actions__link" href="index.jsp?section=user/login.jsp">로그인</a>
						<span class="header-actions__sep" aria-hidden="true">/</span>
						<a class="header-actions__link" href="index.jsp?section=user/user-join.jsp">회원가입</a>
					</c:if>
					<c:if test="${not empty sessionScope.id}">					
						<a class="header-pill" href="MyPageProc.do?userId=${sessionScope.id}">마이페이지</a>
						<a class="header-pill" href="UserLogout.do">로그아웃</a>
					</c:if>
				</div>
			</div>
		</header>
