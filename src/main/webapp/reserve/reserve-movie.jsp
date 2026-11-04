<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<link rel="stylesheet" href="css/reserve.css">
<div class="page-content">

	<div class="container">

		<div class="page-heading">
			<p class="page-heading__eyebrow">TICKET BOOKING</p>
			<h1 class="page-heading__title">영화 · 극장 선택</h1>
		</div>

		<ol class="booking-steps" aria-label="예매 진행 단계">
			<li class="booking-step is-current"><span class="step-num">01</span>
				영화·극장 선택</li>
			<li class="booking-step"><span class="step-num">02</span> 인원·좌석
				선택</li>
			<li class="booking-step"><span class="step-num">03</span> 결제</li>
			<li class="booking-step"><span class="step-num">04</span> 예매 완료
			</li>
		</ol>

		<div class="booking-layout">
			<div class="booking-main">

				<!-- 01 극장 선택 (지역 대분류 / 소분류) -->
				<section class="booking-panel">
					<h2 class="booking-panel__title">
						<span class="number-kicker">01</span> 극장 선택
					</h2>
					<div class="theater-selection-layout">
						<!-- 지역 대분류 -->
						<div class="region-major-group">
							
						</div>
						<!-- 지역 소분류 및 극장 -->
						<div class="region-minor-group">
							
						</div>
					</div>
				</section>

				<!-- 02 영화 및 상영일 선택 -->
				<section class="booking-panel">
					<h2 class="booking-panel__title">
						<span class="number-kicker">02</span> 영화 및 상영일 선택
					</h2>
					<div class="movie-date-layout">
						<!-- 영화 선택 -->
						<div class="movie-select-group"></div>
						<!-- 날짜 선택 -->
						<div class="date-select-group">
							<div id="date-wrap">
								<button id="previousButton" onclick="previousButton()">&lt;</button>
								<div id="main_date"></div>
								<button id="nextButton" onclick="nextButton()">&gt;</button>
							</div>
							<!-- 요일과 날짜를 하나의 테이블(.cal_table)로 통합 -->
							<div id="displayTable"></div>


							<script>
					        let yearMonth = document.getElementById('main_date');
					        let displayTable = document.getElementById('displayTable');
					        let today = new Date(); // 오늘 날짜
					
					        let arr = Array.from(Array(6), () => new Array(7));
					
					        // 달력의 배열에 값을 저장하는 함수
					        function calendar(){
					            let year = today.getFullYear();
					            let month = today.getMonth();
					            let lastDate = new Date(year, month + 1, 0); 
					            let lastDay = lastDate.getDate(); // 마지막 일자
					            let startDate = new Date(year, month, 1); // 월의 첫 일자
					            let startWeek = startDate.getDay(); // 요일이 숫자(0~6), 0=일요일
					            let row = 0; 
					
					            // 배열값을 빈값으로 초기화
					            for(let i = 0; i < arr.length; i++){
					                for(let j = 0; j < arr[i].length; j++){
					                    arr[i][j] = "";
					                }
					            }
					
					            // 달력 배열에 실제 값을 채우는 코드
					            for(let i = 1; i <= lastDay; i++){
					                arr[row][startWeek] = i; 
					                if(startWeek < 6){ 
					                    startWeek++;
					                } else { 
					                    row++;
					                    startWeek = 0; 
					                }
					            }
					        }
					
					        function display(){
					            calendar();
					
					            let year = today.getFullYear();
					            let month = today.getMonth();
					
					            let tb = "<table class='cal_table'>";
					            // 요일 헤더를 테이블 내부에 포함시켜 간격 정렬 맞춤
					            tb += "<thead><tr>";
					            let weeks = ["SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"];
					            for(let w of weeks) {
					                tb += "<th>" + w + "</th>";
					            }
					            tb += "</tr></thead><tbody>";
					
					            // 날짜 데이터 바디 생성
					            for(let i = 0; i < arr.length; i++){
					                // 텅 빈 주(6번째 줄 등)는 출력하지 않고 건너뛰어 높이 안정화 가능 (선택사항)
					                let isEmptyRow = arr[i].every(cell => cell === "");
					                if(isEmptyRow && i >= 4) continue; 
					
					                tb += "<tr>";
					                for(let j = 0; j < arr[i].length; j++){
					                    let dayVal = arr[i][j] === "" ? "" : arr[i][j];
					                    tb += "<td>" + dayVal + "</td>";
					                }
					                tb += "</tr>";
					            }
					            tb += "</tbody></table>";
					
					            let yearmonth = year + "년 " + (month + 1) + "월";
					            yearMonth.innerHTML = yearmonth;
					            displayTable.innerHTML = tb;
					        }
					
					        display();
					
					        function previousButton(){
					            today = new Date(today.getFullYear(), today.getMonth() - 1, 1);
					            display();
					        }
					        function nextButton(){
					            today = new Date(today.getFullYear(), today.getMonth() + 1, 1);
					            display();
					        }
					    </script>
						</div>
					</div>
				</section>
			</div>

			<aside class="booking-summary">
				<div class="summary-kicker">TICKET BOOKING</div>
				<h2 class="booking-summary__title">예매 정보</h2>
				<div class="summary-movie">
					<img src="" alt="선택 영화">
					<div>
						<strong>다시, 봄</strong> <small>그린시네마 홍대 / 1관</small>
					</div>
				</div>

				<div class="booking-summary__row">
					<span class="booking-summary__label">극장</span> <strong
						class="booking-summary__value">그린시네마 홍대</strong>
				</div>
				<div class="booking-summary__row">
					<span class="booking-summary__label">상영일</span> <strong
						class="booking-summary__value">10.29 (목)</strong>
				</div>
				<div class="booking-summary__row">
					<span class="booking-summary__label">상영시간</span> <strong
						class="booking-summary__value">미선택</strong>
				</div>

				<div class="booking-summary__total">
					<span>선택 영화</span> <span class="booking-summary__amount"
						style="font-size: 16px;">다시, 봄</span>
				</div>

				<p class="summary-footnote">모든 항목을 선택한 후 다음 단계로 이동하세요.</p>

				<a class="btn btn--primary btn--block btn--large" href="index.jsp?section=reserve/reserve-seat.jsp">인원·좌석
					선택 ↗</a>
			</aside>
		</div>

	</div>
</div>