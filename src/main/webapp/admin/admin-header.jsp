<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


			<header class="admin-top" id="overview">
				<div>
					<p class="tiny-eyebrow">ADMINISTRATOR</p>
					<h1>하우스 데스크</h1>
					<p>상영작, 공지, 문의, FAQ를 한 자리에서 봅니다. 숫자는 MySQL <strong>greencinema</strong> 데이터베이스에서 바로 읽습니다.</p>
				</div>
				<div class="admin-who"><span class="admin-who__dot" aria-hidden="true"></span>admin · 관리자</div>
			</header>

			<div class="admin-marquee" aria-hidden="true">
				<p>NOW SHOWING · GREEN CINEMA · HOUSE LIGHTS DOWN · TICKETS · NOTICES · INQUIRIES</p>
			</div>

			<c:if test="${param.saved == '1'}">
				<p class="admin-toast">문의 답변을 등록했습니다.</p>
			</c:if>
			<c:if test="${param.saved == '0'}">
				<p class="admin-toast admin-toast--bad">답변을 저장하지 못했습니다. 내용이 비어 있거나 DB 연결을 확인해 주세요.</p>
			</c:if>

			
    