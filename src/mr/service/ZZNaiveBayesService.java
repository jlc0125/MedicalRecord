package mr.service;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import mr.dao.ZZNaiveBayesDao;
import mr.dao.MedDao;
import mr.domain.ZZNaiveBayes;
import mr.domain.Med;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ZZNaiveBayesService {
	@Autowired
	private ZZNaiveBayesDao zDao;
	@Autowired
	private MedDao mDao;

	public List<Med> freqUsedMeds(String word){
		List<Med> result=new ArrayList<Med>();
		Long id=zDao.indexOf(word);
		if (id==-1) return null;
		ZZNaiveBayes bz=zDao.getById(id);
		String pStr=bz.getLikelihood();
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
			cover+=pList.get(i).likelihood;
			if (cover<threshold) result.add(mDao.getMedById(pList.get(i).medId));
			else break;
			System.out.println(mDao.getMedById(pList.get(i).medId).getName());
			System.out.println(pList.get(i).likelihood);
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
}
