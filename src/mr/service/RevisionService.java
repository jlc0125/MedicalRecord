package mr.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;



import org.springframework.stereotype.Service;

import mr.dao.RevisionDao;
import mr.domain.Revision;

@Service
public class RevisionService{
	@Autowired
	private RevisionDao rvsDao;
	
	
	public Revision getRevisionById() {
		// TODO Auto-generated method stub
		return null;
	}

	
	public void addRevision(Revision revision) {
//		System.out.println(revision.getAdvise());
		rvsDao.addRevision(revision);
	}
	
	
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
