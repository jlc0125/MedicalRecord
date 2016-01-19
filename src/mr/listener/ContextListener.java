package mr.listener;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import java.util.TimerTask;

//隔一段时间用jdbctemplate访问数据库，防止mysql 8小时问题
public class ContextListener implements ServletContextListener {
	
	private  java.util.Timer  timer  =  null; 
	@Override
	public void  contextInitialized(ServletContextEvent  event) {
		// TODO Auto-generated method stub
		  timer  =  new  java.util.Timer(true);    
		  event.getServletContext().log("定时器已启动");
		  ApplicationContext ctx=new ClassPathXmlApplicationContext("applicationContext.xml");
		  TimerTask task = ctx.getBean(ConnectMySQLTask.class);
		  timer.schedule(task,  0,  60*60*1000);    
		  event.getServletContext().log("已经添加任务调度表");    
	}

	@Override
	public void contextDestroyed(ServletContextEvent event) {
		// TODO Auto-generated method stub
		 timer.cancel();    
		 event.getServletContext().log("定时器销毁");    
	}


}
