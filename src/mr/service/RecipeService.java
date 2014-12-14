package mr.service;

import java.util.List;

import mr.dao.RecipeDao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mongodb.DBObject;


@Service
public class RecipeService {
	@Autowired
	private RecipeDao recipeDao;
	
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
	
}
