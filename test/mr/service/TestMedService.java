package mr.service;

import static org.junit.Assert.*;
import java.util.List;
import mr.domain.Med;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"/applicationContext.xml"})
public class TestMedService {
	@Autowired
	MedService ms;
	
	@Test
	public void testGetMedVocab(){
		List<Med> medVocab=ms.getMedVocab();
		assertEquals(medVocab.get(0).getName(),1067);
	}
	
}
