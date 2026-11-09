package greencinema.model.user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import greencinema.DBPKG.Util;
import greencinema.model.inquiry.InquiryDTO;
import greencinema.model.reserve.ReserveDTO;

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
	
	
	// 예매리스트 정보
	public ArrayList<ReserveDTO> getReserveList (String userId) {
		ArrayList<ReserveDTO> rList = new ArrayList<>();
		try {
			con = Util.getConnection();
			String sql = "SELECT * FROM reserve WHERE user_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, userId);		
			rs = pstmt.executeQuery();
						
			while(rs.next()) {
				ReserveDTO rdto = new ReserveDTO();
				rdto.setUserId(rs.getString("user_id"));
				rdto.setAdultCount(rs.getInt("adult_count"));
				rdto.setTeensCount(rs.getInt("teens_count"));
				rdto.setTotalPrice(rs.getInt("total_price"));
				rdto.setUserId(rs.getString("user_id"));
				rdto.setReserveId(rs.getInt("reserve_id"));
				rdto.setReserveDate(rs.getDate("reserve_date"));
				rdto.setCancelDate(rs.getDate("cancel_date"));
				rList.add(rdto);
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
		
		
		return rList;
	}
	
	// 1:1문의 리스트 추가
	public ArrayList<InquiryDTO> getInquiryList (String userId) {
		ArrayList<InquiryDTO> iList = new ArrayList<>();
		try {
			con = Util.getConnection();
			String sql = "SELECT * FROM inquiry WHERE user_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, userId);		
			rs = pstmt.executeQuery();
						
			while(rs.next()) {
				InquiryDTO idto = new InquiryDTO();
				idto.setInquiryId(rs.getInt("inquiry_id"));
				idto.setInquirySort(rs.getString("inquiry_sort"));
				idto.setInquiryType(rs.getString("inquiry_type"));
				idto.setInquiryTitle(rs.getString("inquiry_title"));
				idto.setInquiryContent(rs.getString("inquiry_content"));
				idto.setReceptionType(rs.getInt("reception_type"));
				idto.setAnswerStatus(rs.getInt("answer_status"));
				idto.setAnswerContent(rs.getString("answer_content"));
				iList.add(idto);
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
		
		return iList;
	}
	
	
	public InquiryDTO getInquiry (String userId) {
		InquiryDTO idto = new InquiryDTO();
		try {
			con = Util.getConnection();
			String sql = "SELECT * FROM inquiry WHERE user_id = ? order by inquiry_date desc limit 1;";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, userId);		
			rs = pstmt.executeQuery();
						
			while(rs.next()) {				
				idto.setInquiryId(rs.getInt("inquiry_id"));
				idto.setInquirySort(rs.getString("inquiry_sort"));
				idto.setInquiryType(rs.getString("inquiry_type"));
				idto.setInquiryTitle(rs.getString("inquiry_title"));
				idto.setInquiryContent(rs.getString("inquiry_content"));
				idto.setReceptionType(rs.getInt("reception_type"));
				idto.setAnswerStatus(rs.getInt("answer_status"));
				idto.setAnswerContent(rs.getString("answer_content"));
			}
			
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
		
		return idto;
	}
	
	
	public UserDTO getUser(String userId) {
		UserDTO userDto = new UserDTO();
		try {
			con = Util.getConnection();
			String sql = "SELECT * FROM USER WHERE user_id = ?";						
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, userId);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
			    userDto.setUserId(rs.getString(1));
			    userDto.setUserPw(rs.getString(2));
			    userDto.setUserName(rs.getString(3));
			    userDto.setUserBirth(rs.getString(4));
			    userDto.setUserEmail(rs.getString(5));
			    userDto.setUserPhone(rs.getString(6));
			}
			
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
		return userDto;
	}
	
	public MyPageDTO getMyPage(String id) {
		MyPageDTO mydto = new MyPageDTO();
		
		try {
			con = Util.getConnection();
			String sql = "SELECT\r\n"		
					+ "     m.movie_title                           AS        movie_title"
					+ "    , m.img_path                              AS        img_path"
					+ "    , sc.screen_num                           AS        screen_num"
					+ "    , CONCAT(t.large_region, ' ', t.small_region) AS    region"
					+ "    , s.schedule_starttime                    AS        schedule_starttime"
					+ "    , r.adult_count                           AS        adult_count"
					+ "    , r.teens_count                           AS        teens_count"
					+ "    , seat_info.seat_num                      AS        seat_num"
					+ "    , r.total_price                           AS        total_price"
					+ "    , CASE p.payment_method"
					+ "        WHEN 1 THEN '신용카드'"
					+ "        WHEN 2 THEN '계좌이체'"
					+ "      END                                     AS payment_method"
					+ "    , r.cancel_date                           AS cancel_date"
					+ "    , CASE"
					+ "        WHEN r.cancel_date IS NULL THEN '예매 완료'"
					+ "        ELSE '취소됨'"
					+ "      END                                     AS payment_status"
					+ "    , r.reserve_id                                       AS reserve_id"
					+ " FROM reserve r"
					+ " JOIN user u ON r.user_id = u.user_id"
					+ " JOIN payment p ON r.reserve_id = p.reserve_id"
					+ " JOIN seat seat_info ON r.reserve_id = seat_info.reserve_id"
					+ " JOIN screen sc ON seat_info.screen_id = sc.screen_id"
					+ " JOIN theater t ON sc.theater_id = t.theater_id"
					+ " JOIN schedule s ON sc.screen_id = s.screen_id"
					+ "    AND s.schedule_starttime >= DATE_SUB(r.reserve_date, INTERVAL 7 DAY)"
					+ "    AND s.schedule_starttime <= DATE_ADD(r.reserve_date, INTERVAL 1 DAY)"
					+ " JOIN movie m ON s.movie_id = m.movie_id"
					+ " WHERE u.user_id = ? and r.cancel_date is null"
					+ " GROUP BY r.reserve_id"
					+ " ORDER BY r.reserve_date DESC"
					+ " limit 1";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {

				mydto.setMovieTitle(rs.getString(1));
				mydto.setImgPath(rs.getString(2));
				mydto.setScreenNum(rs.getInt(3));
				mydto.setRegion(rs.getString(4));
				mydto.setScheduleStarttime(rs.getString(5));
				mydto.setAdultCount(rs.getInt(6));
				mydto.setTeensCount(rs.getInt(7));
				mydto.setSeatNum(rs.getString(8));
				mydto.setTotalPrice(rs.getInt(9));
				mydto.setPaymentMethod(rs.getString(10));
				mydto.setCancelDate(rs.getString(11));
				mydto.setPaymentStatus(rs.getString(12));
			}		
			
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
		
		return mydto;		
	}
	
	
}
