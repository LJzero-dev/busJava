package dao;

import java.util.*;
import java.sql.*;
import javax.sql.*;
import config.*;
import org.apache.tomcat.jdbc.pool.DataSource.*;
import org.springframework.jdbc.core.*;
import org.springframework.jdbc.support.*;
import vo.*;

public class STicketingDao {
	private JdbcTemplate jdbc;

	public STicketingDao(DataSource dataSource) {
		this.jdbc = new JdbcTemplate(dataSource);
	}

	public List<TerminalInfo> pickSpotSlow() {
		String sql = "select * from t_bus_terminal where bt_type != 'b' and bt_status = 'y'";

		List<TerminalInfo> terminalList = jdbc.query(sql, (ResultSet rs, int rowNum) -> {
			TerminalInfo ti = new TerminalInfo(rs.getInt("bt_idx"), rs.getString("bt_name"), rs.getString("bt_area"), rs.getString("bt_type"), rs.getString("bt_status"));
			return ti;
		});
		return terminalList;
	}

	public List<LineInfo> getArrivalLineList(int btsidx) {
	// 출/도착지 팝업 jsp파일에서 출발지를 선택 하면 선택한 터미널에서 출발하는 노선의 정보를 가져오는 메서드
		String sql = "SELECT bl.*, bt.bt_name, bt.bt_area FROM t_bus_line bl JOIN t_bus_terminal bt " + 
				" ON bl.bt_eidx = bt.bt_idx WHERE bt_sidx = ? and bl_status = 'y' and bl_type = '시외'";
		// 노선테이블과 터미널테이블 조인 / 출발지가 ?인 도착지 
		RowMapper<LineInfo> rowMapper = (rs, rowNum) -> {
            LineInfo li = new LineInfo();
            li.setBl_idx(rs.getInt("bl_idx"));		// 노선번호
            li.setBt_sidx(rs.getInt("bt_sidx"));	// 출발지
            li.setBt_eidx(rs.getInt("bt_eidx"));	// 도착지
            li.setBl_type(rs.getString("bl_type"));	// 노선 구분(고속, 시외)
            li.setBl_adult(rs.getInt("bl_adult"));	// 성인요금(청소년0.8, 아동0.5)
            li.setEname(rs.getString("bt_name"));	// 터미널 이름
            li.setEarea(rs.getString("bt_area"));	// 지역
            return li;
        };

        return jdbc.query(sql, rowMapper, btsidx);
        // 정의된 SQL 쿼리와 RowMapper를 사용하여 데이터베이스에서 노선 정보를 가져옵니다. btsidx가 쿼리의 ? 자리에 바인딩되어 해당 출발지의 노선 정보를 검색
        // btsidx에 해당하는 출발지의 노선 정보가 List<LineInfo> 형태로 반환
	}

	public List<ReservationStep2> getScheduleList(String btsname, String btename) {
	// 해당 노선의 시간표를 가져오는 메서드
		String sql = "SELECT bs_idx, bs_stime, bc_name, bi_level, bl_adult "
				+ "FROM t_bus_schedule "
				+ "JOIN t_bus_info ON t_bus_schedule.bi_idx = t_bus_info.bi_idx "
				+ "JOIN t_bus_line ON t_bus_schedule.bl_idx = t_bus_line.bl_idx "
				+ "JOIN t_bus_terminal AS start_terminal ON t_bus_line.bt_sidx = start_terminal.bt_idx "
				+ "JOIN t_bus_terminal AS end_terminal ON t_bus_line.bt_eidx = end_terminal.bt_idx "
				+ "JOIN t_bus_company ON t_bus_info.bc_idx = t_bus_company.bc_idx "
				+ "WHERE start_terminal.bt_name = '" + btsname + "' AND end_terminal.bt_name = '" + btename + "' AND t_bus_line.bl_type = '시외'";
		
		List<ReservationStep2> scheduleList = jdbc.query(sql, (ResultSet rs, int rowNum) -> {
			ReservationStep2 sl = new ReservationStep2();
			sl.setBs_idx(rs.getInt("bs_idx"));
			sl.setBs_stime(rs.getString("bs_stime"));
			sl.setBc_name(rs.getString("bc_name"));
			sl.setBi_level(rs.getString("bi_level"));
			sl.setBl_adult(rs.getInt("bl_adult"));
			return sl;
		});
		return scheduleList;
	}
	
}
