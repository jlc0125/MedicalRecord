package mr.service;

import static org.junit.Assert.*;
import mr.domain.Doctor;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"/applicationContext.xml"})
public class TestDoctorService {
	@Autowired
	private DoctorService ds;
	
	@Test
	public void testDoctorById(){
		Doctor d=ds.doctorById(100L);
		assertEquals(d.getName(),"a");
	}

}
