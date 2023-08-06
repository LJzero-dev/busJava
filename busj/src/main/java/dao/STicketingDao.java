package dao;

import java.util.*;
import java.sql.*;
import java.time.*;
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
				" ON bl.bt_eidx = bt.bt_idx WHERE bt_sidx = ? and bl_status = 'y' and bl_type = '시외'"
				;
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

	public int getsLineNum(String btsname, String btename) {
	// 출/도착지 터미널 이름으로 노선번호 셀렉트
		String sql = "select bl_idx from t_bus_line " 
				 + "join t_bus_terminal start_terminal on t_bus_line.bt_sidx = start_terminal.bt_idx "
				 + "join t_bus_terminal end_terminal on t_bus_line.bt_eidx = end_terminal.bt_idx "
				 + " where start_terminal.bt_name = '" + btsname + "' and end_terminal.bt_name = '" + btename + "' and t_bus_line.bl_type = '시외' ";
		int result = jdbc.queryForObject(sql, Integer.class);
		return result;
	}
	
	public List<ReservationStep2> getScheduleList(int blidx, String ri_sday1) {
	// 해당 노선의 시간표를 가져오는 메서드
		String sql = "select tt.*, "
				+ "total_seat - IFNULL((SELECT sum(ri_acnt + ri_scnt + ri_ccnt) FROM t_reservation_info ri WHERE ri.bs_idx = tt.bs_idx and ri.ri_sday = '" + ri_sday1.replace(".", "-") + "'), 0) "
				+ "as left_seat "
				+ "from ( "
				+ "SELECT a.bs_idx, a.bl_idx, a.bi_idx, d.bc_name, b.bl_adult, c.bi_level, a.bs_stime, a.bs_etime, "
				+ "CASE c.bi_level "
				+ "WHEN '일반' THEN 36 "
				+ "WHEN '우등' THEN 28 "
				+ "WHEN '프리미엄' THEN 18 "
				+ "END AS total_seat "
				+ "FROM t_bus_schedule a, t_bus_line b, t_bus_info c, t_bus_company d "
				+ "WHERE a.bl_idx = b.bl_idx and a.bi_idx = c.bi_idx and c.bc_idx = d.bc_idx and a.bl_idx = " + blidx + " ) tt";
		
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

	public List<SeatInfo> getSeatList(int bsidx, String ri_sday1) {
	// 받아온 시간표인덱스로 버스번호를 구해 좌석개수를 가져오고 선택된 날짜와 시간표에 예매된 좌석이 있는지 체크
//		System.out.println(ri_sday1);
		String sql =  "SELECT bi.bi_idx, bi.bi_num, bs.bs_idx, si.si_idx, si.si_seat, "
					+ "    CASE "
					+ "        WHEN rd.ri_idx IS NOT NULL and ri.ri_sday = DATE('" + ri_sday1.replace(".", "-") + "') THEN 'Y' "
					+ "        ELSE 'N' "
					+ "    END AS reserved_yn "
					+ "FROM t_bus_info bi "
					+ "    INNER JOIN t_bus_schedule bs ON bi.bi_idx = bs.bi_idx "
					+ "    INNER JOIN t_seat_info si ON bi.bi_idx = si.bi_idx "
					+ "    INNER JOIN t_bus_line bl ON bs.bl_idx = bl.bl_idx "
					+ "    LEFT JOIN t_reservation_detail rd ON si.si_idx = rd.si_idx "
					+ "    LEFT JOIN t_reservation_info ri ON rd.ri_idx = ri.ri_idx AND ri.ri_status <> '예매취소' "
					+ "WHERE "
					+ "    bs.bs_isuse = 'y' and "
					+ "    bs.bs_idx = " + bsidx;
//		System.out.println(sql);
		List<SeatInfo> seatList = jdbc.query(sql, (ResultSet rs, int rowNum) -> {
			SeatInfo si = new SeatInfo();
			si.setSi_idx(rs.getInt("si_idx"));
			si.setSi_seat(rs.getInt("si_seat"));
			si.setReserved_yn(rs.getString("reserved_yn"));
			return si;
		});
		return seatList;
	}

	/*
	 * public int chargeAmountIn(String uid, String payment, int chargePmoney, int
	 * totalPmoney) { String sql =
	 * "INSERT INTO T_MEMBER_PMONEY_HISTORY(mi_id, mph_payment, mph_real_price, mph_pmoney) values "
	 * + "('" + uid + "', '" + payment + "', " + chargePmoney + ", " + totalPmoney +
	 * ") "; int result = jdbc.update(sql); return result; }
	 */

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
	
	public String reservationIn(MemberInfo loginInfo, ReservationInfo ri) {
	// 
		String ri_idx = getReservationId();
		int bs_idx = ri.getBs_idx();

		String sql = "INSERT INTO T_RESERVATION_INFO (ri_idx, bs_idx, mi_id, ri_sday, ri_acnt, ri_scnt, ri_ccnt, ri_status) VALUES ('" +
			ri_idx + "', " + bs_idx + ", '" + loginInfo.getMi_id() + "', '" + ri.getSdate() + "', " + ri.getRi_acnt() + ", " + ri.getRi_scnt() + ", " + ri.getRi_ccnt() + ", '예매')";
		jdbc.update(sql);
		
		return ri_idx;
	}

	public List<String> getSeat(String seatWhere) {
		String sql = "SELECT SI.si_idx " + 
				"FROM T_BUS_SCHEDULE BS, T_SEAT_INFO SI " + seatWhere;
		List<String> seatArr = jdbc.query(sql, (ResultSet rs, int rowNum) -> {
			return Integer.toString(rs.getInt("si_idx"));
		});

		return seatArr;
	}

	public void reservationSeatIn(String result, List<String> seatArr) {
		for (String seat : seatArr) {
			String sql = "INSERT INTO T_RESERVATION_DETAIL (ri_idx, si_idx) VALUES ('" + result + "', '" + seat + "')";
			jdbc.update(sql);
		}
	}

	public void reservationUserUp(MemberInfo loginInfo, ReservationInfo ri, int totalP) {
		String sql = "UPDATE T_MEMBER_INFO SET MI_PMONEY = MI_PMONEY - " + totalP + " WHERE MI_ID = '" + loginInfo.getMi_id() + "'";
		jdbc.update(sql);
		
	}

	public void reservationPayIn(String result, MemberInfo loginInfo, ReservationInfo ri, int totalP) {
		// 회원 결제내역 테이블 insert
		String sql = "INSERT INTO T_PAYMENT_DETAIL (ri_idx, mi_id, pd_payment, pd_total_price, pd_real_price) VALUES ('" +
				result + "', '" + loginInfo.getMi_id() + "', '"+ ri.getPayment() + "', " + totalP + ", " + totalP + ")";
		jdbc.update(sql);
		
	}

	public void reservationCntIn(String result, ReservationInfo ri, int totalP) {
		String sql;
		if (ri.getPayment().equals("페이머니")) {
			sql = "INSERT INTO T_COUNT_RINFO (ri_idx, cr_payment, cr_pmoney) VALUES ('" + result + "', '" + ri.getPayment() + "', " + totalP + ")";
		} else {
			sql = "INSERT INTO T_COUNT_RINFO (ri_idx, cr_payment, cr_pay) VALUES ('" + result + "', '" + ri.getPayment() + "', " + totalP + ")";
		}
		
		jdbc.update(sql);
		
	}

	
}
