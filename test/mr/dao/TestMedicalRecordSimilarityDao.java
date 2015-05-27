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


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"/applicationContext.xml"})
public class TestMedicalRecordSimilarityDao {
	@Autowired
	private MedicalRecordSimilarityDao mrsDao;
	
	@Test
	public void testRecordWord(){
		//RecordWord rw=mrsDao.new RecordWord(1,new String[]{"1","1","1","1","1","1","1","1"});
		//assertEquals(8, (int)rw.counts.get(0));
	}
	
	@Test
	public void testCreateTable(){
		mrsDao.createTable();
	}
}
