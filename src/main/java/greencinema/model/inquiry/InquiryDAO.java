package greencinema.model.inquiry;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import greencinema.DBPKG.Util;


/*
 try {}catch(Exception e) {e.printStackTrace();}finally {
try {if(rs != null)rs.close();
if(pstmt != null)pstmt.close();
if(con != null)con.close();

}catch(Exception e) {
e.printStackTrace();
}
}
*/

public class InquiryDAO {
	Connection con = null;
	ResultSet rs = null;
	PreparedStatement pstmt = null;

	//admin  1:1  문의 전체 출력 메소드
	public ArrayList<InquiryDTO> inAllList(int StartRow, int pageSize) {
			ArrayList<InquiryDTO> i = new ArrayList<InquiryDTO>();
		try {
		con = Util.getConnection();
		String sql = "select * from inquiry order by inquiry_id desc limit ?,?"; // id는 파라미터로 set 받아야함.(임의로 user01지정)
		pstmt = con.prepareStatement(sql);
		pstmt.setInt(1, StartRow);
		pstmt.setInt(2, pageSize);
		rs = pstmt.executeQuery();
		
		while(rs.next()) {
			InquiryDTO idto = new InquiryDTO();
			idto.setInquiryId(rs.getInt(1));
			idto.setUserId(rs.getString(2));
			idto.setInquirySort(rs.getString(3));
			idto.setInquiryType(rs.getString(4));
			idto.setInquiryTitle(rs.getString(5));
			idto.setInquiryContent(rs.getString(6));
			idto.setReceptionType(rs.getInt(7));
			idto.setAnswerStatus(rs.getInt(8));
			idto.setAnswerContent(rs.getString(9));
			idto.setInquiryDate(rs.getString(10));
			
			i.add(idto);
			
		}
		
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
			if(rs != null) {
				rs.close();}
			if(pstmt != null) {
				pstmt.close();
			}
			if(con != null) {
				con.close();}
			}catch(Exception e) {
				e.printStackTrace();
			}
			}
			
