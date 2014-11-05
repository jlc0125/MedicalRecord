package mr.web;

import mr.domain.MedicalRecord;
import mr.service.MedicalRecordService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
@Controller
@RequestMapping("/case_detail")
public class CaseDetailController {
	@Autowired
	MedicalRecordService mrs;
	
	@RequestMapping(value="")
	public ModelAndView casePage(@RequestParam("caseid") int caseid){
		MedicalRecord record=mrs.getRecordById(caseid);
		ModelAndView mav=new ModelAndView("caseDetail");
		mav.addObject(record);
		return mav;
	}
}
