<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

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
        </div>

        <div class="modal-actions">
            <button type="button" class="btn-confirm-home" onclick="closeModal()">확인</button>
        </div>
    </div>
</div>

<style>
.reserve-modal-overlay {
    position: fixed; top: 0; left: 0; width: 100%; height: 100%;
    background: rgba(0, 0, 0, 0.6); display: flex; justify-content: center; align-items: center; z-index: 9999;
}
.reserve-modal-content {
    background: #fff; width: 450px; padding: 30px; border-radius: 12px; box-shadow: 0 4px 20px rgba(0,0,0,0.15); position: relative;
}
.modal-close-btn {
    position: absolute; top: 20px; right: 20px; background: none; border: none; font-size: 24px; cursor: pointer;
}
.modal-header-icon { text-align: center; margin-bottom: 20px; }

/* 💡 포스터 이미지 영역 스타일 (적당한 크기와 입체감 부여) */
.poster-img-wrap {
    width: 110px;
    height: 155px;
    margin: 0 auto 15px auto;
    border-radius: 8px;
    overflow: hidden;
    box-shadow: 0 4px 10px rgba(0,0,0,0.2);
}
.poster-img-wrap img {
    width: 100%;
    height: 100%;
    object-fit: cover;
}

.modal-header-icon h2 {
    font-size: 18px;
    margin-bottom: 5px;
}
.modal-header-icon p {
    font-size: 14px;
    color: #64706b;
}

.reserve-info-card {
    background: #f8f9fa; border: 1px solid #e9ecef; border-radius: 8px; padding: 20px; margin-bottom: 20px;
}
.reserve-info-card h3 { font-size: 16px; margin-bottom: 10px; }
.reserve-info-card p { font-size: 14px; margin: 8px 0; color: #495057; }
.btn-confirm-home {
    width: 100%; padding: 12px; background: #03c75a; color: #fff; border: none; border-radius: 6px; font-size: 16px; cursor: pointer;
}
</style>

<script>
function closeModal() {
    document.getElementById('reserveCompleteModal').style.display = 'none';
    location.href = 'index.jsp';
}
</script>