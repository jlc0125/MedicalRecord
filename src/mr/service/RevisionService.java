package mr.service;


import java.util.List;

import mr.dao.RevisionDao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class RevisionService {
	
	@Autowired
	private RevisionDao rvsDao;
	
	public List getRevisionList(){
		return rvsDao.getRevisionList();
	}
	
	public void setAgree(int agree,int id){
		rvsDao.setAgree(agree, id);
	}
	
	public void setDisagree(int disagree,int id){
		rvsDao.setDisagree(disagree, id);
	}
}
