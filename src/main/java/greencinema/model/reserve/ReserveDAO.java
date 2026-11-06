package greencinema.model.reserve;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import greencinema.DBPKG.Util;
import greencinema.model.reservejoin.ReservejoinDTO;

public class ReserveDAO {
	Connection con = null;
	ResultSet rs = null;
	PreparedStatement pstmt = null;
	
	//payment 테이블 insert 하는 메소드
	public boolean insertPayment(int reserveid,int paymenttype) {
		boolean chk = false;
		try {
	        con = Util.getConnection();       
	        String sql = "insert into payment values (null,?,?,current_time());";		        
	        pstmt = con.prepareStatement(sql);
	        pstmt.setInt(1, reserveid);
	        pstmt.setInt(2, paymenttype);
	        
	        chk = pstmt.executeUpdate() > 0;	      
	    } catch(Exception e) {
	        e.printStackTrace();
	    } finally {
	        try {
	            if(rs != null) rs.close();
	            if(pstmt != null) pstmt.close();
	            if(con != null) con.close();
	        } catch (Exception e) {e.printStackTrace();}
	    }	 
		return chk;
	}
	
	//reserve 테이블 insert 하는 메소드
	
	// reserve 테이블 insert 하는 메소드
	public boolean insertReserve(String user_id, int adult_count, int teens_count, int total_price) {
	    boolean chk = false;
	    try {
	        con = Util.getConnection();       	        
	        String sql = "insert into reserve values (null, ?, ?, ?, ?, current_time(), null);";        
	        pstmt = con.prepareStatement(sql);
	        pstmt.setString(1, user_id);
	        pstmt.setInt(2, adult_count);
	        pstmt.setInt(3, teens_count);
	        pstmt.setInt(4, total_price);
	        
	        chk = pstmt.executeUpdate() > 0;       
	    } catch(Exception e) {
	        e.printStackTrace();
	    } finally {
	        try {
	            if(rs != null) rs.close();
	            if(pstmt != null) pstmt.close();
	            if(con != null) con.close();
	        } catch (Exception e) {e.printStackTrace();}
	    }   
	    return chk;
	}
	
	
	
	//seat 테이블 insert 하는 메소드
	
	public boolean insertSeat(int screenId,int reseveId,String seat) {
		boolean chk = false;
		try {
	        con = Util.getConnection();       
	        String sql = "INSERT INTO seat VALUES (null,?,?,?)";		        
	        pstmt = con.prepareStatement(sql);
	        pstmt.setInt(1, screenId);
	        pstmt.setInt(2, reseveId);
	        pstmt.setString(3, seat);
	        
	        chk = pstmt.executeUpdate() > 0;	      
	    } catch(Exception e) {
	        e.printStackTrace();
	    } finally {
	        try {
	            if(rs != null) rs.close();
	            if(pstmt != null) pstmt.close();
	            if(con != null) con.close();
	        } catch (Exception e) {e.printStackTrace();}
	    }	 
		return chk;
	}
	
	//reserve 테이블 count갯수 select하는 메소드(reserveID 구하는 용도)	
	public int reserveID() {		
		int count = 0;
		try {
			con = Util.getConnection();
			String sql = "select count(*) as count from reserve";
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {				
				count = rs.getInt("count");
			}					
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(con != null) con.close();
			} catch (Exception e) {e.printStackTrace();}
		}
		return count;		
	}
	
}
