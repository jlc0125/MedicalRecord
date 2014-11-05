package mr.service;

import static org.junit.Assert.*;
import mr.domain.Med;
import mr.domain.MedicalRecord;

import org.junit.Test;




import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"/applicationContext.xml"})
public class TestBZNaiveBayesService {
	@Autowired
	private BZNaiveBayesService bs;
	
	@Test
	public void freqUsedMedsTest(){
		List<Med> meds=bs.freqUsedMeds("血虚");
		assertEquals(10, meds.size());
	}
}
