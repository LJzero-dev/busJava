package dao;

import java.util.*;
import java.sql.*;
import javax.sql.*;
import config.*;
import org.apache.tomcat.jdbc.pool.DataSource.*;
import org.springframework.jdbc.core.*;
import org.springframework.jdbc.support.*;
import vo.*;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;

public class MemberDao {
	private JdbcTemplate jdbc;

	public MemberDao(DataSource dataSource) {
		 this.jdbc = new JdbcTemplate(dataSource);
	}
	
	public MemberInfo getLoginInfo(String mi_id, String mi_pw) {
		String sql = "select * from t_member_info where mi_id = ? and mi_pw = ? and mi_status != '탈퇴' ";

		List<MemberInfo> results = jdbc.query(sql, new RowMapper<MemberInfo>() {
			public MemberInfo mapRow(ResultSet rs, int rowNum) throws SQLException {
				MemberInfo mi = new MemberInfo();
				mi.setMi_id(rs.getString("mi_id"));
	            mi.setMi_pw(rs.getString("mi_pw"));
	            mi.setMi_name(rs.getString("mi_name"));
	            mi.setMi_gender(rs.getString("mi_gender"));
	            mi.setMi_phone(rs.getString("mi_phone"));
	            mi.setMi_email(rs.getString("mi_email"));
	            mi.setMi_status(rs.getString("mi_status"));
	            mi.setMi_date(rs.getString("mi_date"));
	            mi.setMi_lastlogin(rs.getString("mi_lastlogin"));
	            mi.setMi_pmoney(rs.getInt("mi_pmoney"));
	            mi.setMi_stamp(rs.getInt("mi_stamp"));
	            mi.setMi_coupon(rs.getInt("mi_coupon"));
	            return mi;
			}
		}, mi_id, mi_pw);
		// 쿼리에 직접 값을 넣으면 매개변수로 값을 추가할 필요 없음
		
		return results.isEmpty() ? null : results.get(0);
	}

	public int memberInsert(MemberInfo mi) {
		String sql = "insert into t_member_info values ('" + mi.getMi_id() + "', '" + mi.getMi_pw() + 
				"', '" + mi.getMi_name() + "', '" + mi.getMi_gender() + "', '" + mi.getMi_phone() + 
				"', '" + mi.getMi_email() + "', 0, 0, 0, '정상', now(), null) ";
		int result = jdbc.update(sql);
		
		System.out.println(sql);
		
		return result;
	}

	public int chkDupId(String mi_id) {
		String sql = "select count(*) from t_member_info where mi_id = '" + mi_id + "' ";
		int result = jdbc.queryForObject(sql, Integer.class);
		return result;
	}
	
	public int chkDupMail(String mi_email) {
		String sql = "select count(*) from t_member_info where mi_email = '" + mi_email + "' ";
		int result = jdbc.queryForObject(sql, Integer.class);
		return result;
	}
	
	public int chkDupPhone(String mi_phone) {
		String sql = "select count(*) from t_member_info where mi_phone = '" + mi_phone + "' ";
		int result = jdbc.queryForObject(sql, Integer.class);
		return result;
	} 

	public int chkDupIdMail(String mi_id, String mi_email) {
		String sql = "select count(*) from t_member_info where mi_id = '" + mi_id + "' and mi_email= '" + mi_email + "' ";
		int result = jdbc.queryForObject(sql, Integer.class);
		return result;
	}

	public String passDupMail(String email) {
		String sql = "select mi_id from t_member_info where mi_email = '" + email + "'";
		String mi_id = jdbc.queryForObject(sql, String.class);
		return mi_id;
	}

	public int passDupIdMail(String mi_id, String email, String newPw) {
		String sql = "update t_member_info set mi_pw = '" + newPw + "' where mi_id = '" + mi_id + "' and mi_email = '" + email + "' ";
		int resultUp = jdbc.update(sql);
		return resultUp;
	}

	public int memberPwChk(String mi_id, String mi_pw) {
		String sql = "select count(*) from t_member_info where mi_id = '" + mi_id + "' and mi_pw= '" + mi_pw + "' ";
		int result = jdbc.queryForObject(sql, Integer.class);
		return result;
	}

	public int memberUpPw(String mi_id, String mi_pw) {
		String sql = "update t_member_info set mi_pw = '" + mi_pw + "' where mi_id = '" + mi_id + "' ";
		int result = jdbc.update(sql);
		return result;
	}

