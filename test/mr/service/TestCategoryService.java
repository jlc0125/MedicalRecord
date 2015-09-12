package mr.service;

import static org.junit.Assert.assertEquals;

import java.util.List;
import java.util.Map;

import mr.dao.ClassifyBrowseDao;
import mr.domain.Category;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"/applicationContext.xml"})
public class TestCategoryService {
	@Autowired
	private ClassifyBrowseDao cgDao;
	
	@Test
	public void testgetFirCategoryList(){
		List cateList = cgDao.getFirCategoryList();
		for(int i=0;i<cateList.size();i++){
			Map userMap=(Map) cateList.get(i);
			System.out.println(userMap.get("cate_id")+" "+userMap.get("cate_name")+" "+
					userMap.get("startRecId")+" "+userMap.get("recNum"));
		}
	}
	
	@Test
	public void testgetFirCategory(){
		Category cate = cgDao.getFirCategory("外科");
		assertEquals(cate.getCateId(), "01");
	}
	@Test
	public void testgetSecCategoryList(){
		List cateList = cgDao.getSecCategoryList("00");
		for(int i=0;i<cateList.size();i++){
			Map userMap=(Map) cateList.get(i);
			System.out.println(userMap.get("cate_id")+" "+userMap.get("cate_name")+" "+
					userMap.get("startRecId")+" "+userMap.get("recNum"));
		}
	}
	
	@Test
	public void testgetSecCategory(){
		Category cate = cgDao.getSecCategory("外感病");
		assertEquals(cate.getCateId(), "0000");
	}
	@Test
	public void testgetMatchCount(){
		System.out.println(cgDao.getMatchCount("20"));
	}
}
