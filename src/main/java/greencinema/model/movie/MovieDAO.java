package greencinema.model.movie;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import greencinema.DBPKG.Util;
import greencinema.model.faq.FaqDTO;

public class MovieDAO {
	Connection con = null;
	ResultSet rs = null;
	PreparedStatement pstmt = null;
	
	
	public ArrayList<MovieDTO> getAllMovieList () {
		ArrayList<MovieDTO> list = new ArrayList<>();
		
		try {
			con = Util.getConnection();
			String sql = "select * from movie";
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			while(rs.next()) {
				
				System.out.println("movie_title : " + rs.getString("movie_title"));
				MovieDTO mvdto = new MovieDTO();
				mvdto.setMovieId(rs.getInt("movie_id"));
				mvdto.setImgPath(rs.getString("img_path"));
				mvdto.setMovieContent(rs.getString("movie_content"));
				mvdto.setMovieRate(rs.getInt("movie_rate"));
				mvdto.setMovieTitle(rs.getString("movie_title"));
				mvdto.setRunTime(rs.getInt("run_time"));
				
				list.add(mvdto);
			}		
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(con != null) con.close();
				if(con != null) con.close();
				if(con != null) con.close();
			} catch (Exception e) {e.printStackTrace();}
		}
		return list;		
	}

	
	public int movieAllCount() {
		int count=0;
		try {
			con = Util.getConnection();
			String sql = "select count(*) from movie";
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
	
	public ArrayList<MovieDTO> movieAllList(int StartRow, int pageSize){
		ArrayList<MovieDTO> mList = new ArrayList<MovieDTO>();
		 try {
			 con = Util.getConnection();
			 String sql = "select * from movie order by movie_id desc limit ?,?";
			 pstmt = con.prepareStatement(sql);
			 pstmt.setInt(1, StartRow);
			 pstmt.setInt(2, pageSize);
			 rs = pstmt.executeQuery();
			 
			 while(rs.next()) {
				 MovieDTO mdto = new MovieDTO();
				 mdto.setMovieId(rs.getInt("movie_id"));
				 mdto.setMovieRate(rs.getInt("movie_rate"));
				 mdto.setMovieContent(rs.getString("movie_content"));
				 mdto.setMovieTitle(rs.getString("movie_title"));
				 mdto.setImgPath(rs.getString("img_path"));
				 mdto.setRunTime(rs.getInt("run_time"));
				 
				 mList.add(mdto);				 
			 }
			 
			 
		 }catch(Exception e) {e.printStackTrace();}finally {
			 try {if(rs != null)rs.close();
			 if(pstmt != null)pstmt.close();
			 if(con != null)con.close();

			 }catch(Exception e) {
			 e.printStackTrace();
			 }
			 }
		 return mList;
	}

	//--movie search 메소드
	public int mCount(String type, String content) {
		int count=0;
		try {
			con = Util.getConnection();
			String sql = "select count(*) from movie where "+type+" like '%"+content+"%' ";
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
	// search select add
	public ArrayList<MovieDTO> search(String type, String content, int Startpage, int pagesize){
			ArrayList<MovieDTO> m = new ArrayList<MovieDTO>();
		try { 
			con = Util.getConnection();
			String sql = "select * from movie where "+type+" like '%"+content+"%' order by movie_id desc limit ?,?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, Startpage);
			pstmt.setInt(2, pagesize);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				MovieDTO mdto = new MovieDTO();
				mdto.setMovieId(rs.getInt("movie_id"));
				mdto.setMovieRate(rs.getInt("movie_rate"));
				mdto.setMovieContent(rs.getString("movie_content"));
				mdto.setMovieTitle(rs.getString("movie_title"));
				mdto.setImgPath(rs.getString("img_path"));
				mdto.setRunTime(rs.getInt("run_time"));
				
				m.add(mdto);
			}
			
			
		}catch(Exception e) {e.printStackTrace();}finally {
			 try {if(rs != null)rs.close();
			 if(pstmt != null)pstmt.close();
			 if(con != null)con.close();

			 }catch(Exception e) {
			 e.printStackTrace();
			 }
			 }
		
		return m;
	} 
	
}
