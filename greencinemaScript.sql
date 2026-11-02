-- 1. 스키마 생성 및 사용
CREATE SCHEMA IF NOT EXISTS greencinema DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE greencinema;

-- 2. 기존 테이블 삭제 (존재할 경우)
DROP TABLE IF EXISTS faq;
DROP TABLE IF EXISTS seat;
DROP TABLE IF EXISTS payment;
DROP TABLE IF EXISTS reserve;
DROP TABLE IF EXISTS schedule;
DROP TABLE IF EXISTS movie;
DROP TABLE IF EXISTS screen;
DROP TABLE IF EXISTS theater;
DROP TABLE IF EXISTS inquiry;
DROP TABLE IF EXISTS notice;
DROP TABLE IF EXISTS user;

-- 3. 테이블 생성 (FK 제외, PK 설정)

-- 회원 (user)
CREATE TABLE user (
    user_id VARCHAR(10) PRIMARY KEY,
    user_pw VARCHAR(15) NOT NULL,
    user_name VARCHAR(20) NOT NULL,
    user_birth DATE NOT NULL,
    user_email VARCHAR(20),
    user_phone VARCHAR(15) NOT NULL,
    user_delete TINYINT DEFAULT 0
);

-- 공지사항 (notice)
CREATE TABLE notice (
    notice_id INT PRIMARY KEY AUTO_INCREMENT,
    notice_title VARCHAR(30) NOT NULL,
    notice_date DATETIME NOT NULL,
    notice_hits INT NOT NULL DEFAULT 0,
    notice_text TEXT NOT NULL
);

-- 1:1문의 (inquiry)
CREATE TABLE inquiry (
    inquiry_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id VARCHAR(10) NOT NULL,
    inquiry_sort VARCHAR(5) NOT NULL,
    inquiry_type CHAR(2) NOT NULL,
    inquiry_title VARCHAR(30) NOT NULL,
    inquiry_content TEXT NOT NULL,
    reception_type TINYINT DEFAULT -1,
    answer_status TINYINT DEFAULT 0,
    answer_content TEXT
);

-- 극장 (theater)
CREATE TABLE theater (
    theater_id INT PRIMARY KEY AUTO_INCREMENT,
    Large_region VARCHAR(20) NOT NULL,
    Small_region VARCHAR(20) NOT NULL
);

-- 상영관 (screen) - 총좌석수 100 고정
CREATE TABLE screen (
    screen_id INT PRIMARY KEY AUTO_INCREMENT,
    theater_id INT NOT NULL,
    total_seat TINYINT UNSIGNED NOT NULL DEFAULT 100,
    screen_num TINYINT UNSIGNED NOT NULL DEFAULT 1
);

-- 영화정보 (movie)
CREATE TABLE movie (
    movie_id INT PRIMARY KEY AUTO_INCREMENT,
    movie_title VARCHAR(20) NOT NULL,
    movie_rate TINYINT NOT NULL,
    img_path VARCHAR(20) NOT NULL,
    movie_content TEXT NOT NULL,
    run_time TINYINT UNSIGNED NOT NULL
);

-- 상영일정 (schedule)
CREATE TABLE schedule (
    schedule_id INT PRIMARY KEY AUTO_INCREMENT,
    movie_id INT NOT NULL,
    screen_id INT NOT NULL,
    schedule_starttime DATETIME NOT NULL,
    schedule_endtime DATETIME NOT NULL
);

-- 예매 (reserve)
CREATE TABLE reserve (
    reserve_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id VARCHAR(20) NOT NULL,
    adult_count TINYINT DEFAULT 0,
    teens_count TINYINT DEFAULT 0,
    total_price INT NOT NULL,
    reserve_date DATETIME NOT NULL,
    cancel_date DATETIME DEFAULT NULL
);

-- 결제 (payment)
CREATE TABLE payment (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    reserve_id INT NOT NULL,
    payment_method TINYINT NOT NULL,
    payment_datetime DATETIME NOT NULL
);