	public int memberUpMail(String mi_id, String mi_email) {
		String sql = "update t_member_info set mi_email = '" + mi_email + "' where mi_id = '" + mi_id + "' ";
		int result = jdbc.update(sql);
		return result;
	}

	public int memberUpPhone(String mi_id, String mi_phone) {
		String sql = "update t_member_info set mi_phone = '" + mi_phone + "' where mi_id = '" + mi_id + "' ";
		int result = jdbc.update(sql);
		return result;
	}

	public int memberDel(String mi_id, String mi_pw) {
		String sql = "update t_member_info set mi_status = '탈퇴' where mi_id = '" + mi_id + "' and mi_pw = '" + mi_pw + "' ";
		int result = jdbc.update(sql);
		return result;
	}

	public List<BookInfo> getBookList(String mi_id, int cpage, int psize) {
		String sql = " select ri.ri_idx, ri.ri_sday, ri.ri_acnt, ri.ri_scnt, ri.ri_ccnt, ri.ri_status, bs.bs_stime, bl.bl_type, bt1.bt_name as bt1_sidx, bt2.bt_name as bt2_eidx "
				+ " from t_reservation_info ri, t_bus_schedule bs, t_seat_info si , t_bus_line bl, t_bus_terminal bt1, t_bus_terminal bt2 "
				+ " where ri.bs_idx = bs.bs_idx and bs.bl_idx = bl.bl_idx and bs.bi_idx = si.bi_idx and bl.bt_sidx = bt1.bt_idx and bl.bt_eidx = bt2.bt_idx and ri.mi_id = '" + mi_id + "' and ri.ri_date >= DATE_SUB(NOW(), INTERVAL 3 MONTH) "
				+ " GROUP BY ri.ri_idx order by ri.ri_idx desc "
				+ " limit "+ ((cpage - 1) * psize) + ", " + psize;
		/* System.out.println(sql); */
		List<BookInfo> bookList = jdbc.query(sql, (ResultSet rs, int rowNum) -> {
			BookInfo  bi = new BookInfo(
					rs.getInt("ri_acnt"),
					rs.getInt("ri_scnt"),
					rs.getInt("ri_ccnt"),
					rs.getString("bt1_sidx"),
					rs.getString("bt2_eidx"),
					rs.getString("ri_status"),
					rs.getString("ri_sday"),
					rs.getString("bs_stime"),
					rs.getString("bl_type"),
					rs.getString("ri_idx"),
					getBusSeatList(rs.getString("ri_idx")));
			return bi;
		});
		return bookList;
	}
	
	private List<BusSeatList> getBusSeatList(String ri_idx) {
		String sql = "select si.si_seat "
				+ " from t_reservation_detail rd, t_seat_info si "
				+ " where rd.si_idx = si.si_idx and rd.ri_idx = '" + ri_idx + "'";
		/* System.out.println(sql); */
		List<BusSeatList> busSeatList = jdbc.query(sql, (ResultSet rs, int rowNum) -> {
			BusSeatList bs = new BusSeatList(rs.getString("si_seat"));
			return bs;
		});
		return busSeatList;
	}

	public int getbookListCount(String mi_id) {
		String sql = "select count(*) from t_reservation_info where mi_id = '" + mi_id + "' ";
		/* System.out.println(sql); */
		int rcnt = jdbc.queryForObject(sql, Integer.class);
		return rcnt;
	}

