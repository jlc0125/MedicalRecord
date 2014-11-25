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
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/search")
public class MainSearchController {
	@Autowired
	MedicalRecordService mrs;
	
	@RequestMapping(value="/retval")
	@ResponseBody
	public List<MedicalRecord> getRecords(@RequestParam("wd") String wd,@RequestParam("pageNo") int pageNo,
			@RequestParam("pageSize") int pageSize,@RequestParam("type") String type){
		
		if (type.equals("content")){
			System.out.println("keyword="+wd);
			String[] words=IKAnalizer.IKAnalysis(wd).trim().split(" ");
			for(String word : words){
				System.out.println(word);
			}
			
			List<MedicalRecord> top100Records=mrs.relRecords(words);
			List<MedicalRecord> result=new ArrayList<MedicalRecord>();
			for(int i=(pageNo-1)*pageSize;i<pageNo*pageSize;i++){
				result.add(top100Records.get(i));
			}
			
			return top100Records;
		}
		else if(type.equals("doctor")){
			return mrs.recordByDoctor(wd);
		} 
		else if(type.equals("reference")){
			return mrs.recordByReference(wd);
		}
		else{
			//未勾选，错误页面
			return null;
		}
				
		
	}
	
	@RequestMapping(value="result")
	public String searchPage(){
		return "searchResult";
	}
	
	
}
