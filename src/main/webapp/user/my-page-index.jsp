<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>

<%
    String menu = request.getParameter("menu");
    String contentPage = "/user/my-page.jsp";

    if ("reserve".equals(menu)) {
        contentPage = "/user/my-page-reserve.jsp";
    } else if ("inquiry".equals(menu)) {
        contentPage = "/user/my-page-inquiry.jsp";
    } else if ("info".equals(menu)) {
        contentPage = "/user/my-page-info.jsp";
    } else if ("inquiry-write".equals(menu)) {
    	contentPage = "/inquiry/inquiry.jsp";
    } else {
        menu = "home";
    }
%>

<div class="page-content">
  <div class="container">

    <div class="page-heading">
      <p class="page-heading__eyebrow">MY PAGE</p>
      <h1 class="page-heading__title">마이페이지</h1>
      <p class="page-heading__description">
        ${empty userInfo.userName ? '회원' : userInfo.userName}님, 예매 내역과 문의, 회원 정보를 관리하는 화면입니다.
      </p>
    </div>

    <div class="mypage-layout">
      <!-- 왼쪽 메뉴 -->
      <nav class="side-nav" aria-label="마이페이지 메뉴">
        <a href="MyPageProc.do?userId=${sessionScope.id}&amp;menu=home"
           class="<%= "home".equals(menu) ? "is-active" : "" %>">
          마이페이지 홈
        </a>

        <a href="MyPageProc.do?userId=${sessionScope.id}&amp;menu=reserve"
           class="<%= "reserve".equals(menu) ? "is-active" : "" %>">
          예매 내역
        </a>

        <a href="MyPageProc.do?userId=${sessionScope.id}&amp;menu=inquiry"
           class="<%= "inquiry".equals(menu) ? "is-active" : "" %>">
          1:1 문의 내역
        </a>

        <a href="MyPageProc.do?userId=${sessionScope.id}&amp;menu=inquiry-write"
           class="<%= "inquiry-write".equals(menu) ? "is-active" : "" %>">
          문의 작성
        </a>

        <a href="MyPageProc.do?userId=${sessionScope.id}&amp;menu=info"
           class="<%= "info".equals(menu) ? "is-active" : "" %>">
          내 정보
        </a>
      </nav>

      <!-- 오른쪽 본문 -->
      <div>
        <jsp:include page="<%= contentPage %>" />
      </div>
    </div>

  </div>
</div>