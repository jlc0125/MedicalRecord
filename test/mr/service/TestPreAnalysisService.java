package mr.service;

import static org.junit.Assert.*;

import java.util.Map;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"/applicationContext.xml"})
public class TestPreAnalysisService {
	@Autowired
	private PreAnalysisService ps;
	
	@Test
	public void getPreMapTest(){
		String[] preSeg={"甘草"};
		Map<String,Object> result=ps.getPreMap(preSeg);
		assertEquals(5, result.size());
	}
	
	
}
