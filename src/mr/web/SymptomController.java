package mr.web;

import java.util.List;

import mr.domain.TempNode;
import mr.service.SymptomService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mongodb.DBObject;

@Controller
public class SymptomController {
	@Autowired
	private SymptomService symptomService;
	
	@RequestMapping("/symptomhome")
	public String home(Model model){
		return "symptomhome";
	}

	@RequestMapping("/symptom")
	public String syptomPage(Model model){
		return "symptom";
	}
	
	@ResponseBody
	@RequestMapping("/symptom/data")
	public TempNode[] symptomData(@RequestParam(value="q", required=false)String name, int option, Model model){
		
		if(name!=null && name!=""){
			try {
				if(option == 1){
					TempNode[] nodes = symptomService.drugSearchSymptom(name);
					return nodes;
				}
				else if(option == 2){
					TempNode[] nodes = symptomService.recipeSearchSymptom(name);
					return nodes;
				}
				
			} catch (Exception e) {
				return null;
			}
		}
		return null;
	}
	
	@ResponseBody
	@RequestMapping("/symptom/search")
	public Object search(@RequestParam(value="q", required=false)String symptomName){
		if(symptomName==null || symptomName=="")
			return null;
		return symptomService.search(symptomName);
	}
	
	@ResponseBody
	@RequestMapping("/symptom/hint")
	public List<DBObject> hint(@RequestParam(value="q", required=false)String symptomName){
		return symptomService.searchBeginWith(symptomName);
	}
	
	@ResponseBody
	@RequestMapping("/symptom/pinyin")
	public List pinyin(@RequestParam(value="q", required=false)String abbr){
		return symptomService.abbrBeginWith(abbr);
	}
	
	@ResponseBody
	@RequestMapping("/symptom/pinci")
	public List pinci(@RequestParam(value="q", required=false)int freq){
		return symptomService.pinciSearch(freq);
	}
}
