package mr.service;

import java.util.List;

import mr.dao.PrescriptionDao;
import mr.dao.RecipeDao;
import mr.domain.TempNode;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mongodb.DBObject;


@Service
public class RecipeService {
	@Autowired
	private RecipeDao recipeDao;
	@Autowired
	private PrescriptionDao prescriptionDao;
	
	public Object search(String name){
		return recipeDao.search(name);
	}

	public List<DBObject> searchBeginWith(String name){
		return recipeDao.searchBeginWith(name);
	}
	
	public List abbrBeginWith(String abbr){
		return recipeDao.abbrBeginWith(abbr);
	}
	
	public List pinciSearch(int freq){
		return recipeDao.pinciSearch(freq);
	}
	
	public TempNode[] symptomSearchRecipe(String symptomName){
		return recipeDao.symptomSearchRecipe(symptomName);
	}
	
	public TempNode[] drugSearchRecipe(String drugName){
		return recipeDao.drugSearchRecipe(drugName);
	}
	
	public List<DBObject> recipePrescription(String name){
		return prescriptionDao.recipePrescription(name);
	}
	
}
