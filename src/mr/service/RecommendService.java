package mr.service;

import java.util.ArrayList;
import java.util.List;

import mr.dao.MedicalRecordSimilarityDao;
import mr.domain.MedicalRecord;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class RecommendService {
	@Autowired
	private MedicalRecordSimilarityDao mrsDao;
	
	@Autowired
	private MedicalRecordService mrService;
	
	
	public void calSim(){
		mrsDao.dropTable();
		mrsDao.createTable();
	}
	
	public List<MedicalRecord> simRecords(int recordId,int size){
		
		List<Integer> recordIds=mrsDao.getSimRecord(recordId, size);
		List<MedicalRecord> retval=new ArrayList<MedicalRecord>();
		for(int id:recordIds){
			retval.add(mrService.recordByIndex(id));
		}
		return retval;
	}
}
