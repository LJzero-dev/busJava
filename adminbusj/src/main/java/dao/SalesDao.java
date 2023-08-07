package dao;

import java.sql.*;
import java.util.*;
import javax.sql.*;
import org.springframework.jdbc.core.*;
import vo.*;

public class SalesDao {
	private JdbcTemplate jdbc;
	
	public SalesDao(DataSource dataSource) {
		this.jdbc = new JdbcTemplate(dataSource);
	}

	
}
