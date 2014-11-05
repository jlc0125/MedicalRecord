package mr.domain;

import java.io.Serializable;
import java.util.Date;

public class LoginLog implements Serializable{
	private int loginLogId;
	private Long userId;
	private String ip;
	private Date loginDate;
	public int getLoginLogId() {
		return loginLogId;
	}
	public void setLoginLogId(int loginLogId) {
		this.loginLogId = loginLogId;
	}
	public Long getUserId() {
		return userId;
	}
	public void setUserId(Long long1) {
		this.userId = long1;
	}
	public String getIp() {
		return ip;
	}
	public void setIp(String ip) {
		this.ip = ip;
	}
	public Date getLoginDate() {
		return loginDate;
	}
	public void setLoginDate(Date loginDate) {
		this.loginDate = loginDate;
	}
	
	

}
