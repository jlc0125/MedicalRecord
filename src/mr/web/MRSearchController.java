package mr.web;

import java.util.List;

import mr.domain.MedicalRecord;
import mr.service.MedicalRecordService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/search")
public class MRSearchController {
	@Autowired
	MedicalRecordService mrs;
	
	@RequestMapping("")
	public String searchPage(){
		return "record_search";
	}
	
	@RequestMapping(value="/retval")
	@ResponseBody
	public List<MedicalRecord> getRecords(@RequestParam("wd") String wd,@RequestParam("type") String type){
		
		if (type.equals("content")){
			System.out.println("keyword="+wd);
			String[] words=IKAnalizer.IKAnalysis(wd).trim().split(" ");
			for(String word : words){
				System.out.println(word);
			}
			
			List<MedicalRecord> top100Records=mrs.relRecords(words);
			
			return top100Records;
		}
		else if(type.equals("doctor")){
			return mrs.recordByDoctor(wd);
		} 
		else if(type.equals("reference")){
			return mrs.recordByReference(wd);
		}
		else if(type.equals("doctor_id")){
			return mrs.recordByDoctorId(Long.valueOf(wd));
		}
		else if(type.equals("content_contain")){
			return mrs.recordByContentContain(wd.split(" "));
		}
		else{
			//未勾选，错误页面
			return null;
		}
				
	}
	
	@RequestMapping(value="result")
	public String resultPage(){
		return "record_search_result";
	}
	
	
}
