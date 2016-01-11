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

	
}
