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
	
	public List<TerminalInfo> getTerminalList() {
		String sql = "select * from t_bus_terminal where bt_type != 'c'";
		List<TerminalInfo> terminalList = jdbc.query(sql, 
				(ResultSet rs, int rowNum) -> {
					TerminalInfo ti = new TerminalInfo();
					ti.setBt_idx(rs.getInt("bt_idx"));
					ti.setBt_name(rs.getString("bt_name"));
					ti.setBt_area(rs.getString("bt_area"));
					ti.setBt_type(rs.getString("bt_type"));
					ti.setBt_status(rs.getString("bt_status"));
					return ti;
				});
		return terminalList;
	}

	public int chkTerminal(String name) {
		String sql = "select count(*) from t_bus_terminal where bt_name = '" + name + "' and (bt_type = 'a' or bt_type = 'b')";
		int result = jdbc.queryForObject(sql, Integer.class);
		return result;
	}
	
	public int terminalInsert(String name, String area) {
		String sql = "select count(*) from t_bus_terminal where bt_name = '" + name + "'";
		int result = jdbc.queryForObject(sql, Integer.class);
		if (result == 1) {
			sql = "update t_bus_terminal set bt_type = 'a' where bt_name= '" + name + "'";
			result = jdbc.update(sql);
		} else {
			sql = "insert into t_bus_terminal(bt_name, bt_area, bt_type) values('" + name + "', '" + area + "', 'b')";
			result = jdbc.update(sql);
		}
		return result;
	}

	public List<TerminalLineInfo> getTerminalLine(String bt_name) {
		String sql = "select * from t_bus_schedule where bt_name = '" + bt_name + "'";
		List<TerminalLineInfo> terminalLine = jdbc.query(sql, 
				(ResultSet rs, int rowNum) -> {
					TerminalLineInfo tli = new TerminalLineInfo();
					tli.setBs_idx(rs.getInt("bs_idx"));
					tli.setBs_stime(rs.getString("bs_stime"));
					tli.setBs_etime(rs.getString("bs_etime"));
					tli.setBs_date(rs.getString("bs_date"));
					
					tli.setBusInfo(getBusInfoList(bt_name));
					tli.setBusLineInfo(getBusLineInfoList(bt_name));
					return tli;
				});
		return terminalLine;
	}

	private List<BusLineInfo> getBusLineInfoList(String bt_name) {
		// TODO Auto-generated method stub
		return null;
	}

	private List<BusInfo> getBusInfoList(String bt_name) {
		// TODO Auto-generated method stub
		return null;
	}
}
