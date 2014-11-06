package mr.web;

import java.util.List;
import java.util.Map;

import mr.domain.Med;
import mr.domain.MedicalRecord;
import mr.service.BZNaiveBayesService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/Analysis")
public class AnalysisController {
	@Autowired
	BZNaiveBayesService bzs;
	
	@RequestMapping(value="")
	public String anaPage(){
		return "analysis";
	}
	
	@RequestMapping(value="bz")
	public ModelAndView bz(@RequestParam("wd") String wd){
		ModelAndView mav=new ModelAndView("analysisResult");
		Map<String,Float> meds=bzs.freqUsedMeds(wd);
		mav.addObject(meds);
		List<MedicalRecord> records=bzs.containRecords(wd);
		mav.addObject(records);
		return mav;
	}
	
}
