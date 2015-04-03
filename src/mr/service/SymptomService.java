package mr.service;

import java.util.List;

import mr.dao.SymptomDao;
import mr.domain.TempNode;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mongodb.DBObject;

@Service
public class SymptomService {
	@Autowired
	private SymptomDao symptomDao;
	
	public Object search(String name){
		return symptomDao.search(name);
	}

	public List<DBObject> searchBeginWith(String name){
		return symptomDao.searchBeginWith(name);
	}
	
	public String[] relate(String name){
		return symptomDao.relate(name);
	}
	
	public List abbrBeginWith(String abbr){
		return symptomDao.abbrBeginWith(abbr);
	}
	
	public List pinciSearch(int freq){
		return symptomDao.pinciSearch(freq);
	}
	
	public TempNode[] drugSearchSymptom(String drugName){
		return symptomDao.drugSearchSymptom(drugName);
	}
	
	public TempNode[] recipeSearchSymptom(String recipeName){
		return symptomDao.recipeSearchSymptom(recipeName);
	}
}
