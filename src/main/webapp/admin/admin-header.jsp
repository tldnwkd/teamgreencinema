<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


			<c:choose>
				<c:when test="${param.section == 'admin-notice.jsp'}">
					<c:set var="adminTitle" value="공지사항 관리" />
					<c:set var="adminDesc" value="등록된 공지를 검색하고 확인합니다." />
				</c:when>
				<c:when test="${param.section == 'admin-inquiry.jsp'}">
					<c:set var="adminTitle" value="1:1 문의 관리" />
					<c:set var="adminDesc" value="회원 문의를 검색하고 답변 상태를 확인합니다." />
				</c:when>
				<c:when test="${param.section == 'admin-faq.jsp'}">
					<c:set var="adminTitle" value="FAQ 관리" />
					<c:set var="adminDesc" value="자주 묻는 질문을 검색하고 확인합니다." />
				</c:when>
				<c:when test="${param.section == 'admin-movie.jsp'}">
					<c:set var="adminTitle" value="영화관리" />
					<c:set var="adminDesc" value="등록된 영화를 검색하고 확인합니다." />
				</c:when>
				<c:when test="${param.section == 'admin-user.jsp'}">
					<c:set var="adminTitle" value="회원관리" />
					<c:set var="adminDesc" value="회원을 검색하고 등록, 수정, 탈퇴 처리합니다." />
				</c:when>
				<c:when test="${param.section == 'admin-user-form.jsp' && not empty udto}">
					<c:set var="adminTitle" value="회원 수정" />
					<c:set var="adminDesc" value="회원 정보를 확인하고 수정하거나 탈퇴 처리합니다." />
				</c:when>
				<c:when test="${param.section == 'admin-user-form.jsp'}">
					<c:set var="adminTitle" value="회원 등록" />
					<c:set var="adminDesc" value="새 회원의 아이디, 비밀번호, 연락처를 등록합니다." />
				</c:when>
				<c:when test="${param.section == 'admin-movie-form.jsp' && not empty mdto}">
					<c:set var="adminTitle" value="영화 수정" />
					<c:set var="adminDesc" value="영화 정보를 확인하고 수정하거나 삭제합니다." />
				</c:when>
				<c:when test="${param.section == 'admin-movie-form.jsp'}">
					<c:set var="adminTitle" value="영화 등록" />
					<c:set var="adminDesc" value="새 영화의 제목, 등급, 상영시간, 이미지를 등록합니다." />
				</c:when>
				<c:when test="${param.section == 'Admin-Inquiry-Insert.jsp'}">
					<c:set var="adminTitle" value="문의 답변 관리" />
					<c:set var="adminDesc" value="문의 내용을 확인하고 답변을 등록합니다." />
				</c:when>
				<c:otherwise>
					<c:set var="adminTitle" value="하우스 데스크 관리" />
					<c:set var="adminDesc" value="상영작, 공지, 문의, FAQ를 한 자리에서 봅니다." />
				</c:otherwise>
			</c:choose>

			<header class="admin-top" id="overview">
				<div>
					<p class="tiny-eyebrow">ADMINISTRATOR</p>
					<h1>${adminTitle}</h1>
					<p>${adminDesc}</p>
				</div>
				<div class="admin-who"><span class="admin-who__dot" aria-hidden="true"></span>admin · 관리자</div>
			</header>

			<c:if test="${empty param.section or param.section == '/admin/admin.jsp'}">
				<div class="admin-marquee" aria-hidden="true">
					<p>NOW SHOWING · GREEN CINEMA · HOUSE LIGHTS DOWN · TICKETS · NOTICES · INQUIRIES</p>
				</div>
			</c:if>

			<c:if test="${param.saved == '1'}">
				<p class="admin-toast">문의 답변을 등록했습니다.</p>
			</c:if>
			<c:if test="${param.saved == '0'}">
				<p class="admin-toast admin-toast--bad">답변을 저장하지 못했습니다. 내용이 비어 있거나 DB 연결을 확인해 주세요.</p>
			</c:if>

			
    