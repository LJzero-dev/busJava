package dao;

import java.util.*;
import java.sql.*;
import javax.sql.*;
import org.springframework.jdbc.core.*;
import vo.*;

public class TerminalDao {
	private JdbcTemplate jdbc;

	public TerminalDao(DataSource dataSource) {
		 this.jdbc = new JdbcTemplate(dataSource);
	}
	
	public ArrayList<TerminalInfo> getTerminalList() {
		String sql = "select * from t_bus_terminal where bt_type != 'c'";
		ArrayList<TerminalInfo> terminalList = new ArrayList<TerminalInfo>();
		List<TerminalInfo> results = jdbc.query(sql, new RowMapper<TerminalInfo>() {
			public TerminalInfo mapRow(ResultSet rs, int rowNum) throws SQLException {
				do {
					TerminalInfo ti = new TerminalInfo();
					ti.setBt_idx(rs.getInt("bt_idx"));
					ti.setBt_name(rs.getString("bt_name"));
					ti.setBt_area(rs.getString("bt_area"));
					ti.setBt_status(rs.getString("bt_status"));
					ti.setBt_type(rs.getString("bt_type"));
					terminalList.add(ti);
				} while(rs.next());
				return null;
			}
		});
		return terminalList;
	}
}
