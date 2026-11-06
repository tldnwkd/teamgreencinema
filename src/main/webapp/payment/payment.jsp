<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<link rel="stylesheet" href="css/reserve-movie.css">
<link rel="stylesheet" href="css/reserve-payment.css">

<div class="page-content">
    <div class="container">

        <div class="page-heading">
            <p class="page-heading__eyebrow">TICKET BOOKING</p>
            <h1 class="page-heading__title">결제</h1>
        </div>

        <ol class="booking-steps" aria-label="예매 진행 단계">
            <li class="booking-step is-complete"><span class="step-num">01</span> 영화·극장 선택</li>
            <li class="booking-step is-complete"><span class="step-num">02</span> 인원·좌석 선택</li>
            <li class="booking-step is-current"><span class="step-num">03</span> 결제</li>
            <li class="booking-step"><span class="step-num">04</span> 예매 완료</li>
        </ol>

        <!-- [중요] 모든 데이터와 버튼이 form 태그 내부에 안전하게 포함되어야 합니다 -->
        <form action="reserveCompleteProc.do" method="POST" onsubmit="return validatePayment()">
            
            <!-- 서버로 넘길 히든 파라미터들 -->
            <input type="hidden" name="large_region" value="${param.large_region}">
            <input type="hidden" name="smallRegion" value="${param.smallRegion}">
            <input type="hidden" name="movieId" value="${rjdto.movieId}">
            <input type="hidden" name="selectedDate" value="${param.selectedDate}">
            <input type="hidden" name="scheduleSTime" value="${param.scheduleSTime}">
            <input type="hidden" name="scheduleETime" value="${param.scheduleETime}">
            <input type="hidden" name="adultcount" value="${param.adultcount}">
            <input type="hidden" name="precount" value="${param.precount}">
            <input type="hidden" name="seats" value="${param.seats}">
            <input type="hidden" name="screenId" value="${param.screenId}">
            
            <!-- [해결] 중복을 피하기 위해 id를 input-total-price로 명확히 분리 -->
            <input type="hidden" name="totalprice" id="input-total-price" value="0">

            <div class="payment-three-column-layout">
                
                <!-- [1] 왼쪽 영역: 예매 정보 -->
                <div class="payment-col-left">
                    <section class="booking-panel payment-panel-fix">
                        <div class="summary-kicker">PAYMENT SUMMARY</div>
                        <h2 class="booking-summary__title">예매 정보</h2>
                        
                        <div class="summary-movie">
                            <c:if test="${not empty rjdto.imgPath }">
                                <img src="./${rjdto.imgPath }" alt="선택 영화">
                            </c:if>
                            <div>
                                <span class="movie-rate-badge ${rjdto.movieRate==12?'yellow':rjdto.movieRate==15?'orange':rjdto.movieRate==19?'red':'green' }">
                                    <c:choose>
                                        <c:when test="${rjdto.movieRate==19}">19</c:when>
                                        <c:when test="${rjdto.movieRate==15}">15</c:when>
                                        <c:when test="${rjdto.movieRate==12}">12</c:when>
                                        <c:otherwise>ALL</c:otherwise>
                                    </c:choose>
                                </span>
                                <strong class="summary-movie-title">${rjdto.movieTitle }</strong>
                                <p class="summary-movie-runtime"><span>🕒</span> ${rjdto.runTime }분</p>
                            </div>
                        </div>

                        <div class="booking-summary__row">
                            <span class="booking-summary__label">일시</span>
                            <strong class="booking-summary__value summary-datetime-val">${param.selectedDate}<br/>${fn:substring(param.scheduleSTime, 11, 16)} ~ ${fn:substring(param.scheduleETime, 11, 16)}</strong>
                        </div>

                        <div class="booking-summary__row">
                            <span class="booking-summary__label">영화관</span>
                            <strong class="booking-summary__value">그린 시네마 ${param.smallRegion}</strong>
                        </div>

                        <div class="booking-summary__row">
                            <span class="booking-summary__label">관람인원</span>
                            <strong class="booking-summary__value">
                                <c:set var="adult" value="${empty param.adultcount ? 0 : param.adultcount}" />
                                <c:set var="pre" value="${empty param.precount ? 0 : param.precount}" />
                                <c:if test="${adult > 0}">성인 ${adult}명 </c:if>
                                <c:if test="${pre > 0}">청소년 ${pre}명</c:if>
                            </strong>
                        </div>

                        <div class="booking-summary__row">
                            <span class="booking-summary__label">선택좌석</span>
                            <strong class="booking-summary__value summary-seat-val">${param.seats}</strong>
                        </div>
                    </section>
                </div>

                <!-- [2] 가운데 영역: 최종 결제수단 -->
                <div class="payment-col-center">
                    <section class="booking-panel payment-panel-fix">
                        <div class="booking-panel__title payment-title-between">
                            <h2><span class="number-kicker">01</span> 최종 결제수단</h2>
                            <button type="button" onclick="location.reload()" class="reset-btn">&#8635; 초기화</button>
                        </div>
                        
                        <div class="pay-method-grid">
                            <label class="pay-method-card">
                                <input type="radio" name="payMethod" value="1" checked class="pay-radio-hidden">
                                <span class="pay-method-text">신용카드</span>
                            </label>
                            <label class="pay-method-card">
                                <input type="radio" name="payMethod" value="2" class="pay-radio-hidden">
                                <span class="pay-method-text">계좌이체</span>
                            </label>
                        </div>
                    </section>
                </div>

                <!-- [3] 오른쪽 영역: 결제하기 및 금액 요약 -->
                <div class="payment-col-right">
                    <aside class="booking-summary payment-summary-fix">
                        <h2 class="booking-summary__title"><span class="number-kicker">02</span> 결제 하기</h2>
                        
                        <div class="payment-summary-bottom-section">
                            <div class="agree-checkbox-wrap">
                                <label class="agree-label">
                                    <input type="checkbox" id="agree-check"> 예매 취소 및 환불 정보 동의
                                </label>
                            </div>

                            <div class="booking-summary__total payment-calc-box">
                                <div class="calc-row-item">
                                    <span>상품금액</span>
                                    <span id="display-goods-price">0원</span>
                                </div>
                                <div class="calc-row-item discount-row">
                                    <span>할인금액</span>
                                    <span>- 0원</span>
                                </div>
                                <div class="calc-row-item total-final-row">
                                    <span>총 결제금액</span>
                                    <!-- 화면 표시 전용 span ID -->
                                    <span id="display-total-price" class="total-price-color">0원</span>
                                </div>
                            </div>
                        </div>

                        <p class="summary-footnote">모든 항목을 확인한 후 결제를 진행하세요.</p>

                        <!-- 결제하기 버튼 -->
                        <button type="submit" class="btn btn--primary btn--block btn--large payment-submit-btn-green">
                            결제하기 ↗
                        </button>
                    </aside>
                </div>

            </div>
        </form>

    </div>
</div>

<script>
    let adultCount = parseInt("${empty param.adultcount ? 0 : param.adultcount}");
    let preCount = parseInt("${empty param.precount ? 0 : param.precount}");
    
    // 성인 12,000원, 청소년(pre) 8,000원 계산
    let totalPrice = (adultCount * 12000) + (preCount * 8000);
    
    // 화면에 텍스트 표시
    document.getElementById('display-goods-price').innerText = totalPrice.toLocaleString() + '원';
    document.getElementById('display-total-price').innerText = totalPrice.toLocaleString() + '원';
    
    // 서버로 전송될 hidden input에 정확한 숫자 대입
    document.getElementById('input-total-price').value = totalPrice;

    function validatePayment() {
        let agreeCheck = document.getElementById('agree-check');
        if (!agreeCheck.checked) {
            alert("예매 취소 및 환불 정보에 동의해주세요.");
            agreeCheck.focus();
            return false;
        }
        return confirm("결제를 진행하시겠습니까?");
    }
</script>