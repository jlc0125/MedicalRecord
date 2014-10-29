package mr.service;

import static org.junit.Assert.*;
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
public class TestMedicalRecordService {
	@Autowired
	MedicalRecordService mrs;
	
	String[] words={"咳嗽","失眠"};
	@Test
	public void testSimilaritySort(){
		List<Integer> tmp=mrs.similaritySort(words);
		assertNotNull(tmp);
	}
	
	@Test
	public void testRelRecords(){
		List<MedicalRecord> tmp=mrs.relRecords(words);
		assertNotNull(tmp);
	}
}
