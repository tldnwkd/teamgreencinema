<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>           

            <!-- 예매 내역 섹션 -->
            <section id="reservations">
              <div class="section-header">
                <h2 class="section-title">예매 내역</h2>
              </div>

              <c:choose>
                <c:when test="${empty myPage or empty myPage.movieTitle}">
                  <div class="empty-state">
                    <p class="empty-state__title">예매 내역이 없습니다</p>
                    <p>영화 예매 후 이곳에서 확인할 수 있습니다.</p>
                  </div>
                </c:when>
                <c:otherwise>
              <div class="reservation-list">
                <article class="reservation-card">
                  <img class="reservation-card__poster" src="./${myPage.imgPath}" alt="${myPage.movieTitle }">
                  <div>
                    <h3 class="reservation-card__title">${myPage.movieTitle }</h3>
                    <p class="reservation-card__detail">그린시네마 ${myPage.region} · ${myPage.screenNum }관</p>
                    <p class="reservation-card__detail">${myPage.scheduleStarttime }</p>
                    <p class="reservation-card__detail">
						<c:if test="${myPage.adultCount > 0 }">						                    	
                    		성인 ${myPage.adultCount}명
                    	</c:if>
                    	<c:if test="${myPage.teensCount > 0 }">						                    	
                    		청소년 ${myPage.teensCount}명
                    	</c:if>
                    	 · ${myPage.seatNum}
                    </p>
                    <p class="reservation-card__detail">${myPage.totalPrice }원 · ${myPage.paymentMethod} 결제</p>
                  </div>
                  <div class="reservation-card__actions">
                    <span class="status-badge ${myPage.paymentStatus eq '취소됨' ? 'status-badge--cancelled' : 'status-badge--success'}">${myPage.paymentStatus }</span>
                    <c:if test="${myPage.paymentStatus ne '취소됨'}">
                      <span class="form-help">
                        <a href="ReserveCancel.do?reserveId=${myPage.reserveId}"
                           onclick="return confirm('이 예매를 취소하시겠습니까?');">취소</a>
                      </span>
                    </c:if>
                  </div>
                </article>
              </div>
                </c:otherwise>
              </c:choose>
            </section>

            <!-- 1:1 문의내역 섹션 -->
            <section id="my-inquiries" class="stack-section">
              <div class="section-header">
                <h2 class="section-title">1:1 문의내역</h2>
                <a href="index.jsp?section=inquiry/inquiry.jsp" class="btn btn--outline btn--small">문의 작성</a>
              </div>

              <c:choose>
                <c:when test="${empty inquiry or inquiry.inquiryId == 0}">
                  <div class="empty-state">
                    <p class="empty-state__title">문의 내역이 없습니다</p>
                    <p>궁금한 점은 1:1 문의로 남겨 주세요.</p>
                  </div>
                </c:when>
                <c:otherwise>
                  <div class="table-scroll">
                    <table class="data-table">
                      <thead>
                        <tr>
                          <th>문의번호</th>
                          <th>분류</th>
                          <th>제목</th>
                          <th>답변상태</th>
                        </tr>
                      </thead>
                      <tbody>
                        <tr>
                          <td>${inquiry.inquiryId }</td>
                          <td>${inquiry.inquirySort }</td>
                          <td>${inquiry.inquiryTitle }</td>
                          <td>
                            <span class="status-badge ${inquiry.answerStatus == 0 ? 'status-badge--pending' : 'status-badge--success'}">
                              ${inquiry.answerStatus == 0 ? "답변대기" : "답변완료" }
                            </span>
                          </td>
                        </tr>
                      </tbody>
                    </table>
                  </div>
                </c:otherwise>
              </c:choose>
            </section>
