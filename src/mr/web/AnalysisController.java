package mr.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import mr.domain.Med;
import mr.domain.MedicalRecord;
import mr.service.BZNaiveBayesService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
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
	@ResponseBody
	public Map<String,Object> bz(@RequestParam("wd") String wd){
		
		Map<String,Object> result=new HashMap<String,Object>();
		Map<String,Float> meds=bzs.freqUsedMeds(wd);
		List<MedicalRecord> records=bzs.containRecords(wd);
		result.put("meds",meds.keySet());
		result.put("likelihood", meds.values());
		result.put("records",records);
		return result;
	}
	
	
	
	@RequestMapping(value="Result")
	public String resultPage(){
		return "analysisResult";
	}
	
}