-- 좌석 (seat)
CREATE TABLE seat (
    seat_id INT PRIMARY KEY AUTO_INCREMENT,
    screen_id INT NOT NULL,
    reserve_id INT NOT NULL,
    seat_num CHAR(3) NOT NULL
);

-- FAQ (faq)
CREATE TABLE faq (
    faq_id INT PRIMARY KEY AUTO_INCREMENT,
    faq_type INT NOT NULL,
    faq_inquery TEXT NOT NULL,
    faq_answer TEXT NOT NULL
);


-- 4. 더미 데이터 생성

-- [1] 극장 (theater) - 서울/경기 각 5개
INSERT INTO theater (Large_region, Small_region) VALUES 
('서울', '코엑스'), ('서울', '강남'), ('서울', '신촌'), ('서울', '목동'), ('서울', '상암월드컵경기장'),
('경기', '고양스타필드'), ('경기', '분당'), ('경기', '수원'), ('경기', '하남스타필드'), ('경기', '동탄');

-- [2] 공지사항 (notice) - 15건
INSERT INTO notice (notice_title, notice_date, notice_hits, notice_text) VALUES 
('그린시네마 신규 오픈 안내', '2026-10-01 10:00:00', 150, '그린시네마가 새롭게 오픈했습니다. 많은 이용 부탁드립니다.'),
('시스템 점검 안내', '2026-10-05 14:00:00', 45, '안정적인 서비스 제공을 위해 새벽 2시부터 시스템 점검이 있습니다.'),
('가을 맞이 팝콘 1+1 이벤트', '2026-10-10 09:00:00', 320, '가을을 맞이하여 팝콘 1+1 이벤트를 진행합니다.'),
('신용카드 결제 오류 복구 안내', '2026-10-12 11:30:00', 89, '오전 중 발생한 일부 신용카드 결제 오류가 복구되었습니다.'),
('VIP 회원 등급 산정 기준 변경', '2026-10-15 10:00:00', 510, '내년부터 VIP 회원 등급 산정 기준이 변경됩니다.'),
('할로윈 데이 특별 상영작 안내', '2026-10-18 15:00:00', 210, '할로윈을 맞이해 공포 영화 특별 상영전을 개최합니다.'),
('개인정보 처리방침 개정 안내', '2026-10-20 09:00:00', 12, '그린시네마 개인정보 처리방침이 일부 개정됩니다.'),
('코엑스점 주차장 공사 안내', '2026-10-22 13:00:00', 78, '코엑스점 지하 주차장 보수 공사로 대중교통 이용을 권장합니다.'),
('그린시네마 앱 업데이트 안내', '2026-10-25 10:00:00', 95, '앱 2.0 버전이 업데이트 되었습니다. 스토어에서 확인하세요.'),
('청소년 관람불가 영화 신분증 지참', '2026-10-26 11:00:00', 60, '청불 영화 관람 시 반드시 실물 신분증을 지참해주세요.'),
('분실물 찾기 서비스 개편', '2026-10-27 14:00:00', 33, '온라인으로 분실물을 쉽게 조회할 수 있도록 서비스가 개편되었습니다.'),
('수원점 리뉴얼 오픈 이벤트', '2026-10-28 10:00:00', 145, '수원점이 새단장을 마쳤습니다. 오픈 기념 특가 이벤트를 확인하세요.'),
('대학생 할인 프로모션 연장', '2026-10-29 09:00:00', 400, '인기에 힘입어 대학생 할인 프로모션을 11월까지 연장합니다.'),
('영화 리뷰 작성 포인트 2배 적립', '2026-10-29 15:00:00', 120, '이번 주말 관람 후 리뷰 작성 시 포인트가 2배 지급됩니다.'),
('11월 무대인사 일정 안내', '2026-10-30 09:00:00', 880, '11월 개봉작 주연 배우들의 무대인사 일정을 공개합니다.');

