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
	public String symptom(@RequestParam(value="q", required=false)String name, int option, Model model){
//		if(symptomName!=null && symptomName!=""){
//			try {
//				symptomName = new String(symptomName.getBytes("iso-8859-1"), "UTF-8");
//				model.addAttribute("symptomName", symptomName);
//			} catch (Exception e) {
//				model.addAttribute("error", 1);
//			}
//		}
//		return "symptom";
		
		if(name!=null && name!=""){
			try {
				name = new String(name.getBytes("iso-8859-1"), "UTF-8");
				model.addAttribute("option", option);
				if(option == 1){
					TempNode[] nodes = symptomService.drugSearchSymptom(name);
					if(nodes == null){
						model.addAttribute("noResult", 1);
					}
					else{
						model.addAttribute("searchName", name);
						model.addAttribute("nodes", nodes);
					}
					return "symptomhome";
				}
				else if(option == 2){
					TempNode[] nodes = symptomService.recipeSearchSymptom(name);
					if(nodes == null){
						model.addAttribute("noResult", 1);
					}
					else{
						model.addAttribute("searchName", name);
						model.addAttribute("nodes", nodes);
					}
					return "symptomhome";
				}
				else{
					model.addAttribute("symptomName", name);
					return "symptom";
				}
			} catch (Exception e) {
				model.addAttribute("error", 1);
				return "symptomhome";
			}
		}
		else{
			return "symptomhome";
		}
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
