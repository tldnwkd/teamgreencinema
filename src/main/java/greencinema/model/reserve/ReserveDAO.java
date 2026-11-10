package greencinema.model.reserve;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

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

}
