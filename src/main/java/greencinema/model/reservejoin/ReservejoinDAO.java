package greencinema.model.reservejoin;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import greencinema.DBPKG.Util;

public class ReservejoinDAO {
	Connection con = null;
	ResultSet rs = null;
	PreparedStatement pstmt = null;

	// DB 연결 및 자원 반납 메서드
	public void closeAll() {
		try {
			if (rs != null) rs.close();
			if (pstmt != null) pstmt.close();
			if (con != null) con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 특정 영화 ID를 받아 해당 영화의 상세 정보(제목, 이미지 경로, 관람가, 러닝타임 등)를 조회하는 메서드
	public ReservejoinDTO getOneMovieList(String id) {
		ReservejoinDTO rjdto = new ReservejoinDTO();
		try {
			con = Util.getConnection();
			String sql = "select * from movie where movie_id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);

			rs = pstmt.executeQuery();
			if (rs.next()) {
				rjdto.setMovieId(rs.getInt("movie_id"));
				rjdto.setImgPath(rs.getString("img_path"));
				rjdto.setMovieContent(rs.getString("movie_content"));
				rjdto.setMovieRate(rs.getInt("movie_rate"));
				rjdto.setMovieTitle(rs.getString("movie_title"));
				rjdto.setRunTime(rs.getInt("run_time"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll();
		}
		return rjdto;
	}

	// 등록된 전체 극장 목록에서 지역 대분류(예: 서울, 경기/인천 등)만 중복 없이 조회하는 메서드
	public ArrayList<ReservejoinDTO> getAllLargeTheater () {
	    ArrayList<ReservejoinDTO> list = new ArrayList<>();
	    try {
	        con = Util.getConnection();
	        String sql = "select large_region from theater group by large_region";
	        pstmt = con.prepareStatement(sql);
	        
	        rs = pstmt.executeQuery();
	        while(rs.next()) {
	            ReservejoinDTO rjdto = new ReservejoinDTO();
	            rjdto.setLargeRegion(rs.getString("large_region"));
	            list.add(rjdto);
	        }        
	    } catch(Exception e) {
	        e.printStackTrace();
	    } finally {
	        closeAll();
	    }
	    return list;        
	}
	
	// 선택한 대지역에 속한 지역 소분류(예: 수원역, 부평역사 등) 목록을 중복 없이 조회하는 메서드
	public ArrayList<ReservejoinDTO> getAllSmallTheater (String largeRegion) {
	    ArrayList<ReservejoinDTO> list = new ArrayList<>();
	    try {
	        con = Util.getConnection();
	        String sql = "select small_region from theater where large_region=? group by small_region";
	        pstmt = con.prepareStatement(sql);
	        pstmt.setString(1, largeRegion);
	        
	        rs = pstmt.executeQuery();
	        while(rs.next()) {
	            ReservejoinDTO rjdto = new ReservejoinDTO();
	            rjdto.setSmallRegion(rs.getString("small_region"));
	            list.add(rjdto);
	        }        
	    } catch(Exception e) {
	        e.printStackTrace();
	    } finally {
	        closeAll();
	    }
	    return list;        
	}
	
	// 영화 ID, 대지역, 소지역, 날짜 조건을 바탕으로 해당 상영 회차 정보와 각 상영관별 잔여 좌석 수를 계산하여 조회하는 메서드
	public ArrayList<ReservejoinDTO> getAllschedule(String movieid, String largeRegion, String smallRegion, String date) {
	    ArrayList<ReservejoinDTO> list = new ArrayList<>();
	    
	    if (movieid == null || largeRegion == null || smallRegion == null || date == null) {
	        return list;
	    }

	    try {
	        con = Util.getConnection();        
	        
	        String sql = "SELECT " +
	                     "    s.schedule_id, " +
	                     "    s.schedule_starttime, " +
	                     "    s.schedule_endtime, " +
	                     "    sc.screen_id, " +
	                     "    sc.screen_num, " +
	                     "    sc.total_seat, " +
	                     "    ( " +
	                     "        SELECT IFNULL(SUM(CHAR_LENGTH(se.seat_num) - CHAR_LENGTH(REPLACE(se.seat_num, ',', '')) + 1), 0) " +
	                     "        FROM seat se " +
	                     "        WHERE se.schedule_id = s.schedule_id " +
	                     "          AND se.screen_id = s.screen_id " +
	                     "          AND se.seat_num IS NOT NULL AND se.seat_num != '' " +
	                     "    ) AS booked_seat_count " +
	                     "FROM schedule s " +
	                     "INNER JOIN screen sc ON s.screen_id = sc.screen_id " +
	                     "INNER JOIN theater t ON t.theater_id = sc.theater_id " +
	                     "WHERE s.movie_id = ? " +
	                     "  AND t.large_region = ? " +
	                     "  AND t.small_region = ? " +
	                     "  AND DATE(s.schedule_starttime) = DATE(?) " +
	                     "GROUP BY s.schedule_id, s.schedule_starttime, s.schedule_endtime, sc.screen_id, sc.screen_num, sc.total_seat " +
	                     "ORDER BY s.schedule_starttime ASC";
	        
	        pstmt = con.prepareStatement(sql);
	        pstmt.setString(1, movieid);
	        pstmt.setString(2, largeRegion);
	        pstmt.setString(3, smallRegion);
	        pstmt.setString(4, date);
	        
	        rs = pstmt.executeQuery();
	        
	        while(rs.next()) {
	            ReservejoinDTO rjdto = new ReservejoinDTO();
	            rjdto.setScheduleId(rs.getInt("schedule_id"));
	            rjdto.setScheduleStarttime(rs.getString("schedule_starttime"));
	            rjdto.setScheduleEndtime(rs.getString("schedule_endtime"));
	            rjdto.setScreenId(rs.getInt("screen_id"));
	            rjdto.setScreenNum(rs.getInt("screen_num"));
	            
	            int totalSeat = rs.getInt("total_seat");          
	            int bookedCount = rs.getInt("booked_seat_count");  
	            int remainSeat = totalSeat - bookedCount;          
	            
	            rjdto.setTotalSeat(totalSeat);     
	            rjdto.setRemainSeat(remainSeat);   
	            
	            list.add(rjdto);
	        }
	        
	    } catch(Exception e) {
	        e.printStackTrace();
	    } finally {
	        closeAll();
	    }
	    
	    return list;
	}
	
	// 선택한 대지역과 소지역에 해당하는 극장에서 현재 상영 중인 영화 목록만 중복 없이 조회하는 메서드
	public ArrayList<ReservejoinDTO> getSelectMovie(String largeRegion, String smallRegion) {
	    ArrayList<ReservejoinDTO> list = new ArrayList<>();
	    if (largeRegion == null || smallRegion == null) return list;
	    try {
	        con = Util.getConnection();
	        String sql = "select distinct m.movie_id, m.movie_title, m.movie_rate from schedule s "
	                   + "inner join movie m on s.movie_id = m.movie_id "
	                   + "inner join screen sc on s.screen_id = sc.screen_id "
	                   + "inner join theater t on t.theater_id = sc.theater_id "
	                   + "where t.large_region = ? and t.small_region = ?";
	        pstmt = con.prepareStatement(sql);
	        pstmt.setString(1, largeRegion);
	        pstmt.setString(2, smallRegion);
	        rs = pstmt.executeQuery();
	        while(rs.next()) {
	            ReservejoinDTO rjdto = new ReservejoinDTO();
	            rjdto.setMovieId(rs.getInt("movie_id"));
	            rjdto.setMovieTitle(rs.getString("movie_title"));  
	            rjdto.setMovieRate(rs.getInt("movie_rate"));
	            list.add(rjdto);
	        }
	    } catch(Exception e) {
	        e.printStackTrace();
	    } finally {
	        closeAll();
	    }
	    return list;        
	}
	
	// 특정 상영 회차(scheduleId)와 상영관(screenId)에서 이미 예매가 완료된 좌석 번호들을 분리하여 조회하는 메서드
	public ArrayList<ReservejoinDTO> getAllseat(int scheduleId, int screenId) {
	    ArrayList<ReservejoinDTO> list = new ArrayList<>();
	    if (scheduleId <= 0 || screenId <= 0) return list;

	    try {
	        con = Util.getConnection();
	        String sql = "SELECT DISTINCT SUBSTRING_INDEX(SUBSTRING_INDEX(se.seat_num, ',', numbers.n), ',', -1) AS seat_num "
	                + "FROM seat se "
	                + "INNER JOIN (SELECT 1 AS n UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8) AS numbers "
	                + "  ON CHAR_LENGTH(se.seat_num) - CHAR_LENGTH(REPLACE(se.seat_num, ',', '')) >= numbers.n - 1 "
	                + "WHERE se.schedule_id = ? AND se.screen_id = ?";
	        
	        pstmt = con.prepareStatement(sql);
	        pstmt.setInt(1, scheduleId);
	        pstmt.setInt(2, screenId); 
	        
	        rs = pstmt.executeQuery();
	        while(rs.next()) {
	            ReservejoinDTO rjdto = new ReservejoinDTO();
	            String seatNum = rs.getString("seat_num");
	            if(seatNum != null) {
	                rjdto.setSeatNum(seatNum.trim()); 
	            }
	            list.add(rjdto);
	        }
	    } catch(Exception e) {
	        e.printStackTrace();
	    } finally {
	        closeAll();
	    }
	    return list;        
	}

	// 특정 영화 ID를 기준으로 상영 예정인 일정 중 가장 첫 번째 상영 정보(대지역, 소지역, 첫 상영일시)를 조회하는 메서드
	public ReservejoinDTO getFirstScheduleInfo(String movieId) {
	    ReservejoinDTO rjdto = null;
	    try {
	        con = Util.getConnection();
	        String sql = "SELECT t.large_region, t.small_region, s.schedule_starttime "
	                   + "FROM schedule s "
	                   + "JOIN screen sc ON s.screen_id = sc.screen_id "
	                   + "JOIN theater t ON sc.theater_id = t.theater_id "
	                   + "WHERE s.movie_id = ? "
	                   + "ORDER BY s.schedule_starttime ASC LIMIT 1";
	        pstmt = con.prepareStatement(sql);
	        pstmt.setString(1, movieId);
	        rs = pstmt.executeQuery();
	        if (rs.next()) {
	            rjdto = new ReservejoinDTO();
	            rjdto.setLargeRegion(rs.getString("large_region"));
	            rjdto.setSmallRegion(rs.getString("small_region"));
	            rjdto.setScheduleStarttime(rs.getString("schedule_starttime"));
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        closeAll();
	    }
	    return rjdto;
	}
}