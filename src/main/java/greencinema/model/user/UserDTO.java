package greencinema.model.user;

import java.util.Date;

public class UserDTO {
	
	private String userId;	
	private String userPw;
	private String userName;
	private Date userBirth;
	private String userEmail;
	private String userPhone;
	private int userDelete;
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getUserPw() {
		return userPw;
	}
	public void setUserPw(String userPw) {
		this.userPw = userPw;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public Date getUserBirth() {
		return userBirth;
	}
	public void setUserBirth(Date userBirth) {
		this.userBirth = userBirth;
	}
	public String getUserEmail() {
		return userEmail;
	}
	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}
	public String getUserPhone() {
		return userPhone;
	}
	public void setUserPhone(String userPhone) {
		this.userPhone = userPhone;
	}
	public int getUserDelete() {
		return userDelete;
	}
	public void setUserDelete(int userDelete) {
		this.userDelete = userDelete;
	}	
	
}