-- [3] 상영관 (screen) - 20건 (총좌석 100석 고정, 상영관 1~3 랜덤)
INSERT INTO screen (theater_id, total_seat, screen_num) VALUES 
(1, 100, 1), (1, 100, 3), (2, 100, 2), (2, 100, 1), (3, 100, 3),
(3, 100, 1), (4, 100, 2), (4, 100, 3), (5, 100, 1), (5, 100, 2),
(6, 100, 3), (6, 100, 1), (7, 100, 2), (7, 100, 3), (8, 100, 1),
(8, 100, 2), (9, 100, 3), (9, 100, 1), (10, 100, 2), (10, 100, 3);

-- [4] 영화정보 (movie) - 20건
INSERT INTO movie (movie_title, movie_rate, img_path, movie_content, run_time) VALUES 
('스페이스 랩소디', 12, '/img/m01.jpg', '우주 한가운데서 펼쳐지는 감동적인 휴먼 드라마.', 120),
('블랙 쉐도우', 15, '/img/m02.jpg', '도시를 지키는 다크 히어로의 화려한 액션.', 135),
('로맨틱 다이어리', 12, '/img/m03.jpg', '우연히 발견한 일기장으로 시작된 첫사랑 이야기.', 110),
('심해의 공포', 19, '/img/m04.jpg', '미지의 심해 탐사 중 마주친 끔찍한 진실.', 105),
('코드 네임: 알파', 15, '/img/m05.jpg', '국제 스파이들의 숨막히는 두뇌 싸움.', 125),
('아빠의 레시피', 0, '/img/m06.jpg', '가족의 사랑을 깨닫게 해주는 따뜻한 힐링 영화.', 95),
('시간 여행자', 12, '/img/m07.jpg', '과거를 바꾸기 위한 한 남자의 처절한 시간 여행.', 118),
('마지막 방어선', 15, '/img/m08.jpg', '외계 침공에 맞선 지구 연합군의 최후의 전투.', 140),
('그날의 메아리', 15, '/img/m09.jpg', '과거의 상처를 치유해가는 감성 멜로.', 108),
('크레이지 라이더', 15, '/img/m10.jpg', '도심을 가로지르는 통쾌한 카체이싱 액션.', 115);

