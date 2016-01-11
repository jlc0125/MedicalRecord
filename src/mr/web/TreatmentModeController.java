package mr.web;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class TreatmentModeController {
	
	@RequestMapping("/treatmentmode")
	public String home(Model model){
		return "treatment_mode";
	}

}
