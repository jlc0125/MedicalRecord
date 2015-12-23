package mr.web;

import java.util.Date;

import mr.domain.Revision;
import mr.service.RevisionService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/revision")
public class RevisionController {
	
	@Autowired
	RevisionService revisionService;
	
	@RequestMapping("/record_title")
	@ResponseBody
	public void recordTitle(@RequestParam("id") long id, @RequestParam("t") String title, @RequestParam("c") String comment){
		Revision revision = new Revision();
		revision.setAdvise("" + id + "#" + title);
		revision.setComment(comment);
		revision.setState(0);
		revision.setType(1);
		revision.setCreateDate(new Date());
		revisionService.addRevision(revision);
	}
	
	@RequestMapping("/association_rule")
	@ResponseBody
	public void associationRule(@RequestParam("e1") String entity1, @RequestParam("e2") String entity2, @RequestParam("c") String comment){
		Revision revision = new Revision();
		revision.setAdvise("" + entity1 + "/" + entity2);
		revision.setComment(comment);
		revision.setState(0);
		revision.setType(2);
		revision.setCreateDate(new Date());
		revisionService.addRevision(revision);
	}
}
