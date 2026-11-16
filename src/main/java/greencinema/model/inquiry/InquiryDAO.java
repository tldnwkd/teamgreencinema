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

	//admin  1:1  臾몄쓽 �쟾泥� 異쒕젰 硫붿냼�뱶
	public ArrayList<InquiryDTO> inAllList(int StartRow, int pageSize) {
			ArrayList<InquiryDTO> i = new ArrayList<InquiryDTO>();
		try {
		con = Util.getConnection();
		String sql = "select * from inquiry order by inquiry_id desc limit ?,?"; // id�뒗 �뙆�씪誘명꽣濡� set 諛쏆븘�빞�븿.(�엫�쓽濡� user01吏��젙)
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
	// 寃뚯떆湲� 珥� count 硫붿냼�뱶
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
	//濡쒓렇�씤 媛쒖씤�쉶�썝 1:1臾몄쓽 �쟾泥� 異쒕젰 硫붿냼�뱶
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
	//1:1臾몄쓽 媛쒖씤 Count臾� + select臾� 
	// 濡쒓렇�씤 �쉶�썝 1:1 臾몄쓽 count
	public int getOneCount(String id) {
		int count=0;
		try {
			con = Util.getConnection();
			String sql = "select count(*) from inquiry where user_id=?";
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
	// 濡쒓렇�씤 �쉶�썝 select add
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
	//Search (select, count)湲곕뒫
	// search count
	public int sCount(String id, String type, String content) {
		int count=0;
		
		String column = "";
		
		if("inquiry_title".equals(type)) {
			column = "inquiry_title";
		}else if("inquiry_type".equals(type)) {
			column = "inquiry_type";
		}else if("inquiry_Sort".equals(type)) {
			column = "inquiry_Sort";
		}else if("answer_status".equals(type)) {
			column = "answer_status";
		}else {
		    throw new IllegalArgumentException("잘못된 검색 조건");
		}
		
		try {
			con = Util.getConnection();
			String sql = "select count(*) from inquiry where user_id=? and "+column+" like ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, "%" + content + "%");
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
	public ArrayList<InquiryDTO> search(String type, String content, int Startpage, int pagesize, String chkid){
			ArrayList<InquiryDTO> i = new ArrayList<InquiryDTO>();
			
			
			String column = "";
			
			if("inquiry_title".equals(type)) {
				column = "inquiry_title";
			}else if("inquiry_type".equals(type)) {
				column = "inquiry_type";
			}else if("inquiry_Sort".equals(type)) {
				column = "inquiry_Sort";
			}else if("answer_status".equals(type)) {
				column = "answer_status";
			}else {
			    throw new IllegalArgumentException("잘못된 검색 조건");
			}
			
			
		try { 
			con = Util.getConnection();
			String sql = "select * from inquiry where user_id=? and "+ column +" like ? limit ?,?";
			System.out.println(sql);
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, chkid);
			pstmt.setString(2, "%" + content + "%");
			pstmt.setInt(3, Startpage);
			pstmt.setInt(4, pagesize);
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
	// 臾몄쓽湲� �벑濡� 硫붿냼�뱶
	public boolean insert(InquiryDTO idto) {
		boolean result = false;
		 try {
			 con = Util.getConnection();
			 String sql = "INSERT INTO inquiry\r\n"
			 		+ "(user_id,inquiry_sort,inquiry_type,inquiry_title,inquiry_content,reception_type,answer_status,answer_content,inquiry_date)\r\n"
			 		+ "VALUES\r\n"
			 		+ "\r\n"
			 		+ "(?, ?, ?, ?,\r\n"
			 		+ " ?,?,0,null,NOW());";
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
	
	//�븯�굹�쓽 寃뚯떆湲� �븳�럹�씠吏��뿉 異쒕젰�븯�뒗 硫붿냼�뱶
	public InquiryDTO getOneInquiry(int num, String id) {
			InquiryDTO i = null;
		 try {
			 con = Util.getConnection();
			 String sql = "select * from inquiry where inquiry_id=? and user_id=?";
			 pstmt = con.prepareStatement(sql);
			 pstmt.setInt(1, num);
			 pstmt.setString(2, id);
			 rs = pstmt.executeQuery();
			 if(rs.next()) {
				 i = new InquiryDTO();
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
	// OneInquiryInsert 사용 - 1:1문의 수정
	public int getOneUpdate(String title, String content, int inquiryId, String id) {
	    int result = 0;

	    try {
	        con = Util.getConnection();

	        String sql = "UPDATE inquiry "
	                   + "SET inquiry_title=?, inquiry_content=? "
	                   + "WHERE inquiry_id=? AND user_id = ?";

	        pstmt = con.prepareStatement(sql);
	        pstmt.setString(1, title);
	        pstmt.setString(2, content);
	        pstmt.setInt(3, inquiryId);
	        pstmt.setString(4, id);

	        result = pstmt.executeUpdate();

	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        try {
	            if (pstmt != null) pstmt.close();
	            if (con != null) con.close();
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	    }

	    return result;
	}
	
	public int OneDelete(int inquiryId, String id) {
	    int result = 0;

	    try {
	        con = Util.getConnection();

	        String sql = "delete from inquiry where inquiry_id=? and user_id=?";

	        pstmt = con.prepareStatement(sql);
	        pstmt.setInt(1, inquiryId);
	        pstmt.setString(2, id);

	        result = pstmt.executeUpdate();

	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        try {
	            if (pstmt != null) pstmt.close();
	            if (con != null) con.close();
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	    }
		
		return result;
	}
	
	}
	


