package mr.dao;

import static org.junit.Assert.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import mr.domain.TempNode;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.beans.factory.annotation.Autowired;




@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"/applicationContext.xml"})
public class TestDrugDao {
	@Autowired
	private DrugDao drugDao;
//	@Test
	public void recipeSearchDrugTest(){
		TempNode[] result = drugDao.recipeSearchDrug("益元散");
		assertNotNull(result);
	}
	
	@Test
	public void abbrBeginWithTest(){
		List result = drugDao.abbrBeginWith("a");
		assertEquals(5, result.size());
	}
}
