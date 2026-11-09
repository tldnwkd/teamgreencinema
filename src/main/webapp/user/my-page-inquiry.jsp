<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<section id="my-inquiries">
  <div class="section-header">
    <h2 class="section-title">1:1 문의 내역</h2>
    <a href="MyPageProc.do?userId=${sessionScope.id}&amp;menu=inquiry-write" class="btn btn--outline btn--small">문의 작성</a>
  </div>

  <c:choose>
    <c:when test="${empty inquiryList}">
      <div class="empty-state">
        <p class="empty-state__title">문의 내역이 없습니다</p>
        <p>남긴 문의와 답변 상태가 여기에 모입니다.</p>
      </div>
    </c:when>
    <c:otherwise>
      <div class="table-scroll">
        <table class="data-table">
          <thead>
            <tr>
              <th>번호</th>
              <th>분류</th>
              <th>종류</th>
              <th>제목</th>
              <th>답변상태</th>
            </tr>
          </thead>
          <tbody>
            <c:forEach var="item" items="${inquiryList}">
              <tr>
                <td>${item.inquiryId}</td>
                <td>${item.inquirySort}</td>
                <td>${item.inquiryType}</td>
                <td>
                  <a href="OneInquiryProc.do?inquiryId=${item.inquiryId}&amp;answerStatus=${item.answerStatus}">${item.inquiryTitle}</a>
                </td>
                <td>
                  <span class="status-badge ${item.answerStatus == 0 ? 'status-badge--pending' : 'status-badge--success'}">
                    ${item.answerStatus == 0 ? '답변대기' : '답변완료'}
                  </span>
                </td>
              </tr>
            </c:forEach>
          </tbody>
        </table>
      </div>
    </c:otherwise>
  </c:choose>
</section>
