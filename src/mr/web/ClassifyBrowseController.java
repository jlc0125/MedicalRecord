package mr.web;

import java.util.ArrayList;
import java.util.List;

import mr.domain.MedicalRecord;
import mr.service.MedicalRecordService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/browse")
public class ClassifyBrowseController {
	
	@Autowired
	private MedicalRecordService mrs;
	
	@RequestMapping(value="")
	public String browsePage(){
		return "browse";
	}
	
	@RequestMapping(value="/retval")
	@ResponseBody
	public List<MedicalRecord> getRecord(@RequestParam("wd") String wd,@RequestParam("type") String type){
		List<MedicalRecord> recList =new ArrayList<MedicalRecord>();
		if(type.equals("medicalclassify")){
			recList = mrs.recordByCategory(wd);
		}
		else if(type.equals("discriminate")){
			recList = mrs.recordByDisc(wd.replaceAll("辨证", ""));
		}
		else if(type.equals("therapy")){
			recList = mrs.recordByTher(wd);
		}
		else if(type.equals("wordfrequency")){
			recList = mrs.recordByWF(wd);
		}
		else if(type.equals("therapylabel")){
			recList = mrs.recordByZhifa(wd);
		}
		else if(type.equals("medicalclassify_first")){
			recList = mrs.recordByFirstCategory(wd);
		}
		System.out.println(wd);		
		return recList;
	}
	
	
	
	@RequestMapping(value="result")
	public String searchPage(){
		return "record_search_result";
	}

}