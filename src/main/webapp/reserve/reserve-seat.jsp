<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<!-- 단독 CSS 파일 연결 -->
<link rel="stylesheet" href="css/reserve-seat.css">

<div class="page-content">
	<div class="container">

		<div class="page-heading">
			<p class="page-heading__eyebrow">TICKET BOOKING</p>
			<h1 class="page-heading__title">인원 · 좌석 선택</h1>
		</div>

		<!-- 상단 단계 표시 바 -->
		<ol class="booking-steps" aria-label="예매 진행 단계">
			<li class="booking-step is-complete"><span class="step-num">01</span> 영화·극장 선택</li>
			<li class="booking-step is-current"><span class="step-num">02</span> 인원·좌석 선택</li>
			<li class="booking-step"><span class="step-num">03</span> 결제</li>
			<li class="booking-step"><span class="step-num">04</span> 예매 완료</li>
		</ol>

		<div class="booking-layout">
			<!-- [좌측 메인 영역] -->
			<div class="booking-main">

				<!-- 01 관람인원 선택 패널 -->
				<section class="booking-panel">
					<div class="booking-panel__title">
						<h3><span class="number-kicker">01</span> 관람인원 선택</h3>
						<button type="button" class="reset-btn" onclick="reset()">&#8635; 초기화</button>
					</div>
					<div class="ticket-types">
						<!-- 성인 영역 -->
						<div class="ticket-counter">
							<div>
								<div class="ticket-row" id="adultwrap">
									<span>성인</span>
									<div class="counter-btns">
										<button type="button" id="adultminus" onclick="adultminus()">-</button>
										<button type="button" id="adult" class="counter-num-btn">0</button>
										<button type="button" id="adultplus" onclick="adultplus()">+</button>
									</div>
								</div>
							</div>
						</div>

						<!-- 청소년 영역 -->
						<div class="ticket-counter">
							<div>
								<div class="ticket-row" id="prewrap">
									<span>청소년</span>
									<div class="counter-btns">
										<button type="button" id="preminus" onclick="preminus()">-</button>
										<button type="button" id="pre" class="counter-num-btn">0</button>
										<button type="button" id="preplus" onclick="preplus()">+</button>
									</div>
								</div>
							</div>
						</div>
					</div>
				</section>

				<!-- 02 좌석 선택 패널 -->
				<section class="booking-panel">
					<h2 class="booking-panel__title">
						<span class="number-kicker">02</span> 좌석 선택
					</h2>
					<div class="seat-layout">
						<div class="screen-indicator">SCREEN</div>
						<div class="seat-grid" role="group" aria-label="좌석 선택 영역">
							<span class="seat-choice">
								<div class="seat" id="seatwrap"></div>
							</span>
						</div>
						<!-- 좌석 범례 -->
						<div class="seat-legend">
							<div class="seat-legend-item"><span class="seat-legend-box selected"></span>선택</div>
							<div class="seat-legend-item">
								<span class="seat-legend-box completed">✕</span>예매완료
							</div>
							<div class="seat-legend-item"><span class="seat-legend-box normal"></span>일반</div>
						</div>
					</div>
				</section>

			</div>

			<!-- [우측 예매 정보 요약 사이드바] -->
			<aside class="booking-summary">
				<div class="summary-kicker">SEAT SELECTION</div>
				<h2 class="booking-summary__title">예매 정보</h2>
				
				<div class="summary-movie">
					<c:if test="${not empty rjdto.imgPath }">
						<img src="./${rjdto.imgPath }" alt="선택 영화">
					</c:if>
					<div>
						<strong>${rjdto.movieTitle }</strong>
						<p class="summary-movie__runtime"><span>🕒</span> ${rjdto.runTime }분</p>
					</div>
				</div>

				<div class="booking-summary__row">
					<span class="booking-summary__label">극장</span>
					<strong class="booking-summary__value">
						<c:choose>
							<c:when test="${not empty param.smallRegion}">그린 시네마 ${param.smallRegion}</c:when>
							<c:otherwise>미선택</c:otherwise>
						</c:choose>
					</strong>
				</div>

				<div class="booking-summary__row">
					<span class="booking-summary__label">상영일</span>
					<strong class="booking-summary__value">
						<c:choose>
							<c:when test="${not empty param.selectedDate}">${param.selectedDate}</c:when>
							<c:otherwise>미선택</c:otherwise>
						</c:choose>
					</strong>
				</div>

				<div class="booking-summary__row">
					<span class="booking-summary__label">상영시간</span>
					<strong class="booking-summary__value">
						<c:choose>
							<c:when test="${not empty param.scheduleSTime}">
								${fn:substring(param.scheduleSTime, 11, 16)}~${fn:substring(param.scheduleETime, 11, 16)}
							</c:when>
							<c:otherwise>미선택</c:otherwise>
						</c:choose>
					</strong>
				</div>

				<!-- 성인 / 청소년 인원수 각각 분리 표시 -->
				<div class="booking-summary__row">
					<span class="booking-summary__label">관람인원</span>
					<strong class="booking-summary__value" id="summary-people-count">
						성인 0명, 청소년 0명
					</strong>
				</div>

				<div class="booking-summary__row">
					<span class="booking-summary__label">선택좌석</span>
					<strong class="booking-summary__value booking-summary__value--highlight" id="seatnumber">
						미선택
					</strong>
				</div>

				<div class="booking-summary__total">
					<span>총 합계</span> 
					<span class="booking-summary__amount" id="summary-total-price">0원</span>
				</div>

				<p class="summary-footnote">모든 항목을 선택한 후 결제 단계로 이동하세요.</p>

				<!-- 이전 / 결제하기 버튼 영역 -->
				<div class="summary-actions">
					<button type="button" onclick="back()" class="btn-summary-back">이전</button>
					
					<form action="reservePaymentProc.do" method="GET" onsubmit="return validateForm()" class="form-summary-submit">
						<input type="hidden" name="large_region" value="${param.large_region}">
						<input type="hidden" name="smallRegion" value="${param.smallRegion}">
						<input type="hidden" name="movieId" value="${rjdto.movieId}">
						<input type="hidden" name="selectedDate" value="${param.selectedDate}">
						<input type="hidden" name="scheduleSTime" value="${param.scheduleSTime}">
						<input type="hidden" name="scheduleETime" value="${param.scheduleETime}">
						<input type="hidden" name="screenId" value="${param.screenId}">
						<input type="hidden" name="scheduleId" value="${param.scheduleId}"> <!-- 💡 회차 ID 전달용 히든 인풋 추가 -->					
						<input type="hidden" name="adultcount" id="form-adultcount" value="0">
						<input type="hidden" name="precount" id="form-precount" value="0">
						<input type="hidden" name="seats" id="form-seats" value="">          
						
						<button type="submit" id="nextMoveBtn" class="btn-summary-next" disabled>결제 페이지 ↗</button>
					</form>
				</div>
			</aside>
		</div>

	</div>
