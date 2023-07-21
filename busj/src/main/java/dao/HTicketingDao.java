package dao;

import java.util.*;
import java.sql.*;
import javax.sql.*;
import config.*;
import org.apache.tomcat.jdbc.pool.DataSource.*;
import org.springframework.jdbc.core.*;
import org.springframework.jdbc.support.*;
import vo.*;

public class HTicketingDao {
	private JdbcTemplate jdbc;

	public HTicketingDao(DataSource dataSource) {
		 this.jdbc = new JdbcTemplate(dataSource);
	}

}

