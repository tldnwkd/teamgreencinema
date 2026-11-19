<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    String menu = (String) request.getAttribute("mypageMenu");
    if (menu == null || menu.trim().isEmpty()) {
        menu = request.getParameter("menu");
    }
    String contentPage = "/user/my-page.jsp";

    if ("reserve".equals(menu)) {
        contentPage = "/user/my-page-reserve.jsp";
    } else if ("inquiry".equals(menu)) {
        contentPage = "/user/my-page-inquiry.jsp";
    } else if ("inquiry-one".equals(menu)) {
        contentPage = "/user/my-page-inquiry-one.jsp";
    } else if ("inquiry-edit".equals(menu)) {
        contentPage = "/user/my-page-inquiry-edit.jsp";
    } else if ("info".equals(menu)) {
        contentPage = "/user/my-page-info.jsp";
    } else if ("delete".equals(menu)) {
        contentPage = "/user/my-page-delete.jsp";
    } else if ("inquiry-write".equals(menu)) {
    	contentPage = "/user/my-page-inquiry-write.jsp";
    } else {
        menu = "home";
    }
%>

<div class="page-content">
  <div class="container">

    <!-- 마이페이지 전체를 좌우 2컬럼으로 묶어주는 래퍼 -->
    <div class="mypage-layout mypage-grid-root">
      
      <!-- [왼쪽 컬럼]: 타이틀 + 메뉴바를 함께 배치 -->
      <div class="mypage-left-column">
        <div class="page-heading">
          <p class="page-heading__eyebrow">MY PAGE</p>
          <h1 class="page-heading__title">마이페이지</h1>
          <p class="page-heading__description">
            ${empty userInfo.userName ? '회원' : userInfo.userName}님, 예매 내역과 문의, 회원 정보를 관리하는 화면입니다.
          </p>
        </div>

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
             class="<%= "inquiry".equals(menu) || "inquiry-one".equals(menu) || "inquiry-edit".equals(menu) ? "is-active" : "" %>">
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

          <a href="MyPageProc.do?userId=${sessionScope.id}&amp;menu=delete"
             class="side-nav__withdraw <%= "delete".equals(menu) ? "is-active" : "" %>">
            회원 탈퇴
          </a>
        </nav>
      </div>

      <!-- [오른쪽 컬럼]: 본문 내용이 최상단(메뉴바 상단 라인)부터 자연스럽게 시작 -->
      <div class="mypage-right-column">
        <jsp:include page="<%= contentPage %>" />
      </div>

    </div>

  </div>
</div>