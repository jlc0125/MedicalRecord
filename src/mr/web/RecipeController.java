package mr.web;

import java.util.List;

import mr.domain.TempNode;
import mr.service.DrugService;
import mr.service.RecipeService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mongodb.DBObject;

@Controller
public class RecipeController{
	@Autowired
	private RecipeService recipeService;
	private DrugService drugService;
	
	@RequestMapping("/analysishome")
	public String index(){
		return "analysishome";
	}
	
	@RequestMapping("/recipehome")
	public String recipehome(Model model){
		return "recipehome";
	}

	@RequestMapping("/recipe")
	public String recipePage(){
		return "recipe";
	}

	//通过疾病和中药来搜索相关方剂
	@ResponseBody
	@RequestMapping("/recipe/data")
	public TempNode[] recipeData(@RequestParam(value="q", required=false)String name, int option){
		System.out.println(option);
		try {
			if(option == 1){
				System.out.println(name);
				TempNode[] nodes = recipeService.symptomSearchRecipe(name);
				return nodes;
			}
			else if(option == 2){
				System.out.println(name);
				TempNode[] nodes = recipeService.drugSearchRecipe(name);
				return nodes;
			}
		} catch (Exception e) {
			return null;
		}
		return null;
		
		
	}
	
	//通过方剂名相关方剂
	@ResponseBody
	@RequestMapping("/recipe/search")
	public Object search(@RequestParam(value="q", required=false)String recipeName){
		if(recipeName==null || recipeName=="")
			return null;
		return recipeService.search(recipeName);
	}
	
	@ResponseBody
	@RequestMapping("/recipe/prescription")
	public List<DBObject> prescription(@RequestParam(value="q", required=false)String recipeName){
		if(recipeName==null || recipeName=="")
			return null;
		return recipeService.recipePrescription(recipeName);
	}
	
	@ResponseBody
	@RequestMapping("/recipe/hint")
	public List<DBObject> hint(@RequestParam(value="q", required=false)String recipeName){
		return recipeService.searchBeginWith(recipeName);
	}
	
	@ResponseBody
	@RequestMapping("/recipe/pinyin")
	public List pinyin(@RequestParam(value="q", required=false)String abbr){
		return recipeService.abbrBeginWith(abbr);
	}
	
	@ResponseBody
	@RequestMapping("/recipe/pinci")
	public List pinci(@RequestParam(value="q", required=false)int freq){
		return recipeService.pinciSearch(freq);
	}
	
}
