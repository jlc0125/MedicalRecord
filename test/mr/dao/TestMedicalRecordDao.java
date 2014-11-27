package mr.dao;

import static org.junit.Assert.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
	
		MedicalRecord medicalRecord = mrDao.recordByIndex(1);
		
	}
	@Test
	public void testAllTfidf(){
		List<HashMap<Integer,Double>> allTfidf=mrDao.allTfidf();
		assertNotNull(allTfidf);
	}
	
	@Test
	public void testRecordByCategory(){
		List recordList = mrDao.recordByCategory("中毒");
		int i;
		for(i=0;i<recordList.size();i++){
		//	Map userMap=(Map) recordList.get(i);
		//	System.out.println(userMap.get("tfidf")+" ");
		}
		assertEquals(i,60);
	}
	
	@Test
	public void testRecordByDisc(){
		List<MedicalRecord> list = mrDao.recordyDisc("调津液");
		System.out.println(list.size());
	}
	
}