-- [5] 상영일정 (schedule) - 40건
INSERT INTO schedule (movie_id, screen_id, schedule_starttime, schedule_endtime) VALUES 
(1, 1, '2026-11-01 10:00:00', '2026-11-01 12:00:00'),
(2, 2, '2026-11-01 10:30:00', '2026-11-01 12:45:00'),
(3, 3, '2026-11-01 11:00:00', '2026-11-01 12:50:00'),
(4, 4, '2026-11-01 12:00:00', '2026-11-01 13:45:00'),
(5, 5, '2026-11-01 12:30:00', '2026-11-01 14:35:00'),
(6, 6, '2026-11-01 13:00:00', '2026-11-01 14:35:00'),
(7, 7, '2026-11-01 14:00:00', '2026-11-01 15:58:00'),
(8, 8, '2026-11-01 14:30:00', '2026-11-01 16:50:00'),
(9, 9, '2026-11-01 15:00:00', '2026-11-01 16:48:00'),
(10, 10, '2026-11-01 16:00:00', '2026-11-01 17:55:00'),
(11, 11, '2026-11-01 16:30:00', '2026-11-01 18:00:00'),
(12, 12, '2026-11-01 17:00:00', '2026-11-01 19:02:00'),
(13, 13, '2026-11-01 18:00:00', '2026-11-01 20:10:00'),
(14, 14, '2026-11-01 18:30:00', '2026-11-01 20:10:00'),
(15, 15, '2026-11-01 19:00:00', '2026-11-01 20:52:00'),
(16, 16, '2026-11-01 20:00:00', '2026-11-01 21:45:00'),
(17, 17, '2026-11-01 20:30:00', '2026-11-01 22:38:00'),
(18, 18, '2026-11-01 21:00:00', '2026-11-01 22:59:00'),
(19, 19, '2026-11-01 22:00:00', '2026-11-01 23:57:00'),
(20, 20, '2026-11-01 22:30:00', '2026-11-02 00:16:00'),
(1, 1, '2026-11-02 10:00:00', '2026-11-02 12:00:00'),
(2, 2, '2026-11-02 10:30:00', '2026-11-02 12:45:00'),
(3, 3, '2026-11-02 11:00:00', '2026-11-02 12:50:00'),
(4, 4, '2026-11-02 12:00:00', '2026-11-02 13:45:00'),
(5, 5, '2026-11-02 12:30:00', '2026-11-02 14:35:00'),
(6, 6, '2026-11-02 13:00:00', '2026-11-02 14:35:00'),
(7, 7, '2026-11-02 14:00:00', '2026-11-02 15:58:00'),
(8, 8, '2026-11-02 14:30:00', '2026-11-02 16:50:00'),
(9, 9, '2026-11-02 15:00:00', '2026-11-02 16:48:00'),
(10, 10, '2026-11-02 16:00:00', '2026-11-02 17:55:00'),
(11, 11, '2026-11-02 16:30:00', '2026-11-02 18:00:00'),
(12, 12, '2026-11-02 17:00:00', '2026-11-02 19:02:00'),
(13, 13, '2026-11-02 18:00:00', '2026-11-02 20:10:00'),
(14, 14, '2026-11-02 18:30:00', '2026-11-02 20:10:00'),
(15, 15, '2026-11-02 19:00:00', '2026-11-02 20:52:00'),
(16, 16, '2026-11-02 20:00:00', '2026-11-02 21:45:00'),
(17, 17, '2026-11-02 20:30:00', '2026-11-02 22:38:00'),
(18, 18, '2026-11-02 21:00:00', '2026-11-02 22:59:00'),
(19, 19, '2026-11-02 22:00:00', '2026-11-02 23:57:00'),
(20, 20, '2026-11-02 22:30:00', '2026-11-03 00:16:00');

-- [6] FAQ (faq) - 10건
INSERT INTO faq (faq_type, faq_inquery, faq_answer) VALUES 
(1, '예매 취소는 언제까지 가능한가요?', '상영시간 20분 전까지 온라인 및 앱을 통해 취소 가능합니다.'),
(2, '주차 할인은 어떻게 받나요?', '영화 관람 후 티켓 하단의 바코드를 주차 정산기에 스캔하시면 3시간 무료입니다.'),
(1, '예매를 잘못했는데 부분 취소가 가능한가요?', '부분 취소는 불가능하며, 전체 취소 후 다시 예매해주셔야 합니다.'),
(3, '결제 수단은 어떤 것들이 있나요?', '신용카드, 체크카드, 간편결제(카카오페이, 네이버페이) 및 계좌이체가 가능합니다.'),
(4, '통신사 할인은 어떻게 적용받나요?', '결제 단계에서 제휴할인 탭을 선택한 후 통신사 카드를 인증하시면 됩니다.'),
(2, '현장 예매 시 카드 결제만 되나요?', '아닙니다. 현장 키오스크 및 매표소에서 현금 결제도 가능합니다.'),
(5, '회원 탈퇴는 어떻게 하나요?', '마이페이지 하단의 [회원 탈퇴] 메뉴를 통해 소프트 삭제 형태로 처리됩니다.'),
(3, '환불 시 입금은 언제 되나요?', '신용카드의 경우 카드사 사정에 따라 영업일 기준 3~5일 정도 소요됩니다.'),
(1, '청소년 관람불가 영화 예매 시 주의사항이 있나요?', '반드시 본인의 실물 신분증(주민등록증, 운전면허증 등)을 지참해야 입장이 가능합니다.'),
(4, '포인트 적립은 언제 되나요?', '영화 관람 익일 오전에 일괄적으로 자동 적립됩니다.');