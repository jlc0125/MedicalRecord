package mr.dao;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowCallbackHandler;
import org.springframework.stereotype.Repository;

import mr.domain.User;
@Repository

public class UserDao {
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
}
