package mr.service;

import mr.dao.DoctorDao;
import mr.domain.Doctor;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class DoctorService {
	@Autowired
	private DoctorDao dDao;
	
	public Doctor doctorById(Long id){
		return dDao.doctorById(id);
	}
}
