package mr.service;

import java.util.List;

import mr.dao.DrugDao;
import mr.domain.TempNode;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mongodb.DBObject;


@Service
public class DrugService {
	@Autowired
	private DrugDao drugDao;
	
	public Object search(String name){
		return drugDao.search(name);
	}

	public List<DBObject> searchBeginWith(String name){
		return drugDao.searchBeginWith(name);
	}
	
	public String[] relate(String name){
		return drugDao.relate(name);
	}
	
	public List abbrBeginWith(String abbr){
		return drugDao.abbrBeginWith(abbr);
	}
	
	public List pinciSearch(int freq){
		return drugDao.pinciSearch(freq);
	}
	
	public TempNode[] symptomSearchDrug(String symptomName){
		return drugDao.symptomSearchDrug(symptomName);
	}
	
	public TempNode[] recipeSearchDrug(String recipeName){
		return drugDao.recipeSearchDrug(recipeName);
	}
}
