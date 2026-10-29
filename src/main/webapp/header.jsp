<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"%>
<%@ page import="java.sql.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

	<header class="site-header">
		<div class="container site-header__inner">
				<a class="logo" href="index.jsp" aria-label="그린시네마 홈">GREEN<span>CINEMA</span><small
					class="logo__sub">CINEMA FOR EVERYONE</small></a>
				<nav class="main-nav" aria-label="주 메뉴">
					<a href="index.jsp?section=movie/movie-list.jsp" aria-current="page">영화</a>
					<a href="index.jsp?section=reserve/reserve.jsp">예매</a>
					<a href="index.jsp?section=theater/theater.jsp">극장</a>
					<a href="index.jsp?section=customer-service.jsp">고객센터</a>
				</nav>
				<div class="header-actions">
					<a class="header-actions__link" href="index.jsp?section=member/login.jsp">로그인</a><span
						class="header-actions__sep" aria-hidden="true">/</span><a
						class="header-actions__link" href="index.jsp?section=member/member-join.jsp">회원가입</a><a
						class="header-pill" href="index.jsp?section=member/my-page.jsp">마이페이지</a>
				</div>
			</div>
		</header>
