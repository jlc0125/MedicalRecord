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
public class SearchController {
	@Autowired
	MedicalRecordService mrs;
	
	@RequestMapping(value="/records")
	@ResponseBody
	public List<MedicalRecord> getRecords(@RequestParam("wd") String wd,@RequestParam("pageNo") int pageNo,@RequestParam("pageSize") int pageSize){
		String[] words={"咳嗽","失眠"};
		//分词wd到words,待完成
		List<MedicalRecord> top100Records=mrs.relRecords(words);
		List<MedicalRecord> result=new ArrayList<MedicalRecord>();
		for(int i=(pageNo-1)*pageSize;i<pageNo*pageSize;i++){
			result.add(top100Records.get(i));
		}
		
		return result;
		
	}
	
	@RequestMapping(value="")
	public String searchPage(){
		return "searchResult";
	}
	
	
}
