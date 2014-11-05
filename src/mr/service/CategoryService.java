package mr.service;

import java.util.List;

import mr.dao.CategoryDao;
import mr.domain.Category;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CategoryService {
	@Autowired
	private CategoryDao cgDao;
	
	public List getFirCategoryList(){
		return cgDao.getFirCategoryList();
	}
	
	public Category getFirCategory(String firCateName){
		return cgDao.getFirCategory(firCateName);
	}
	
	public List getSecCategoryList(String FirCateId){
		return cgDao.getSecCategoryList(FirCateId);
	}
	
	public Category getSecCategory(String secCateName){
		return cgDao.getSecCategory(secCateName);
	}
	
}
