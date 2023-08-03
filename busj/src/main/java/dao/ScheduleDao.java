package dao;

import java.util.*;
import java.sql.*;
import javax.sql.*;
import config.*;
import org.apache.tomcat.jdbc.pool.DataSource.*;
import org.springframework.jdbc.core.*;
import org.springframework.jdbc.support.*;
import vo.*;

public class ScheduleDao {
	private JdbcTemplate jdbc;

	public ScheduleDao(DataSource dataSource) {
		this.jdbc = new JdbcTemplate(dataSource);
	}
}
