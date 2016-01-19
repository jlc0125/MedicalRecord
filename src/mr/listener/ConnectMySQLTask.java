package mr.listener;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.TimerTask;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowCallbackHandler;
import org.springframework.stereotype.Component;

//隔一段时间用jdbctemplate访问数据库，防止mysql 8小时问题
@Component
public class ConnectMySQLTask extends TimerTask{
	@Autowired
	JdbcTemplate jdbcTemplate;
	
	private  static boolean  isRunning  =  false;  

	@Override
	public void run() {
		// TODO Auto-generated method stub
		String sqlStr = "SELECT 1";
		System.out.println(jdbcTemplate);
		jdbcTemplate.query(sqlStr,new RowCallbackHandler(){
			@Override
			public void processRow(ResultSet rs) throws SQLException {
				System.out.println(rs);						
			}
		});
	}

}
