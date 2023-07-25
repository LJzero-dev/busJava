package dao;

import java.util.*;
import java.sql.*;
import javax.sql.*;

import org.apache.tomcat.jdbc.pool.DataSource.*;
import org.springframework.jdbc.core.*;
import org.springframework.jdbc.support.*;

import config.*;
import vo.*;

public class HTicketingDao {
	private JdbcTemplate jdbc;

	public HTicketingDao(DataSource dataSource) {
		 this.jdbc = new JdbcTemplate(dataSource);
	}

	public List<TerminalInfo> getTerminalList() {
		String sql = "select bt_idx, bt_name, bt_area, bt_type, bt_status from t_bus_terminal where bt_type <> 'c' and bt_status ='y' order by bt_name";
		List<TerminalInfo> terminalList = jdbc.query(sql, (ResultSet rs, int rowNum) -> {
			TerminalInfo ti = new TerminalInfo(rs.getInt("bt_idx"), rs.getString("bt_name"), rs.getString("bt_area"), rs.getString("bt_type"), rs.getString("bt_status"));
			return ti;
		});
		
		return terminalList;
	}

	public List<LineInfo> getAvailableLineList(int btsidx) {
		String sql = "SELECT bl.bt_sidx, bl.bt_eidx, bt.bt_name, bt.bt_area" + 
				" FROM t_bus_line bl" + 
				" JOIN t_bus_terminal bt ON bl.bt_eidx = bt.bt_idx WHERE bt_sidx = ? and bl_status = 'y'";
		List<LineInfo> lineList = jdbc.query(sql, (ResultSet rs, int rowNum) -> {
			LineInfo li = new LineInfo(rs.getInt("bl_idx"), rs.getInt("bt_sidx"), rs.getString("sname"), rs.getString("sarea"), rs.getInt("bt_eidx"),
					rs.getString("ename"), rs.getString("earea"), rs.getInt("bl_adult"), rs.getString("bl_type"), rs.getString("bl_status"));
			return li;
		}, btsidx);
		
		return lineList;
	}

}

