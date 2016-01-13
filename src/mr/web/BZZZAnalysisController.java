package mr.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import mr.domain.MedicalRecord;
import mr.service.BZNaiveBayesService;
import mr.service.ZZNaiveBayesService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/bzzz")
public class BZZZAnalysisController {
	@Autowired
	BZNaiveBayesService bzs;
	@Autowired
	ZZNaiveBayesService zzs;
	
	
	@RequestMapping(value="")
	public String anaPage(){
		return "analysis";
	}
	
	@RequestMapping(value="bz")
	@ResponseBody
	public List<Map<String,Object>> bz(@RequestParam("wd") String wd){
		List<Map<String,Object>> result=new ArrayList<Map<String,Object>>();
		
		String[] words=IKAnalizer.IKAnalysis(wd).trim().split(" ");
		for(String word:words){
			System.out.println("word="+word);
			Map<String,Object> map=new HashMap<String,Object>();
			Map<String,Float> meds=bzs.freqUsedMeds(word);
//			List<MedicalRecord> records=bzs.containRecords(word);
			map.put("meds",meds.keySet());
			map.put("likelihood", meds.values());
//			map.put("records",records);
			map.put("word", word);
			result.add(map);
		}
		return result;
	}
	
	@RequestMapping(value="zz")
	@ResponseBody
	public List<Map<String,Object>> zz(@RequestParam("wd") String wd){
		List<Map<String,Object>> result=new ArrayList<Map<String,Object>>();
		
		String[] words=IKAnalizer.IKAnalysis(wd).trim().split(" ");
		for(String word:words){
			System.out.println("word="+word);
			Map<String,Object> map=new HashMap<String,Object>();
			Map<String,Float> meds=zzs.freqUsedMeds(word);
			List<MedicalRecord> records=zzs.containRecords(word);
			map.put("meds",meds.keySet());
			map.put("likelihood", meds.values());
			map.put("records",records);
			map.put("word", word);
			result.add(map);
		}
		return result;
	}
	
	
	
	@RequestMapping(value="result")
	public String resultPage(){
		return "analysis_result";
	}
	
}