	public BookInfo getBookInfo(String riidx) {
		String sql = "SELECT DISTINCT "
				+ " bs.bs_stime, bi.bi_level, bc.bc_name, ri.ri_idx, ri.ri_sday, ri.ri_acnt, ri.ri_scnt, ri.ri_ccnt, ri.ri_status, bl.bl_type, bt1.bt_name as bt1_sidx, bt2.bt_name as bt2_eidx, cr.cr_date, cr.cr_payment, "
				+ " cr_total.total_cr_pay, pd.pd_real_price "
				+ " FROM t_payment_detail pd, t_reservation_info ri, t_bus_schedule bs, t_bus_info bi, t_bus_company bc, t_bus_line bl, t_bus_terminal bt1, t_bus_terminal bt2, t_count_rinfo cr, (SELECT ri_idx, SUM(cr_pay) AS total_cr_pay FROM t_count_rinfo GROUP BY ri_idx) cr_total "
				+ " WHERE ri.ri_idx = pd.ri_idx and ri.bs_idx = bs.bs_idx and bs.bi_idx = bi.bi_idx and bi.bc_idx = bc.bc_idx and bs.bl_idx = bl.bl_idx and bl.bt_sidx = bt1.bt_idx and bl.bt_eidx = bt2.bt_idx and ri.ri_idx = cr.ri_idx and ri.ri_idx = cr_total.ri_idx "
				+ " and ri.ri_idx = '" + riidx + "' ORDER BY ri.ri_sday ASC;";
		/*String sql = "SELECT DISTINCT "
				+ " bs.bs_stime, bi.bi_level, bc.bc_name, ri.ri_idx, ri.ri_sday, ri.ri_acnt, ri.ri_scnt, ri.ri_ccnt, ri.ri_status, bl.bl_type, bt1.bt_name as bt1_sidx, bt2.bt_name as bt2_eidx, cr.cr_date, cr.cr_payment, cr.cr_pay "
				+ " FROM t_reservation_info ri, t_bus_schedule bs, t_bus_info bi, t_bus_company bc, t_bus_line bl, t_bus_terminal bt1, t_bus_terminal bt2, t_count_rinfo cr "
				+ " WHERE  ri.bs_idx = bs.bs_idx and bs.bi_idx = bi.bi_idx and bi.bc_idx = bc.bc_idx and bs.bl_idx = bl.bl_idx and bl.bt_sidx = bt1.bt_idx and bl.bt_eidx = bt2.bt_idx and ri.ri_idx = cr.ri_idx "
				+ " and ri.ri_idx = '" + riidx + "' ORDER BY ri.ri_sday ASC";
		*/
		BookInfo bi = jdbc.queryForObject(sql, new RowMapper<BookInfo>() {
			@Override
			public BookInfo mapRow(ResultSet rs, int rowNum) throws SQLException {
				BookInfo bi = new BookInfo(
				rs.getInt("ri_acnt"),
				rs.getInt("ri_scnt"),
				rs.getInt("ri_ccnt"),
				rs.getString("ri_status"),
				rs.getString("ri_sday"),
				rs.getString("bs_stime"),
				rs.getString("bl_type"),
				rs.getString("ri_idx"),
				rs.getString("cr_payment"),
				rs.getString("cr_date"),
				rs.getString("bt1_sidx"),
				rs.getString("bt2_eidx"),
				rs.getString("bi_level"),
				rs.getString("bc_name"),
				rs.getInt("total_cr_pay"),
				rs.getInt("pd_real_price"),
				getBusSeatList(rs.getString("ri_idx")));
						
	            return bi;
			}
		});
		
		return bi;
	}
	
	public List<paymoneyInfo> getpaymoneyList(String mi_id) {
		String sql = " SELECT DISTINCT cr_total.total_cr_pmoney, bt1.bt_name AS bt_sidx, bt2.bt_name AS bt_eidx, cr.cr_date, ri.ri_idx, bl_type "
				+ "FROM t_reservation_info ri, t_bus_schedule bs, t_bus_line bl, t_bus_terminal bt1,t_bus_terminal bt2, t_count_rinfo cr, "
				+ "(SELECT ri_idx, SUM(cr_pmoney) AS total_cr_pmoney FROM t_count_rinfo GROUP BY ri_idx) cr_total "
				+ "WHERE ri.bs_idx = bs.bs_idx and bs.bl_idx = bl.bl_idx and bl.bt_sidx = bt1.bt_idx and bl.bt_eidx = bt2.bt_idx "
				+ "and ri.ri_idx = cr.ri_idx and ri.ri_idx = cr_total.ri_idx and ri.mi_id='" + mi_id + "' AND cr_total.total_cr_pmoney > 0 "
				+ " AND cr.cr_date >= DATE_SUB(NOW(), INTERVAL 3 MONTH) ";
		List<paymoneyInfo> pList = jdbc.query(sql, (ResultSet rs, int rowNum) -> {
				paymoneyInfo pi = new paymoneyInfo(
				rs.getString("bt_eidx"),
				rs.getString("bt_sidx"),
				rs.getString("cr_date"),
				rs.getString("ri_idx"),
				rs.getString("bl_type"),
				rs.getInt("total_cr_pmoney"));
		
	            return pi;
			});
		return pList;
	}

