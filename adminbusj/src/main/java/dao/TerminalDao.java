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

	public List<BusLineInfo> getBusLine(int bt_idx) {
		String sql = "select a.*, b.bt_name from t_bus_line a, t_bus_terminal b where a.bt_eidx = b.bt_idx and bt_sidx = " + bt_idx + 
				" and bl_type = '°í¼Ó' and bl_status = 'y'";
		List<BusLineInfo> busLineList = jdbc.query(sql, 
				(ResultSet rs, int rowNum) -> {
					BusLineInfo bl = new BusLineInfo(rs.getInt("bl_idx"), rs.getInt("bt_sidx"), rs.getInt("bt_eidx"), 
							rs.getInt("bl_adult"), rs.getString("bl_type"), rs.getString("bl_status"), rs.getString("bt_name"), 
							getBusScheduleInfo(rs.getInt("bl_idx")));
					return bl;
				});
		return busLineList;
		
	}

	private List<BusScheduleInfo> getBusScheduleInfo(int bl_idx) {
		String sql = "select a.bs_idx, c.bc_idx, bs_stime, bs_etime, a.bs_date, bi_level, bc_name "
				+ "from t_bus_schedule a, t_bus_info b, t_bus_company c "
				+ "where a.bi_idx = b.bi_idx and b.bc_idx = c.bc_idx and a.bl_idx = " + bl_idx;
		List<BusScheduleInfo> busScheduleInfo = jdbc.query(sql, 
				(ResultSet rs, int rowNum) -> {
					BusScheduleInfo bs = new BusScheduleInfo(rs.getInt("bs_idx"), rs.getInt("bc_idx"), rs.getString("bs_stime"), 
							rs.getString("bs_etime"), rs.getString("bs_date"), rs.getString("bi_level"), rs.getString("bc_name"));
					return bs;
				});
		return busScheduleInfo;
	}

	public int LineDel(int bl_idx) {
		String sql = "update t_bus_line set bl_status = 'n' where bl_idx = " + bl_idx;
		int result = jdbc.update(sql);
		return result;
	}
}
