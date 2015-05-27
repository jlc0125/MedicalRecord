package mr.service;

import static org.junit.Assert.*;
import mr.service.RecommendService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"/applicationContext.xml"})
public class TestRecommendService {
	@Autowired
	RecommendService recService;
	
	@Test
	public void testCalSim(){
		recService.calSim();
	}
	
	@Test
	public void testSimRecords(){
		recService.simRecords(1, 10);
	}
}