	public List<paymoneyInfo> getmphList(String mi_id) {
		String sql = "select mph_date, mph_payment, mph_pmoney, mph_idx, mph_real_price "
				+ " from t_member_pmoney_history where mi_id =  '"+ mi_id+"' AND mph_date >= DATE_SUB(NOW(), INTERVAL 3 MONTH) ";
		List<paymoneyInfo> mphList = jdbc.query(sql, (ResultSet rs, int rowNum) -> {
				paymoneyInfo pi = new paymoneyInfo(
				rs.getString("mph_date"),
				rs.getString("mph_payment"),
				rs.getInt("mph_pmoney"),
				rs.getInt("mph_idx"),
				rs.getInt("mph_real_price"));
		
	            return pi;
			});
		return mphList;
	}
	
	public int getrealCancel(String riidx, String mi_id) {
		String sday="", stime="";
		int result = 0;
		String sql = "select DISTINCT ri.ri_sday, bs.bs_stime, pd.pd_payment, pd.pd_real_price "
				+ " from t_reservation_info ri, t_bus_schedule bs, t_payment_detail pd "
				+ " where ri.bs_idx = bs.bs_idx and ri.ri_idx = pd.ri_idx and ri.mi_id='" + mi_id + "' and ri.ri_idx='" + riidx + "' ";

		BookInfo bi = jdbc.queryForObject(sql, new RowMapper<BookInfo>() {
			@Override
			public BookInfo mapRow(ResultSet rs, int rowNum) throws SQLException {
				BookInfo bi = new BookInfo(
				rs.getString("ri_sday"),
				rs.getString("bs_stime"),
				rs.getInt("pd_real_price"),
				rs.getString("pd_payment"));
				
				return bi;
			}
		});
		
		// 1. 예매정보조회 - 날짜 및 시간 출력
		sday = bi.getRi_sday(); stime = bi.getBs_stime(); 
		int realPrice = bi.getPd_real_price();
		
		// 2.1 날짜 및 시간 LocalDateTime 객체로 변환
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
        LocalDateTime departTime = LocalDateTime.parse(sday + " " + stime, formatter);

        // 2.2 현재 시간과의 차이 계산
        LocalDateTime now = LocalDateTime.now();
        long diffMinutes = ChronoUnit.MINUTES.between(now, departTime);

        // 3. 취소 수수료 결정
        int cancelPrice;
        if (diffMinutes >= 2 * 24 * 60) {
        	cancelPrice = 0;
        } else if (diffMinutes >= 24 * 60) {
        	cancelPrice = (realPrice/100) * 5;
        } else if (diffMinutes >= 60) {
        	cancelPrice = (realPrice/100) * 10;
        } else {
        	cancelPrice = (realPrice/100) * 30;
        }


        // 4. 예매 취소 처리
        sql = "UPDATE t_reservation_info SET ri_status = '예매취소' WHERE mi_id= '" + mi_id + "' and ri_idx = '" + riidx + "' " ;
        result += jdbc.update(sql);
// System.out.println(sql);
        
        // 5. 환불 처리 및 수수료 반영
        // 결제 금액이 수수료 금액으로 변경 취소 수수료를 결제 내역에 추가.
		/*
		  sql = "UPDATE t_payment_detail SET pd_real_price = "+ cancelPrice +
		  ", pd_total_price = "+ cancelPrice + " " + ", pd_payment = '" +
		  bi.getPd_payment() + "' " + " WHERE mi_id = '" + mi_id + "' and ri_idx = '" +
		  riidx + "' " ; result += jdbc.update(sql);
		*/
        
        sql = "UPDATE t_count_rinfo  SET cr_pay = "+ cancelPrice + " "
        		+ ", cr_payment = '" + bi.getPd_payment() + "' "
        		+ " WHERE ri_idx = '" + riidx + "' " ;    
        result += jdbc.update(sql);
        
        // 6.취소한 자리에 예매를 위해 t_reservation_detail 의 정보는 삭제 해준다
        sql = "DELETE FROM t_reservation_detail WHERE ri_idx = '" + riidx + "' ";
        result += jdbc.update(sql);     


// System.out.println(result);        
        return result;
	}
	
}















