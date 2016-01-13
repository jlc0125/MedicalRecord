package mr.web;


import java.util.Date;
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
	RevisionService revisionService;
	@RequestMapping("/revision/record_title")
	@ResponseBody
	public void recordTitle(@RequestParam("id") long id, @RequestParam("t") String title, @RequestParam("c") String comment){
		Revision revision = new Revision();
		revision.setAdvise("" + id + "#" + title);
		revision.setComment(comment);
		revision.setState(0);
		revision.setRevisionType(1);
		revision.setCreateDate(new Date());
		revisionService.addRevision(revision);
	}
	
	@RequestMapping("/revision/association_rule")
	@ResponseBody
	public void associationRule(@RequestParam("e1") String entity1, @RequestParam("e2") String entity2, @RequestParam("c") String comment){
		Revision revision = new Revision();
		revision.setAdvise("" + entity1 + "/" + entity2);
		revision.setComment(comment);
		revision.setState(0);
		revision.setRevisionType(2);
		revision.setCreateDate(new Date());
		revisionService.addRevision(revision);
	}
	
	@RequestMapping(value="/revision")
	public String browsePage(){
		return "revisionList";
	}
	
	@RequestMapping(value="/revision_professor")
	public String browseProfessorPage(){
		return "revisionProfessorList";
	}
	
	/**
	 * 查询修改意见表信息
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/revision/revisionlist")
	@ResponseBody
	public List<Revision> getRevision(){
		List<Revision> rvsList =new ArrayList<Revision>();
		rvsList = revisionService.getRevisionList();
				
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
	@RequestMapping(value="/revision/setagree")
	@ResponseBody
	public void setAgree(@RequestParam("agree") String agree,@RequestParam("id") String id){
	//	System.out.println("ok............................"+id);
		revisionService.setAgree(Integer.parseInt(agree), Integer.parseInt(id));		
	}
	
	/**
	 * 修改不同意值
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/revision/setdisagree")
	@ResponseBody
	public void setDisgree(@RequestParam("disagree") String disagree,@RequestParam("id") String id){
	//	System.out.println("ok............................"+id);
		revisionService.setDisagree(Integer.parseInt(disagree), Integer.parseInt(id));		
	}
	
}
