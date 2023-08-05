package dao;

import java.util.*;
import java.sql.*;
import javax.sql.*;
import org.springframework.jdbc.core.*;
import org.springframework.jdbc.support.*;
import vo.*;

public class IndexDao {
	private JdbcTemplate jdbc;
	public IndexDao(DataSource dataSource) {
		this.jdbc = new JdbcTemplate(dataSource);
	}
	public List<String> getSales() {
		String sql = "SELECT 1, concat(count(ri_idx), \":\",  IFNULL(SUM(cr_pmoney + cr_pay), 0)) sales FROM t_count_rinfo WHERE LEFT(cr_date, 10) = adddate(curdate(), -1) " + 
				"UNION " + 
				"SELECT 2, concat(count(ri_idx), \":\",  sum(cr_pmoney + cr_pay)) sales FROM t_count_rinfo WHERE LEFT(cr_date, 10) >= adddate(curdate(), -7) " + 
				"UNION " + 
				"SELECT 3, concat(count(ri_idx), \":\",  sum(cr_pmoney + cr_pay)) sales FROM t_count_rinfo WHERE MID(cr_date, 6, 2) = MID(curdate(), 6, 2) " + 
				"UNION " + 
				"SELECT 4, concat(count(ri_idx), \":\",  sum(cr_pmoney + cr_pay)) sales FROM t_count_rinfo WHERE LEFT(cr_date, 4) = LEFT(curdate(), 4)";
		List<String> salesList = jdbc.query(sql, (ResultSet rs, int rowNum) -> {
			return rs.getString("sales");
		});
		
		return salesList;
	}
}
