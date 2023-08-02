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
	
	public List<TerminalInfo> getTerminalList(String kind) {
		String where = "";
		if (kind.equals("h"))
			where = " where bt_type != 'c'";
		else
			where = " where bt_type != 'b'";
		String sql = "select * from t_bus_terminal " + where;
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

	public int chkTerminal(String name, String kind) {
		String where = "";
		if (kind.equals("h"))			where = " where (bt_type = 'a' or bt_type = 'b')";
		else 							where = " where (bt_type = 'a' or bt_type = 'c')";
		String sql = "select count(*) from t_bus_terminal " + where + " and bt_name = '" + name + "' " ;
		int result = jdbc.queryForObject(sql, Integer.class);
		return result;
	}
	
	public int terminalInsert(String name, String area, String kind) {
		String where = "";
		if (kind.equals("h"))			where = "b";
		else							where = "c";
		String sql = "select count(*) from t_bus_terminal where bt_name = '" + name + "'";
		int result = jdbc.queryForObject(sql, Integer.class);
		if (result == 1) {
			sql = "update t_bus_terminal set bt_type = 'a' where bt_name= '" + name + "'";
			result = jdbc.update(sql);
		} else {
			sql = "insert into t_bus_terminal(bt_name, bt_area, bt_type) values('" + name + "', '" + area + "', '" + where + "')";
			result = jdbc.update(sql);
		}
		return result;
	}

	public List<BusLineInfo> getBusLine(int bt_idx, String kind) {
		String where = "";
		if (kind.equals("h"))			where = " and bl_type = '고속'";
		else							where = " and bl_type = '시외'";
		String sql = "select a.*, b.bt_name from t_bus_line a, t_bus_terminal b where a.bt_eidx = b.bt_idx and bt_sidx = " + bt_idx  
			 + where + " and bl_status = 'y'";
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
		String sql = "select a.bs_idx, c.bc_idx, bs_stime, bs_etime, a.bs_date, bi_level, bc_name, b.bi_idx, b.bi_num "
				+ " from t_bus_schedule a, t_bus_info b, t_bus_company c "
				+ " where a.bi_idx = b.bi_idx and b.bc_idx = c.bc_idx and a.bs_isuse = 'y' and a.bl_idx = " + bl_idx 
				+ " order by bs_stime asc";
		List<BusScheduleInfo> busScheduleInfo = jdbc.query(sql, (ResultSet rs, int rowNum) -> {
			BusScheduleInfo bs = new BusScheduleInfo(rs.getInt("bs_idx"), rs.getInt("bc_idx"), rs.getInt("bi_idx"), rs.getString("bi_num"),
			rs.getString("bs_stime"), rs.getString("bs_etime"), rs.getString("bs_date"), rs.getString("bi_level"), rs.getString("bc_name"));
			return bs;
		});
		return busScheduleInfo;
	}

	public int LineDel(int bl_idx) {
		String sql = "update t_bus_line set bl_status = 'n' where bl_idx = " + bl_idx;
		int result = jdbc.update(sql);
		return result;
	}

	public List<TerminalInfo> getTerminalListPop(int bt_idx, String kind) {
		String where = "";
		String where2 = "";
		if (kind.equals("h")) {
			where = " where bt_type != 'c'";
			where2 = " and bl_type='고속'";
		}
		else {
			where = " where bt_type != 'b'";
			where2 = " and bl_type='시외'";
		}
		String sql = "SELECT DISTINCT t1.* FROM t_bus_terminal t1 " + where + " and t1.bt_idx NOT IN "
				+ "(SELECT bt_eidx FROM t_bus_line WHERE bt_sidx = " + bt_idx + " and bl_status = 'y' " + where2 + ") and bt_idx != " + 
				bt_idx;
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

	public int AddLineIn(String kind, int bt_sidx, int bt_eidx, int adult) {
		String where = "";
		if (kind.equals("h"))			where = "고속";
		else 							where = "시외";
		String sql = "INSERT INTO t_bus_line (bt_sidx, bt_eidx, bl_type, bl_adult) VALUES (" + bt_sidx + ", " + bt_eidx + ", '" + 
				where + "', " + adult + ")";
		int result = jdbc.update(sql);
		return result;
	}

	public List<BusInfo> getBusInfo(String kind) {
		String where = "";
		if (kind.equals("h"))
			where = " and bi_level != '일반'";
		else 
			where = " and bi_level != '프리미엄'";
		String sql = "select * from t_bus_info a, t_bus_company b where a.bc_idx = b.bc_idx and bi_status = 'y'" + where;
		List<BusInfo> busInfo = jdbc.query(sql, 
				(ResultSet rs, int rowNum) -> {
					BusInfo bi = new BusInfo();
					bi.setBc_idx(rs.getInt("bc_idx"));
					bi.setBi_idx(rs.getInt("bi_idx"));
					bi.setBi_level(rs.getString("bi_level"));
					bi.setBi_num(rs.getString("bi_num"));
					bi.setBc_name(rs.getString("bc_name"));
					return bi;
				});
		return busInfo;
	}

	public int scheduleAdd(BusScheduleInfo busScheduleInfo, int adult, int bl_idx) {
		String sql = "select bi_idx from t_bus_info where bi_num = '" + busScheduleInfo.getBi_num() + "'";
		int bi_idx = jdbc.queryForObject(sql, Integer.class);
		
		sql = "insert into t_bus_schedule (bl_idx, bi_idx, bs_stime, bs_etime) values (" + bl_idx + ", " + bi_idx + ", '" + 
				busScheduleInfo.getBs_stime() + "', '" + busScheduleInfo.getBs_etime() + "')";
		int result = jdbc.update(sql);
		return result;
	}

	public int changeLevel(String number, String kind) {
		String where = "";
		if (kind.equals("h"))
			where = " and bi_level != '일반'";
		else
			where = " and bi_level != '프리미엄'";
		String sql = "select bi_level from t_bus_info where bi_num = '" + number + "'" + where;
		String tmp = jdbc.queryForObject(sql, String.class);
		int result = 0;
		if (!tmp.equals("우등"))		result++;
		return result;
	}

	public int delShcedule(int bsidx) {
		String sql = "update t_bus_schedule set bs_isuse = 'n' where bs_idx = " + bsidx;
		int result = jdbc.update(sql);
		return result;
	}
}
