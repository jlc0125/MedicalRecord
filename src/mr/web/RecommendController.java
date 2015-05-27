package mr.web;

import java.util.List;

import mr.domain.MedicalRecord;
import mr.service.RecommendService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping(("/recommend"))
public class RecommendController {
	@Autowired
	private RecommendService recService;
	
	@RequestMapping("by_record_sim")
	@ResponseBody
	public List<MedicalRecord> getSimRecords(@RequestParam("recordId") int recordId,@RequestParam("size") int size){
		return recService.simRecords(recordId, size);
	}
}
