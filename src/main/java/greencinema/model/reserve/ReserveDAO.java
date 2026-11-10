package greencinema.model.reserve;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import greencinema.DBPKG.Util;
import greencinema.model.reservejoin.ReservejoinDTO;

import greencinema.DBPKG.Util;

import greencinema.DBPKG.Util;

public class ReserveDAO {
	Connection con = null;
	ResultSet rs = null;
	PreparedStatement pstmt = null;
	
	public void cancelReserve(String reserveId) {		
		try {
			con = Util.getConnection();
			String sql = "update reserve set cancel_date = current_timestamp where reserve_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, reserveId);
			pstmt.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(con != null) con.close();
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

	// payment 테이블 insert 하는 메소드
	public boolean insertPayment(int reserveid, int paymenttype) {
		boolean chk = false;
		try {
			con = Util.getConnection();       
			String sql = "INSERT INTO payment VALUES (null, ?, ?, current_time());";        
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, reserveid);
			pstmt.setInt(2, paymenttype);
			
			chk = pstmt.executeUpdate() > 0;      
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			closeAll();
		}	
		return chk;
	}
	
	// reserve 테이블 insert 하는 메소드
	public boolean insertReserve(String user_id, int adult_count, int teens_count, int total_price) {
		boolean chk = false;
		try {
			con = Util.getConnection();       
			String sql = "INSERT INTO reserve VALUES (null, ?, ?, ?, ?, current_time(), null);";        
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, user_id);
			pstmt.setInt(2, adult_count);
			pstmt.setInt(3, teens_count);
			pstmt.setInt(4, total_price);
			
			chk = pstmt.executeUpdate() > 0;       
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			closeAll();
		}   
		return chk;
	}
	
	// seat 테이블 insert 하는 메소드
	public boolean insertSeat(int scheduleId, int screenId, int reseveId, String seat) {
	    boolean chk = false;
	    try {
	        con = Util.getConnection();        
	        String sql = "INSERT INTO seat VALUES (null, ?, ?, ?, ?)"; // 컬럼 순서: seat_id, schedule_id, screen_id, reserve_id, seat_num
	        pstmt = con.prepareStatement(sql);
	        pstmt.setInt(1, scheduleId); // 💡 schedule_id 추가
	        pstmt.setInt(2, screenId);
	        pstmt.setInt(3, reseveId);
	        pstmt.setString(4, seat);
	        
	        chk = pstmt.executeUpdate() > 0;       
	    } catch(Exception e) {
	        e.printStackTrace();
	    } finally {
	        closeAll();
	    }   
	    return chk;
	}
	
	public int reserveID() {		
		int maxId = 0;
		try {
			con = Util.getConnection();
			String sql = "SELECT MAX(reserve_id) AS max_id FROM reserve";
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {				
				maxId = rs.getInt("max_id");
			}					
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			closeAll();
		}
		return maxId;		
	}
	
	// 자원 해제용 공통 메서드
	private void closeAll() {
		try {
			if(rs != null) rs.close();
			if(pstmt != null) pstmt.close();
			if(con != null) con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}

	public void cancelReserve(String reserveId) {		
		try {
			con = Util.getConnection();
			String sql = "update reserve set cancel_date = current_timestamp where reserve_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, reserveId);
			pstmt.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(con != null) con.close();
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

}