</div>

<script>
    let completedSeats = [
        <c:forEach items="${rjlist05}" var="seat" varStatus="status">
            "${fn:trim(seat.seatNum)}"<c:if test="${!status.last}">,</c:if>
        </c:forEach>
    ].map(seat => {
        let match = seat.match(/^([A-Za-z]+)(\d+)$/);
        return match ? match[1] + parseInt(match[2], 10) : seat;
    });

    let seatwrap = document.getElementById('seatwrap');
    let seatnumber = document.getElementById('seatnumber');
    let adult = document.getElementById('adult');
    let pre = document.getElementById('pre');
    let summaryPeopleCount = document.getElementById('summary-people-count');
    let summaryTotalPrice = document.getElementById('summary-total-price');
    let nextMoveBtn = document.getElementById('nextMoveBtn');
    
    let formAdultCount = document.getElementById('form-adultcount');
    let formPreCount = document.getElementById('form-precount');
    let formSeats = document.getElementById('form-seats');
    
    let adultcount = 0;
    let precount = 0;
    let maxcount = 0;
    let adultprice = 12000; 
    let teenprice = 8000;    

    let arry = Array.from(Array(10), () => new Array(10).fill(0));
    let arryeng = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J'];
    let seatresult = new Array(8).fill('-');

    function render() {
        let result = '<table class="seattable">';
        for (let i = 0; i < arry.length; i++) {
            result += '<tr>';
            result += '<td class="seat-row-label">' + arryeng[i] + '</td>';
            
            for (let j = 0; j < arry[i].length; j++) {
                let seatNumVal = j + 1;
                let seatName = arryeng[i] + seatNumVal;
                
                let isCompleted = completedSeats.includes(seatName);
                let isActive = seatresult.includes(seatName) ? ' active' : '';
                
                if (isCompleted) {
                    result += '<td><div class="seatnum completed">✕</div></td>';
                } else {
                    result += '<td><div class="seatnum' + isActive + '" onclick="choicerender(' + i + ', ' + j + ')">' + seatNumVal + '</div></td>';
                }
            }
            result += '</tr>';
        }
        result += '</table>';

        seatwrap.innerHTML = result;
    }

    function seatrender() {
        let count = 0;
        let selectedArr = [];
        for (let i = 0; i < seatresult.length; i++) {
            if (seatresult[i] !== '-') {
                selectedArr.push(seatresult[i]);
                count++;
            }
        }
        
        if (count === 0) {
            seatnumber.innerHTML = "미선택";
        } else {
            seatnumber.innerHTML = selectedArr.join(', ');
        }

        let totalPeople = adultcount + precount;
        if(summaryPeopleCount) {
            summaryPeopleCount.innerHTML = "성인 " + adultcount + "명, 청소년 " + precount + "명";
        }

        formAdultCount.value = adultcount;
        formPreCount.value = precount;
        formSeats.value = selectedArr.join(',');

        let calculatedPrice = 0;
        let tempAdultCount = adultcount;
        let tempPreCount = precount;

        for (let i = 0; i < count; i++) {
            if (tempAdultCount > 0) {
                calculatedPrice += adultprice; 
                tempAdultCount--;
            } else if (tempPreCount > 0) {
                calculatedPrice += teenprice; 
                tempPreCount--;
            }
        }

        if(summaryTotalPrice) {
            summaryTotalPrice.innerHTML = calculatedPrice.toLocaleString() + "원";
        }

        if (totalPeople > 0 && count === totalPeople) {
            nextMoveBtn.style.background = "var(--gc-primary, #03c75a)";
            nextMoveBtn.style.color = "#fff";
            nextMoveBtn.style.cursor = "pointer";
            nextMoveBtn.style.pointerEvents = "auto";
            nextMoveBtn.removeAttribute("disabled");
        } else {
            nextMoveBtn.style.background = "#e5e7eb";
            nextMoveBtn.style.color = "#9ca3af";
            nextMoveBtn.style.cursor = "not-allowed";
            nextMoveBtn.style.pointerEvents = "none";
            nextMoveBtn.setAttribute("disabled", "true");
        }
    }

    function choicerender(index, index02) {
        let seatName = arryeng[index] + (index02 + 1);
        
        if (completedSeats.includes(seatName)) {
            alert("이미 예매 완료된 좌석입니다.");
            return;
        }

        let totalPeople = adultcount + precount;
        if (totalPeople === 0) {
            alert("관람 인원을 먼저 선택해주세요.");
            return;
        }
        
        let existingIndex = seatresult.indexOf(seatName);
        if (existingIndex !== -1) {
            seatresult[existingIndex] = '-';
            maxcount--;
            render();
            seatrender();
            return;
        }
        if (maxcount >= totalPeople) {
            alert("선택할 수 있는 인원수를 초과했습니다.");
            return;
        }
        let targetIndex = seatresult.indexOf('-');
        if (targetIndex !== -1) {
            seatresult[targetIndex] = seatName;
            maxcount++;
            render();
            seatrender();
        }
    }

    function adultplus() {
        if (adultcount + precount < 8) {
            adultcount++;
            adult.innerText = adultcount;
            render();
            seatrender();
        } else {
            alert("8명까지만 선택 가능합니다.");
        }
    }

    function adultminus() {
        if (adultcount > 0) {
            adultcount--;
            adult.innerText = adultcount;
            checkAndResetOverflow();
            render();
            seatrender();
        }
    }

    function preplus() {
        if (adultcount + precount < 8) {
            precount++;
            pre.innerText = precount;
            render();
            seatrender();
        } else {
            alert("8명까지만 선택 가능합니다.");
        }
    }

    function preminus() {
        if (precount > 0) {
            precount--;
            pre.innerText = precount;
            checkAndResetOverflow();
            render();
            seatrender();
        }
    }

    function checkAndResetOverflow() {
        let totalPeople = adultcount + precount;
        if (maxcount > totalPeople) {
            for (let i = totalPeople; i < seatresult.length; i++) {
                seatresult[i] = '-';
            }
            maxcount = totalPeople;
            seatrender();
        }
    }

    function reset() {
    	if(confirm("선택한 좌석을 초기화 하시겠습니까?")){
	        adultcount = 0;
	        precount = 0;
	        maxcount = 0;
	        adult.innerText = 0;
	        pre.innerText = 0;
	        seatresult = new Array(8).fill('-');
	        render();
	        seatrender();
    	}
    }
    
    function back(){
        if(confirm("이전 페이지로 이동하시겠습니까?")){
            history.go(-1);
        }
    }
    
    function validateForm() {
        let totalPeople = adultcount + precount;
        if (totalPeople === 0) {
            alert("관람 인원을 먼저 선택해주세요.");
            return false;
        }
        let selectedSeats = seatresult.filter(seat => seat !== '-');
        if (selectedSeats.length !== totalPeople) {
            alert("선택하신 관람 인원수와 좌석 수가 일치하지 않습니다.");
            return false;
        }
        return confirm("선택을 완료하셨습니까?");
    }
    
    render();
    seatrender();
</script>