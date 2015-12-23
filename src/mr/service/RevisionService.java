package mr.service;

import org.springframework.beans.factory.annotation.Autowired;



import org.springframework.stereotype.Service;

import mr.dao.RevisionDao;
import mr.domain.Revision;

@Service
public class RevisionService{
	@Autowired
	private RevisionDao rdao;
	
	
	public Revision getRevisionById() {
		// TODO Auto-generated method stub
		return null;
	}

	
	public void addRevision(Revision revision) {
//		System.out.println(revision.getAdvise());
		rdao.addRevision(revision);
	}
	

}
