package greencinema.model.user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import greencinema.DBPKG.Util;

public class UserDAO {

	Connection con = null;
	ResultSet rs = null;
	PreparedStatement pstmt = null;
	
	public void joinUser(UserDTO udto) {
		int result = 0;
		
		try {

			con = Util.getConnection();
			String sql = "INSERT INTO user VALUES (?, ?, ?, ?, ?, ?, 0)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, udto.getUserId());
			pstmt.setString(2, udto.getUserPw());
			pstmt.setString(3, udto.getUserName());
			pstmt.setString(4, udto.getUserBirth());
			pstmt.setString(5, udto.getUserEmail());
			pstmt.setString(6, udto.getUserPhone());
			
			
			
			result = pstmt.executeUpdate();
		}catch (Exception e) {
			
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
