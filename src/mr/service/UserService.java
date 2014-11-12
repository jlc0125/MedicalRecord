package mr.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import mr.dao.LoginLogDao;
import mr.dao.UserDao;
import mr.domain.LoginLog;
import mr.domain.MedicalRecord;
import mr.domain.User;

@Service
public class UserService {
    
	@Autowired
	private UserDao userDao;
	
	@Autowired
	private LoginLogDao loginLogDao;

	public boolean hasMatchUser(String userName, String password) {
		int matchCount =userDao.getMatchCount(userName, password);
		return matchCount > 0;
	}
	
	public User findUserByUserName(String userName) {
		return userDao.findUserByUserName(userName);
	}
	
	public void loginSuccess(User user) {
		
		LoginLog loginLog = new LoginLog();
		loginLog.setUserId(user.getUserId());
		loginLog.setIp(user.getLastIp());
		loginLog.setLoginDate(user.getLastVisit());
        userDao.updateLoginInfo(user);
        loginLogDao.insertLoginLog(loginLog);
	}
	
	public void collect(User user,int recordId){
		//添加收藏
	}
	
	public List<MedicalRecord> recommend(User user){
		//推荐医案
		return null;
	}

}
