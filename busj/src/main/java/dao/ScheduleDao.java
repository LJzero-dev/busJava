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

	public int getLineidx(String sPoint, String ePoint, String busType) {
	// 출/도착지 터미널 이름과 구분값으로 노선번호 셀렉트
		String sql = "select bl_idx from t_bus_line " 
				 + "join t_bus_terminal start_terminal on t_bus_line.bt_sidx = start_terminal.bt_idx "
				 + "join t_bus_terminal end_terminal on t_bus_line.bt_eidx = end_terminal.bt_idx "
				 + " where start_terminal.bt_name = '" + sPoint + "' and end_terminal.bt_name = '" + ePoint + "' and t_bus_line.bl_type = '" + busType + "' ";
		int blidx = jdbc.queryForObject(sql, Integer.class);
		return blidx;
	}

	public List<ReservationStep2> getScheduleList(int blidx, String risday) {
	// 해당 노선의 시간표를 가져오는 메서드
		String sql = "select tt.*, "
				+ "total_seat - IFNULL((SELECT sum(ri_acnt + ri_scnt + ri_ccnt) FROM t_reservation_info ri WHERE ri.bs_idx = tt.bs_idx and ri.ri_sday = '" + risday.replace(".", "-") + "'), 0) "
				+ "as left_seat "
				+ "from ( "
				+ "SELECT a.bs_idx, a.bl_idx, a.bi_idx, d.bc_name, b.bl_adult, c.bi_level, a.bs_stime, a.bs_etime, "
				+ "CASE c.bi_level "
				+ "WHEN '일반' THEN 36 "
				+ "WHEN '우등' THEN 28 "
				+ "WHEN '프리미엄' THEN 18 "
				+ "END AS total_seat "
				+ "FROM t_bus_schedule a, t_bus_line b, t_bus_info c, t_bus_company d "
				+ "WHERE a.bl_idx = b.bl_idx and a.bi_idx = c.bi_idx and c.bc_idx = d.bc_idx and a.bl_idx = " + blidx + " ) tt " 
				+ "order by a.bs_stime";
		
		List<ReservationStep2> scheduleList = jdbc.query(sql, (ResultSet rs, int rowNum) -> {
			ReservationStep2 sl = new ReservationStep2();
			sl.setBs_idx(rs.getInt("bs_idx"));
			sl.setBi_idx(rs.getInt("bi_idx"));
			sl.setBl_idx(rs.getInt("bl_idx"));
			sl.setBs_stime(rs.getString("bs_stime"));
			sl.setBs_etime(rs.getString("bs_etime"));
			sl.setBc_name(rs.getString("bc_name"));
			sl.setBi_level(rs.getString("bi_level"));
			sl.setBl_adult(rs.getInt("bl_adult"));
			sl.setTotal_seat(rs.getInt("total_seat"));
			sl.setLeft_seat(rs.getInt("left_seat"));
			return sl;
		});
		return scheduleList;
	}

	public List<BusCompanyInfo> getBusCompany() {
	// 
		String sql = "select * from t_bus_company";
		List<BusCompanyInfo> busCompany = jdbc.query(sql, (ResultSet rs, int rowNum) -> {
			BusCompanyInfo bc = new BusCompanyInfo(rs.getInt("bc_idx"), rs.getString("bc_name"));
			return bc;
		});
		return busCompany;
	}

	public List<TerminalInfo> getDepartureTerminal(String selectedArea) {
	// 
		String sql = "select bt_name from t_bus_terminal where bt_area like '%" + selectedArea + "%'";
		System.out.println(sql);
		List<TerminalInfo> departureTerminal = jdbc.query(sql, (ResultSet rs, int rowNum) -> {
			TerminalInfo ti = new TerminalInfo();
			ti.setBt_name(rs.getString("bt_name"));
			return ti;
		});
		return null;
	}
}
