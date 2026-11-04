package greencinema.model.user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import greencinema.DBPKG.Util;

public class UserDAO {

	Connection con = null;
	ResultSet rs = null;
	PreparedStatement pstmt = null;
	
	
	public boolean duplicateChk(String userId) {
		boolean isDuplicate = false;
		try {

			con = Util.getConnection();
			String sql = "SELECT * FROM user where user_id = ?";
			pstmt = con.prepareStatement(sql);
			
			if(rs.next()) {				
				isDuplicate = true;
			}
			
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
		return isDuplicate;
		
	}
	
	
	public void joinUser(UserDTO udto) {		
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
			
			pstmt.executeUpdate();
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
	
	
	public boolean loginCheck(String userId, String userPw) {
		boolean isLogin = false;
		try {
			con = Util.getConnection();
			String sql = "SELECT * FROM user WHERE user_id = ? and user_pw = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, userId);
			pstmt.setString(2, userPw);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				isLogin = true;
			}
			
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
		
		return isLogin;
	}
	
	
}
