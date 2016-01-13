package mr.service;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import mr.dao.MedicalRecordDao;
import mr.dao.WordDao;
import mr.domain.MedicalRecord;

@Service
public class MedicalRecordService {
	@Autowired
	private MedicalRecordDao mrDao;
	@Autowired
	private WordDao wordDao;
	
	private class simWithId implements Comparable<simWithId>{
		Integer id;
		Double sim;
		@Override
		public int compareTo(simWithId arg0) {
			return this.sim.compareTo(arg0.sim);
		}
		public simWithId(Integer id,Double sim){
			this.id=id;
			this.sim=sim;
		}
		
	}
	
	
	//医案对关键字的相关程度排序，返回医案id的列表
	public List<Integer> similaritySort(String[] words){
		List<Integer> wordIds=new ArrayList<Integer>();
		for (int i=0;i<words.length;i++){
			Integer id=wordDao.indexOfWord(words[i]);
			if (id!=-1){
				wordIds.add(id);
				System.out.println(id);
				System.out.println(words[i]);
			}
			
		}
		List<HashMap<Integer,Double>> allTfidf=mrDao.allTfidf();
		List<simWithId> simList=new ArrayList<simWithId>();
		
		Double sim;
		HashMap<Integer,Double> tfidf;
		for(int i=0;i<allTfidf.size();i++){
			tfidf=allTfidf.get(i);
			sim=0.0;
			for(int wordId:wordIds){
				if(tfidf.containsKey(wordId)) sim+=tfidf.get(wordId);
			}
			simList.add(new simWithId(i,sim));
		} 
		
		Collections.sort(simList);
		List<Integer> result=new ArrayList<Integer>();
		for(int i=0;i<simList.size();i++){
			result.add(simList.get(simList.size()-1-i).id+1);
		}
		for(int i=0;i<10;i++){
			System.out.println(result.get(i));
		}
		return result;
	}
	
	//调用similaritySort,返回详细医案,list<map>格式
	public List<MedicalRecord> relRecords(String[] words){
		List<Integer> simSort=similaritySort(words);
		List<MedicalRecord> result=new ArrayList<MedicalRecord>();
		for(int i=0;i<100;i++){
			result.add(mrDao.recordByIndex(simSort.get(i)));
		}
		return result;
	}

	public MedicalRecord recordByIndex(final int index){
		return mrDao.recordByIndex(index);
	}
	
	//医生医案
	public List<MedicalRecord> recordByDoctor(String doctorName){
		return mrDao.recordByDoctor(doctorName);
	}
	
	public List<MedicalRecord> recordByReference(String reference){
		return mrDao.recordByReference(reference);
	}

	public List<MedicalRecord> recommend(MedicalRecord mr){
		//推荐医案
		return null;
	}
	
	public MedicalRecord getRecordById(int id){
		return mrDao.recordByIndex(id);
	}
	
	public List<MedicalRecord> recordByDoctorId(Long id){
		return mrDao.recordByDoctorId(id);
	}
	
	public List<MedicalRecord> recordByCategory(String secCateName){
		return mrDao.recordByCategory(secCateName);
	}
	
	public List<MedicalRecord> recordByDisc(String discriminate){
		return mrDao.recordyDisc(discriminate);
	}
	
	
	public List<MedicalRecord> recordByTher(String therapy){
		return mrDao.recordyDisc(therapy);
	}
	
	public List<MedicalRecord> recordByWF(String word){
		return mrDao.recordyDisc(word);
	}

	public List<MedicalRecord> recordByContentContain(String[] words){
		return mrDao.reocrdByContentContain(words);
	}
	
	public List<MedicalRecord> recordByZhifa(String word){
		return mrDao.recordByZhifa(word);
	}
	
	public List<MedicalRecord> recordByFirstCategory(String word){
		return mrDao.recordByFirstCategory(word);
	}
}

