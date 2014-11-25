package mr.service;

import mr.dao.RecipeDao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


@Service
public class RecipeService {
	@Autowired
	private RecipeDao recipeDao;
	
	public Object search(String name){
		return recipeDao.search(name);
	}
}
