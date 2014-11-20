package mr.service;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import mr.dao.ZZNaiveBayesDao;
import mr.dao.MedDao;
import mr.domain.MedicalRecord;
import mr.domain.ZZNaiveBayes;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ZZNaiveBayesService {
	@Autowired
	private ZZNaiveBayesDao zDao;
	@Autowired
	private MedDao mDao;
	@Autowired
	private MedicalRecordService mrs;

	public Map<String,Float> freqUsedMeds(String word){
		Map<String,Float> result=new HashMap<String,Float>();
		Long id=zDao.indexOf(word);
		if (id==-1) return result;
		ZZNaiveBayes zz=zDao.getById(id);
		String pStr=zz.getLikelihood();
		String[] pArray=pStr.split(" ");
		List<Likelihood> pList=new ArrayList<Likelihood>();
		for(int i=0;i<pArray.length;i++){
			//因为med_vocab字典从1开始，所以i+1
			pList.add(new Likelihood((long) i+1,Float.parseFloat(pArray[i])));
		}
		
		Collections.sort(pList);
		float threshold=0.9f;
		float cover=0.0f;
		for(int i=pList.size()-1;i>=0;i--){
			if (cover<threshold) result.put(mDao.getMedById(pList.get(i).medId).getName(),pList.get(i).likelihood);
			else break;
			cover+=pList.get(i).likelihood;
		}
		
		
		return result;
	}
	
	
	class Likelihood implements Comparable<Likelihood>{
		public Likelihood(Long medId,Float likelihood){
			this.medId=medId;
			this.likelihood=likelihood;
		}
		Long medId;
		Float likelihood;
		
		@Override
		public int compareTo(Likelihood o) {
			if (this.likelihood<o.likelihood) return -1;
			if (this.likelihood>o.likelihood) return 1;
			return 0;
		}
		
	}
	
	
	public List<MedicalRecord> containRecords(String word){
		List<MedicalRecord> records=new ArrayList<MedicalRecord>();
		Long id=zDao.indexOf(word);
		if (id==-1) return records;
		ZZNaiveBayes zz=zDao.getById(id);
		String recordsCol=zz.getRecords();
		if(recordsCol==null||recordsCol==""){
			return records;
		}
		String[] recordsStr=recordsCol.split(" ");
		for(String idStr:recordsStr){
			records.add(mrs.getRecordById(Integer.parseInt(idStr)));
		}
		
		return records;
		
	}
}
