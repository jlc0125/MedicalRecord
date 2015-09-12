package mr.web;

import java.util.ArrayList;
import java.util.List;

import mr.dao.MedDao;
import mr.domain.MedicalRecord;
import mr.service.MedicalRecordService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
@Controller
@RequestMapping("/record_detail")
public class RecordDetailController {
	@Autowired
	MedicalRecordService mrs;
	@Autowired
	MedDao medDao;
	
	@RequestMapping(value="")
	public String casePage(){
		return "record_detail";
	}
	
	@RequestMapping(value="record")
	@ResponseBody
	public MedicalRecord getRecord(@RequestParam("recordId") int recordId){
		MedicalRecord result=new MedicalRecord();
		result=mrs.getRecordById(recordId);
		return result;
	}
	
	@RequestMapping(value="med")
	@ResponseBody
	public List<String> getMed(@RequestParam("recordId") int recordId){
		List<String> result=new ArrayList<String>();
		MedicalRecord record=new MedicalRecord();
		record=mrs.getRecordById(recordId);
		String content=record.getContent();
		String[] words=IKAnalizer.IKAnalysis(content).trim().split(" ");
		for(String word:words){
			if(medDao.isMed(word)&& !result.contains(word)) result.add(word);
		}
		return result;
	}
}
