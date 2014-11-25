package mr.web;

import java.util.List;

import mr.service.RecipeService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mongodb.DBObject;

@Controller
public class RecipeController{
	@Autowired
	private RecipeService recipeService;
	
	@RequestMapping("/recipe")
	public String recipe(){
		return "recipe";
	}
	
	@ResponseBody
	@RequestMapping("/recipe/search")
	public Object search(@RequestParam(value="q", required=false)String recipeName){
		if(recipeName==null || recipeName=="")
			return null;
		return recipeService.search(recipeName);
	}
	
	@ResponseBody
	@RequestMapping("/recipe/hint")
	public List<DBObject> hint(@RequestParam(value="q", required=false)String recipeName){
		return recipeService.searchBeginWith(recipeName);
	}
}
