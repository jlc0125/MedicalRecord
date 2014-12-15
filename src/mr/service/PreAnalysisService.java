package mr.service;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import mr.dao.MedDao;
import mr.dao.PrescriptionDao;
import mr.domain.Med;
import mr.domain.Prescription;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class PreAnalysisService {
	
	@Autowired
	private MedDao medDao;
	
	@Autowired
	private PrescriptionDao preDao;
	
	public Map<String,Object> getPreMap(String[] preSeg){
		
		System.out.println("=========================getPreMap========================");
		Map<String,Object> result=new HashMap<String,Object>();
		List<Med> allMed=medDao.allMeds();
		List<String> medVocab=new ArrayList<String>();
		for(int i=0;i<allMed.size();i++){
			medVocab.add(allMed.get(i).getName());
		}
		System.out.println("medVocab.size="+medVocab.size());
		List<String> medList=new ArrayList<String>();
		for(String p:preSeg){
			if(medVocab.indexOf(p)!=-1) medList.add(p);
		}
		
		System.out.println("medList.size="+medList.size());
		
		List<Prescription> allPre=preDao.allPre();
		
		System.out.println("allPre.size="+allPre.size());
		
		List<Prescription> classicPreList=new ArrayList<Prescription>();
		for(int i=0;i<allPre.size();i++){
			String[] meds=allPre.get(i).getDosage().trim().split(" ");
			allPre.get(i).setMedNum(meds.length);
			boolean flag=true;
			for (String m:meds){
				if(medList.indexOf(m)==-1){
					flag=false;
					break;
				}
			}
			if(flag){
				classicPreList.add(allPre.get(i));
			}
		}
		System.out.println("classicPreList.size="+classicPreList.size());
		Collections.sort(classicPreList, new Comparator<Prescription>() {
			public int compare(Prescription arg0, Prescription arg1) {
				return arg0.getMedNum().compareTo(arg1.getMedNum());
			}
		});
		
		Collections.reverse(classicPreList);
		
		List<Prescription> topPreList=classicPreList.subList(0, 5);
		List<String> usedMeds=new ArrayList<>();
		for(Prescription p:topPreList){
			String[] meds=p.getDosage().trim().split(" ");
			for(String med:meds){
				if(usedMeds.indexOf(med)==-1) usedMeds.add(med);
			}
		}
		
		List<String> unusedMeds=new ArrayList<String>();
		for(String med:medList){
			if(usedMeds.indexOf(med)==-1) unusedMeds.add(med);
		}
		
		result.put("经方", topPreList);
		result.put("自用药",unusedMeds);
		result.put("中草药", medList);
		
		return result;
	}
}
