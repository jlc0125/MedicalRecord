package mr.service;

import java.util.List;

import mr.dao.DrugDao;

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
}
