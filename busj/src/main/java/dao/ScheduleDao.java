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
				+ "SELECT a.bs_idx, a.bl_idx, a.bi_idx, d.bc_name, b.bl_adult, c.bi_level, a.bs_stime, a.bs_etime, b.bl_type, "
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
			
			int blAdult = rs.getInt("bl_adult");
			
			if (rs.getString("bl_type").equals("고속") && rs.getString("bi_level").equals("프리미엄"))	
				blAdult = (int) (rs.getInt("bl_adult") * 1.5);
			else if (rs.getString("bl_type").equals("시외") && rs.getString("bi_level").equals("우등")) 
				blAdult = (int) (rs.getInt("bl_adult") * 1.5);

			sl.setBs_idx(rs.getInt("bs_idx"));
			sl.setBi_idx(rs.getInt("bi_idx"));
			sl.setBl_idx(rs.getInt("bl_idx"));
			sl.setBs_stime(rs.getString("bs_stime"));
			sl.setBs_etime(rs.getString("bs_etime"));
			sl.setBc_name(rs.getString("bc_name"));
			sl.setBi_level(rs.getString("bi_level"));
			sl.setBl_adult(blAdult);
			sl.setTotal_seat(rs.getInt("total_seat"));
			sl.setLeft_seat(rs.getInt("left_seat"));
			return sl;
		});
		return scheduleList;
	}

	public List<BusCompanyInfo> getBusCompany() {
	// 버스 회사 이름을 select 하는 메서드
		String sql = "select * from t_bus_company";
		List<BusCompanyInfo> busCompany = jdbc.query(sql, (ResultSet rs, int rowNum) -> {
			BusCompanyInfo bc = new BusCompanyInfo(rs.getInt("bc_idx"), rs.getString("bc_name"));
			return bc;
		});
		return busCompany;
	}

	public List<TerminalInfo> getDepartureTerminal(String selectedArea) {
	// 선택한 출발 지역에 있는 터미널 이름을 구하는 메서드
		String sql = "select bt_name from t_bus_terminal where bt_area like '%" + selectedArea + "%'";
//		System.out.println(sql);
		List<TerminalInfo> departureTerminal = jdbc.query(sql, (ResultSet rs, int rowNum) -> {
			TerminalInfo ti = new TerminalInfo();
			ti.setBt_name(rs.getString("bt_name"));
			return ti;
		});
		return departureTerminal;
	}

	public List<LineInfo> getArrivalTerminal(String selectedTerminal) {
	// 선택한 터미널을 출발 터미널로 하는 버스 노선과 도착 터미널을 구하는 메서드
		String sql = "SELECT bl_idx, bt_eidx AS bt_departure, t2.bt_name AS bt_destination "
				   + "FROM t_bus_line\r\n"
				   + "JOIN t_bus_terminal t1 ON t_bus_line.bt_sidx = t1.bt_idx "
				   + "JOIN t_bus_terminal t2 ON t_bus_line.bt_eidx = t2.bt_idx "
				   + "WHERE t1.bt_name = '" + selectedTerminal + "' AND t1.bt_status = 'y' AND t2.bt_status = 'y'";
//		System.out.println(sql);
		List<LineInfo> lineList = jdbc.query(sql, (ResultSet rs, int rowNum) -> {
			LineInfo li = new LineInfo();
			li.setBl_idx(rs.getInt("bl_idx"));
			li.setEname(rs.getString("bt_destination"));
			return li;
		});
		return lineList;
	}

	public List<ArriveInfo> getArrivalTerminal(String arrivalTerminal, String busCompany, String time) {
	// 
		if (busCompany.equals("전체"))	busCompany = "";
		else 							busCompany = " and bc.bc_name = '" + busCompany + "' ";
		
		String sql = "SELECT bs.bs_stime AS stime, bs.bs_etime AS etime, "
				+ "   CASE "
				+ "   		WHEN bs.bs_etime <= curtime() THEN '도착' "
				+ "        	WHEN bs.bs_stime <= curtime() and bs.bs_etime >= curtime() THEN '운행중' "
				+ "        	ELSE '출발전' "
				+ "   END AS status, "
				+ "   IF( "
				+ "        TIMEDIFF(bs.bs_etime, curtime()) >= 0, "
				+ "        TIMEDIFF(bs.bs_etime, curtime()), "
				+ "        '-'"
				+ "    ) AS leftTime, "
				+ "			bc.bc_name AS bcname, "
				+ "   	 	bi.bi_level AS bilevel, "
				+ "    		bi.bi_num AS binum "
				+ "	  FROM t_bus_schedule bs "
				+ "   JOIN "
				+ "			t_bus_info bi ON bs.bi_idx = bi.bi_idx "
				+ "   JOIN "
				+ "			t_bus_company bc ON bi.bc_idx = bc.bc_idx "
				+ "   WHERE "
				+ "			bs.bl_idx = " + arrivalTerminal 
				+ 			busCompany 
				+ " AND ("
				+ "        (bs.bs_etime >= curtime() AND TIME_TO_SEC(TIMEDIFF(bs.bs_etime, curtime())) <= 2*60*60) "
				+ "        OR (bs.bs_etime <= curtime() AND TIME_TO_SEC(TIMEDIFF(curtime(), bs.bs_etime)) <= 30*60) "
				+ " )";
//		System.out.println(sql);
		List<ArriveInfo> timeList = jdbc.query(sql, (ResultSet rs, int rowNum) -> {
			ArriveInfo ai = new ArriveInfo();
			String leftTime = rs.getString("leftTime");
			if(rs.getString("leftTime") != null && !rs.getString("leftTime").equals("-"))
				leftTime = rs.getString("leftTime").substring(0, 5);
			ai.setBs_stime(rs.getString("stime"));
			ai.setBs_etime(rs.getString("etime"));
			ai.setLeftTime(leftTime);
			ai.setBc_company(rs.getString("bcname"));
			ai.setBi_num(rs.getString("binum"));
			ai.setStatus(rs.getString("status"));
			ai.setBi_level(rs.getString("bilevel"));
			
			return ai;
		});
	 
		return timeList;
	}
}
