package mr.service;

import static org.junit.Assert.*;

import org.junit.Test;






import java.util.Map;
import java.util.Set;

import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"/applicationContext.xml"})
public class BZNaiveBayesServiceTest {
	@Autowired
	private BZNaiveBayesService bs;
	
	@Test
	public void freqUsedMedsTest(){
		Map<String,Float> meds=bs.freqUsedMeds("血虚");
		assertTrue(meds.containsKey("当归"));
	}
}
