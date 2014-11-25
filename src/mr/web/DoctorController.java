package mr.web;

import mr.domain.Doctor;
import mr.service.DoctorService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/doctor")
public class DoctorController {
	@Autowired
	private DoctorService ds;
	
	
	@RequestMapping("")
	public String doctorPage(){
		return "doctor";
	}
	
	@RequestMapping("/data")
	@ResponseBody
	public Doctor getDoctor(@RequestParam("id") Long id){
		return ds.doctorById(id);
	}
}
