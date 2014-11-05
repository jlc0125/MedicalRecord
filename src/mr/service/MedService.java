package mr.service;

import java.util.List;

import mr.dao.MedDao;
import mr.domain.Med;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MedService {
	@Autowired
	private MedDao medDao;
	
	public List<Med> getMedVocab(){
		return medDao.allMeds();
	}
}
