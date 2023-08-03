package dao;

import java.util.*;
import java.sql.*;
import java.time.LocalDate;

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
		RowMapper<LineInfo> rowMapper = (rs, rowNum) -> {
            LineInfo li = new LineInfo();
            li.setBt_sidx(rs.getInt("bt_sidx"));
            li.setBt_eidx(rs.getInt("bt_eidx"));
            li.setEname(rs.getString("bt_name"));
            li.setEarea(rs.getString("bt_area"));
            return li;
        };

        return jdbc.query(sql, rowMapper, btsidx);
	}

	public int getLineNum(String spoint, String epoint) {
		String sql = 
				"SELECT bl.bl_idx " + 
				"FROM t_bus_line bl " + 
				"JOIN t_bus_terminal start_terminal ON bl.bt_sidx = start_terminal.bt_idx " + 
				"JOIN t_bus_terminal end_terminal ON bl.bt_eidx = end_terminal.bt_idx " + 
				"WHERE start_terminal.bt_name = '" + spoint + "' AND end_terminal.bt_name = '" + epoint + "' ";
		int result = jdbc.queryForObject(sql, Integer.class);
		return result;
	}

	public List<ScheduleInfo> getSList(String sDate, int lineNum) {
		// 출발일, 노선번호에 따라 시간표 리턴.
		String sql = 
				"select " + 
				"	tt.*" + 
				"	, total_seat - IFNULL((SELECT sum(ri_acnt + ri_scnt + ri_ccnt) FROM t_reservation_info ri WHERE ri.bs_idx = tt.bs_idx and ri.ri_sday = '" + sDate + "'), 0)" + 
				"	as left_seat " + 
				"from ( " + 
				"	SELECT " +
				"		a.bl_idx, a.bi_idx, if(c.bc_idx = 1, '중앙', if(c.bc_idx = 2, '동부', if(c.bc_idx = 3, '금호', '동양'))) comname, b.bl_adult, c.bi_level, a.bs_stime, a.bs_etime, " + 
				"			CASE c.bi_level " + 
				"			WHEN '일반' THEN 36 " + 
				"			WHEN '우등' THEN 28 " + 
				"			WHEN '프리미엄' THEN 18 " + 
				"		END AS total_seat, " +
				"		a.bs_idx " + 
				"	FROM t_bus_schedule a, t_bus_line b, t_bus_info c " + 
				"	WHERE a.bl_idx = b.bl_idx and a.bi_idx = c.bi_idx and a.bl_idx = " + lineNum + ") tt ";
		
		List<ScheduleInfo> scheduleList = jdbc.query(
				sql, new RowMapper<ScheduleInfo>() {
					@Override
					public ScheduleInfo mapRow(ResultSet rs, int rowNum) throws SQLException {
						ScheduleInfo sl = new ScheduleInfo();
						sl.setBs_idx(rs.getInt("bs_idx"));
						sl.setBi_idx(rs.getInt("bi_idx"));
						sl.setBl_idx(rs.getInt("bl_idx"));
						sl.setBs_stime(rs.getString("bs_stime"));
						sl.setBs_etime(rs.getString("bs_etime"));
						sl.setBi_level(rs.getString("bi_level"));
						sl.setComname(rs.getString("comname"));
						sl.setBl_adult(rs.getInt("bl_adult"));
						sl.setTotal_seat(rs.getInt("total_seat"));
						sl.setLeft_seat(rs.getInt("left_seat"));
						return sl;
					}
				}
			);
		return scheduleList;
	}

	public List<SeatInfo> getSeatList(String sDate, int bsidx) {
		String sql = "SELECT SI.si_seat, if(RD.SI_IDX is null, 'N', 'Y') RESERVED_YN " + 
				"FROM T_BUS_INFO BI " + 
				"JOIN T_BUS_SCHEDULE BS ON BI.bi_idx = BS.bi_idx " + 
				"JOIN T_SEAT_INFO SI ON BI.bi_idx = SI.bi_idx " + 
				"LEFT JOIN ( " + 
				"   SELECT SRD.si_idx, SBS.bs_idx " + 
				"    FROM T_RESERVATION_INFO SRI " + 
				"    JOIN T_RESERVATION_DETAIL SRD ON SRI.ri_idx = SRD.ri_idx " + 
				"    JOIN T_BUS_SCHEDULE SBS ON SBS.bs_idx = SRI.bs_idx " + 
				"    JOIN T_BUS_INFO SBI ON SBS.bi_idx = SBI.bi_idx " + 
				"    WHERE SBS.bs_idx = " + bsidx + " AND SRI.ri_sday = '" + sDate + "'" +
				") RD " + 
				"ON BS.bs_idx = RD.bs_idx AND SI.si_idx = RD.si_idx " + 
				"WHERE BS.bs_idx = " + bsidx;
		List<SeatInfo> seatList = jdbc.query(
				sql, new RowMapper<SeatInfo>() {
					@Override
					public SeatInfo mapRow(ResultSet rs, int rowNum) throws SQLException {
						SeatInfo seatInfo = new SeatInfo();
						seatInfo.setSi_seat(rs.getInt("SI_SEAT"));
						seatInfo.setReserved_yn(rs.getString("RESERVED_YN"));
						return seatInfo;
					}
				}
			);
		return seatList;
	}

	public int chargeAmountIn(String uid, String payment, int chargePmoney, int totalPmoney) {
		String sql = "INSERT INTO T_MEMBER_PMONEY_HISTORY(mi_id, mph_payment, mph_real_price, mph_pmoney) values "
				+ "('" + uid + "', '" + payment + "', " + chargePmoney + ", " + totalPmoney + ") ";
		int result = jdbc.update(sql);
		return result;
	}

	public int chargeAmountUp(MemberInfo loginInfo, String uid, int totalPmoney) {
		String sql = "UPDATE T_MEMBER_INFO SET mi_pmoney = mi_pmoney + " + totalPmoney + " WHERE mi_id = '" + loginInfo.getMi_id() + "'";
		
		// 세션에 담긴 회원의 페이머니 재설정
		loginInfo.setMi_pmoney(loginInfo.getMi_pmoney() + totalPmoney);
		
		int result = jdbc.update(sql);
		return result;
	}
	
	private String getReservationId() {
	// 예약번호를 만드는 메서드. 다른곳에서 쓰지 않으므로 private로 선언
		String ri_idx = "";
		LocalDate today = LocalDate.now();	// yyyy-mm-dd
		String td = (today + "").substring(2).replace("-", "");	// yymmdd
		
		String alpha = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
		Random rnd = new Random();
		String eng = alpha.charAt(rnd.nextInt(26)) + "" + alpha.charAt(rnd.nextInt(26));
		
		String sql = "SELECT MAX(RIGHT(ri_idx, 4)) seq FROM T_RESERVATION_INFO WHERE LEFT(ri_idx, 6) = '" + td + "' ";
		
		Integer maxIdx = jdbc.queryForObject(sql, Integer.class);
		int nextIdx = (maxIdx != null) ? maxIdx + 1 : 1001; 
		
		ri_idx = td + eng + nextIdx;
		
		return ri_idx;
	}
	
	private int getScheduleNum(int blidx, String stime) {
	// 노선번호와 출발시각으로 bs_idx를 구해옴. 다른곳에서 쓰지 않으므로 private 선언
		int bs_idx = 0;
		
		String sql = "SELECT bs_idx FROM T_BUS_SCHEDULE WHERE bl_idx = ? and bs_stime = ?";
		bs_idx = jdbc.queryForObject(sql, Integer.class, blidx, stime);
		return bs_idx;
	}

	public String reservationIn(MemberInfo loginInfo, ReservationInfo ri1) {
		String ri_idx = getReservationId();
		int bs_idx = getScheduleNum(ri1.getLinenum(), ri1.getStime());

		String sql = "INSERT INTO T_RESERVATION_INFO (ri_idx, bs_idx, mi_id, ri_sday, ri_acnt, ri_scnt, ri_ccnt, ri_status) VALUES ('" +
			ri_idx + "', " + bs_idx + ", '" + loginInfo.getMi_id() + "', '" + ri1.getSdate() + "', " + ri1.getRi_acnt() + ", " + ri1.getRi_scnt() + ", " + ri1.getRi_ccnt() + ", '예매')";
		jdbc.update(sql);
		
		return ri_idx;
	}

	public void reservationSeatIn(String result, String[] seats1) {
		for (String seat : seats1) {
			String sql = "INSERT INTO T_RESERVATION_DETAIL (ri_idx, si_idx) VALUES ('" + result + "', '" + seat + "')";
			System.out.println(sql);
			jdbc.update(sql);
		}
	}

	public void reservationUserUp(MemberInfo loginInfo, ReservationInfo ri1, int totalP) {
		String sql = "UPDATE T_MEMBER_INFO SET MI_PMONEY = MI_PMONEY - " + totalP + " WHERE MI_ID = '" + loginInfo.getMi_id() + "'";
		System.out.println(sql);
		jdbc.update(sql);
	}

	public void reservationPayIn(String result, MemberInfo loginInfo, ReservationInfo ri1, int totalP) {
	// 회원 결제내역 테이블 insert
		String sql = "INSERT INTO T_PAYMENT_DETAIL (ri_idx, mi_id, pd_payment, pd_total_price, pd_real_price) VALUES ('" +
				result + "', '" + loginInfo.getMi_id() + "', '"+ ri1.getPayment() + "', " + totalP + ", " + totalP + ")";
		System.out.println(sql);
		jdbc.update(sql);
	}

	public void reservationCntIn(String result, ReservationInfo ri1, int totalP) {
		String sql;
		if (ri1.getPayment().equals("페이머니")) {
			sql = "INSERT INTO T_COUNT_RINFO (ri_idx, cr_payment, cr_pmeony) VALUES ('" + result + "', '" + ri1.getPayment() + "', " + totalP + ")";
		} else {
			sql = "INSERT INTO T_COUNT_RINFO (ri_idx, cr_payment, cr_pay) VALUES ('" + result + "', '" + ri1.getPayment() + "', " + totalP + ")";
		}
		
		jdbc.update(sql);
	}
	
	




	

}

