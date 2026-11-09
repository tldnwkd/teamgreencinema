<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<section id="reservations">
  <div class="section-header">
    <h2 class="section-title">예매 내역</h2>
  </div>

  <c:choose>
    <c:when test="${empty reserveList}">
      <div class="empty-state">
        <p class="empty-state__title">예매 내역이 없습니다</p>
        <p>예매한 영화가 있으면 날짜와 인원, 결제 금액이 여기에 표시됩니다.</p>
      </div>
    </c:when>
    <c:otherwise>
      <div class="table-scroll">
        <table class="data-table">
          <thead>
            <tr>
              <th>예매일</th>
              <th>인원</th>
              <th>결제 금액</th>
              <th>상태</th>
            </tr>
          </thead>
          <tbody>
            <c:forEach var="reserve" items="${reserveList}">
              <tr>
                <td>${reserve.reserveDate}</td>
                <td>성인 ${reserve.adultCount} · 청소년 ${reserve.teensCount}</td>
                <td>${reserve.totalPrice}원</td>
                <td>
                  <c:choose>
                    <c:when test="${empty reserve.cancelDate}">
                      <span class="status-badge status-badge--success">예매 완료</span>
                    </c:when>
                    <c:otherwise>
                      <span class="status-badge status-badge--cancelled">취소됨</span>
                    </c:otherwise>
                  </c:choose>
                </td>
              </tr>
            </c:forEach>
          </tbody>
        </table>
      </div>
    </c:otherwise>
  </c:choose>
</section>
