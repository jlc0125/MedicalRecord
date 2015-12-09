package mr.web;


import java.util.ArrayList;
import java.util.List;

import mr.domain.Revision;
import mr.service.RevisionService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;


@Controller
public class RevisionController {
	
	@Autowired
	private RevisionService rvss;
	
	@RequestMapping(value="/revision")
	public String browsePage(){
		return "revisionList";
	}
	
	/**
	 * 查询修改意见表信息
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/revisionlist")
	@ResponseBody
	public List<Revision> getRevision(){
		List<Revision> rvsList =new ArrayList<Revision>();
		rvsList = rvss.getRevisionList();
				
		return rvsList;
	}
	/**
	 * 修改同意值
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/setagree")
	@ResponseBody
	public void setAgree(@RequestParam("agree") String agree,@RequestParam("id") String id){
	//	System.out.println("ok............................"+id);
		rvss.setAgree(Integer.parseInt(agree), Integer.parseInt(id));		
	}
	
	/**
	 * 修改不同意值
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/setdisagree")
	@ResponseBody
	public void setDisgree(@RequestParam("disagree") String disagree,@RequestParam("id") String id){
	//	System.out.println("ok............................"+id);
		rvss.setDisagree(Integer.parseInt(disagree), Integer.parseInt(id));		
	}
}
