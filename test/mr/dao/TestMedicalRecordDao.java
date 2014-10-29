package mr.dao;

import static org.junit.Assert.*;

import java.util.HashMap;
import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.beans.factory.annotation.Autowired;





import mr.domain.MedicalRecord;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"/applicationContext.xml"})
public class TestMedicalRecordDao {
	@Autowired
	private MedicalRecordDao mrDao;
	@Test
	public void testRecordByIndex() {
		MedicalRecord medicalRecord=new MedicalRecord();
		medicalRecord=mrDao.recordByIndex(1);
		assertEquals(medicalRecord.getRecordTitle(), "犯二");
	}
	@Test
	public void testAllTfidf(){
		List<HashMap<Integer,Double>> allTfidf=mrDao.allTfidf();
		assertNotNull(allTfidf);
	}

}
