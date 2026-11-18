<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div id="reserveCompleteModal" class="reserve-modal-overlay" style="display: <c:if test="${isReservedSuccess}">flex</c:if><c:if test="${!isReservedSuccess}">none</c:if>;">
    <div class="reserve-modal-content">
        <button type="button" class="modal-close-btn" onclick="closeModal()">&times;</button>
        
        <div class="modal-header-icon">
            <!-- 💡 영화 포스터 이미지 크기 및 비율 스타일 적용 -->
            <div class="poster-img-wrap">
                <img src="./${rjdto.imgPath}" alt="${rjdto.movieTitle}">
            </div>
            <h2>${rjdto.movieTitle}</h2>
            <p>영화 예매가 완료되었습니다.</p>
        </div>

        <div class="reserve-info-card">
            <h3>영화예매</h3>
            <div class="info-divider"></div>
            <p><strong>일시:</strong> ${selectedDate} (${fn:substring(scheduleSTime, 11, 16)} ~ ${fn:substring(scheduleETime, 11, 16)})</p>
            <p><strong>영화관:</strong> 그린 시네마 ${smallRegion}</p>
            <p><strong>관람인원:</strong> 
                <c:if test="${adultcount > 0}">성인 ${adultcount}명 </c:if>
                <c:if test="${precount > 0}">청소년 ${precount}명</c:if>
            </p>
            <p><strong>선택좌석:</strong> <span style="color: #03c75a; font-weight: bold;">${seats}</span></p>
            <!-- 💡 3자리 콤마 포맷 적용 -->
            <p><strong>결제금액:</strong> <span style="color: #03c75a; font-weight: bold;"><fmt:formatNumber value="${totalprice}" type="number" />원</span></p>
        </div>

        <div class="modal-actions">
            <button type="button" class="btn-confirm-home" onclick="closeModal()">확인</button>
        </div>
    </div>
</div>


<script>
function closeModal() {
    document.getElementById('reserveCompleteModal').style.display = 'none';
    location.href = 'index.jsp';
}
</script>