		return i;
		
	}
	//------------------------------------------------------
	// 게시글 총 count 메소드
	public int AllCount() {
		int count=0;
		try {
			con = Util.getConnection();
			String sql = "select count(*) from inquiry";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				count = rs.getInt(1);
			}
			
			
		}catch(Exception e) {e.printStackTrace();}finally {
			try {if(rs != null)rs.close();
				if(pstmt != null)pstmt.close();
				if(con != null)con.close();

			}catch(Exception e) {
				e.printStackTrace();
			}
		}

		return count;
		
	}
	//로그인 개인회원 1:1문의 전체 출력 메소드
	public ArrayList<InquiryDTO> getAllList(String id, int StartRow, int pageSize){
		ArrayList<InquiryDTO> i = new ArrayList<InquiryDTO>();
		 try {
			 con = Util.getConnection();
			 String sql = "select * from inquiry where user_id=? order by inquiry_id desc limit ?,?";
			 pstmt = con.prepareStatement(sql);
			 pstmt.setString(1, id);
			 pstmt.setInt(2, StartRow);
			 pstmt.setInt(3, pageSize);
			 rs = pstmt.executeQuery();
			 
			 while(rs.next()) {
					InquiryDTO idto = new InquiryDTO();
					idto.setInquiryId(rs.getInt(1));
					idto.setUserId(rs.getString(2));
					idto.setInquirySort(rs.getString(3));
					idto.setInquiryType(rs.getString(4));
					idto.setInquiryTitle(rs.getString(5));
					idto.setInquiryContent(rs.getString(6));
					idto.setReceptionType(rs.getInt(7));
					idto.setAnswerStatus(rs.getInt(8));
					idto.setAnswerContent(rs.getString(9));
					idto.setInquiryDate(rs.getString(10));
					
					i.add(idto);
			 }
			 
		 }catch(Exception e) {e.printStackTrace();}finally {
			 try {if(rs != null)rs.close();
			 if(pstmt != null)pstmt.close();
			 if(con != null)con.close();

			 }catch(Exception e) {
			 e.printStackTrace();
			 }
			 }
		return i ;
		
	}
	
	//-------------------------------------
	//1:1문의 개인 Count문 + select문 
	// 로그인 회원 1:1 문의 count
	public int getOneCount(String id) {
		int count=0;
		try {
			con = Util.getConnection();
			String sql = "select count(*) from inquiry where user_id='?'";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				count = rs.getInt(1);
			}
			
			
		}catch(Exception e) {e.printStackTrace();}finally {
			try {if(rs != null)rs.close();
				if(pstmt != null)pstmt.close();
				if(con != null)con.close();

			}catch(Exception e) {
				e.printStackTrace();
			}
		}
		
		return count;
		
	}
	// 로그인 회원 select add
	public ArrayList<InquiryDTO> getOneList(String id, int StartRow, int pageSize){
		ArrayList<InquiryDTO> i = new ArrayList<InquiryDTO>();
		 try {
			 con = Util.getConnection();
			 String sql = "select * from inquiry where user_id=? order by inquiry_id desc limit ?,?";
			 pstmt = con.prepareStatement(sql);
			 
			 pstmt.setString(1, id);
			 pstmt.setInt(2, StartRow);
			 pstmt.setInt(3, pageSize);
			 rs = pstmt.executeQuery();
			 
			 while(rs.next()) {
					InquiryDTO idto = new InquiryDTO();
					idto.setInquiryId(rs.getInt(1));
					idto.setUserId(rs.getString(2));
					idto.setInquirySort(rs.getString(3));
					idto.setInquiryType(rs.getString(4));
					idto.setInquiryTitle(rs.getString(5));
					idto.setInquiryContent(rs.getString(6));
					idto.setReceptionType(rs.getInt(7));
					idto.setAnswerStatus(rs.getInt(8));
					idto.setAnswerContent(rs.getString(9));
					idto.setInquiryDate(rs.getString(10));
					
					i.add(idto);
			 }
			 
		 }catch(Exception e) {e.printStackTrace();}finally {
			 try {if(rs != null)rs.close();
			 if(pstmt != null)pstmt.close();
			 if(con != null)con.close();

			 }catch(Exception e) {
			 e.printStackTrace();
			 }
			 }
		return i ;
		
	}
	//-----------------------------------------------------------
	//Search (select, count)기능
	// search count
	public int sCount(String id, String type, String content) {
		int count=0;
		try {
			con = Util.getConnection();
			String sql = "select count(*) from inquiry where "+type+" like '%"+content+"%' ";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				count = rs.getInt(1);
			}
			
			
		}catch(Exception e) {e.printStackTrace();}finally {
			try {if(rs != null)rs.close();
				if(pstmt != null)pstmt.close();
				if(con != null)con.close();

			}catch(Exception e) {
				e.printStackTrace();
			}
		}
		return count;

		
	}
	// search select add
	public ArrayList<InquiryDTO> search(String type, String content, int Startpage, int pagesize){
			ArrayList<InquiryDTO> i = new ArrayList<InquiryDTO>();
		try { 
			con = Util.getConnection();
			String sql = "select * from inquiry where "+type+" like '%"+content+"%' limit ?,?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, Startpage);
			pstmt.setInt(2, pagesize);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				InquiryDTO idto = new InquiryDTO();
				idto.setInquiryId(rs.getInt(1));
				idto.setUserId(rs.getString(2));
				idto.setInquirySort(rs.getString(3));
				idto.setInquiryType(rs.getString(4));
				idto.setInquiryTitle(rs.getString(5));
				idto.setInquiryContent(rs.getString(6));
				idto.setReceptionType(rs.getInt(7));
				idto.setAnswerStatus(rs.getInt(8));
				idto.setAnswerContent(rs.getString(9));
				idto.setInquiryDate(rs.getString(10));
				
				i.add(idto);
			}
			
			
		}catch(Exception e) {e.printStackTrace();}finally {
			 try {if(rs != null)rs.close();
			 if(pstmt != null)pstmt.close();
			 if(con != null)con.close();

			 }catch(Exception e) {
			 e.printStackTrace();
			 }
			 }
		
		return i;
	} 
	// 문의글 등록 메소드
	public boolean insert(InquiryDTO idto) {
		boolean result = false;
		 try {
			 con = Util.getConnection();
			 String sql = "INSERT INTO inquiry\r\n"
			 		+ "(user_id,inquiry_sort,inquiry_type,inquiry_title,inquiry_content,reception_type,answer_status,answer_content,inquiry_date)\r\n"
			 		+ "VALUES\r\n"
			 		+ "\r\n"
			 		+ "(?, ?, ?, ?,\r\n"
			 		+ " ?,?,0,null,current_date());";
			 pstmt = con.prepareStatement(sql);
			 pstmt.setString(1, idto.getUserId());
			 pstmt.setString(2, idto.getInquirySort());
			 pstmt.setString(3, idto.getInquiryType());
			 pstmt.setString(4, idto.getInquiryTitle());
			 pstmt.setString(5, idto.getInquiryContent());
			 pstmt.setInt(6, idto.getReceptionType());
			 result = pstmt.executeUpdate() > 0;
			 
			 
		 }catch(Exception e) {e.printStackTrace();}finally {
			 try {if(rs != null)rs.close();
			 if(pstmt != null)pstmt.close();
			 if(con != null)con.close();

			 }catch(Exception e) {
			 e.printStackTrace();
			 }
			 }
		 return result;
		
	}
	
	//하나의 게시글 한페이지에 출력하는 메소드
	public InquiryDTO getOneInquiry(int num) {
			InquiryDTO i = new InquiryDTO();
		 try {
			 con = Util.getConnection();
			 String sql = "select * from inquiry where inquiry_id=?";
			 pstmt = con.prepareStatement(sql);
			 pstmt.setInt(1, num);
			 rs = pstmt.executeQuery();
			 if(rs.next()) {
				 i.setInquiryId(rs.getInt(1));
				 i.setUserId(rs.getString(2));
				 i.setInquirySort(rs.getString(3));
				 i.setInquiryType(rs.getString(4));
				 i.setInquiryTitle(rs.getString(5));
				 i.setInquiryContent(rs.getString(6));
				 i.setReceptionType(rs.getInt(7));
				 i.setAnswerStatus(rs.getInt(8));
				 i.setAnswerContent(rs.getString(9));
				 i.setInquiryDate(rs.getString(10));

			 }
			 
		 }catch(Exception e) {e.printStackTrace();}finally {
			 try {if(rs != null)rs.close();
			 if(pstmt != null)pstmt.close();
			 if(con != null)con.close();

			 }catch(Exception e) {
			 e.printStackTrace();
			 }
			 }
		 return i;
		
	}
	
	}
	


