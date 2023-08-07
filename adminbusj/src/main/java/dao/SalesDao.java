package dao;

import java.sql.*;
import java.time.*;
import java.util.*;
import javax.sql.*;
import org.springframework.jdbc.core.*;
import vo.*;

public class SalesDao {
	private JdbcTemplate jdbc;
	
	public SalesDao(DataSource dataSource) {
		this.jdbc = new JdbcTemplate(dataSource);
	}

	public List<SalesInfo> getSalesList() {
	// 기본 일주일 매출목록 불러옴
		LocalDate nowDate = LocalDate.now();

		String sql = "SELECT BL.bl_idx, BL.bl_type, SBT.bt_name AS start_terminal, EBT.bt_name AS end_terminal, COUNT(BS.bs_idx) AS num_of_trips," + 
				"    SUM(CASE WHEN CR.cr_payment = '카드' THEN CR.cr_pay ELSE 0 END) AS card_sales, " + 
				"    SUM(CASE WHEN CR.cr_payment = '무통장입금' THEN CR.cr_pay ELSE 0 END) AS bank_sales, " + 
				"    SUM(CASE WHEN CR.cr_payment = '간편결제' THEN CR.cr_pay ELSE 0 END) AS mobile_sales " + 
				"FROM T_COUNT_RINFO CR " + 
				"    JOIN T_RESERVATION_INFO RI ON CR.ri_idx = RI.ri_idx " + 
				"    JOIN T_BUS_SCHEDULE BS ON RI.bs_idx = BS.bs_idx " + 
				"    JOIN T_BUS_LINE BL ON BS.bl_idx = BL.bl_idx " + 
				"    JOIN T_BUS_TERMINAL SBT ON BL.bt_sidx = SBT.bt_idx " + 
				"    JOIN T_BUS_TERMINAL EBT ON BL.bt_eidx = EBT.bt_idx " + 
				"WHERE RI.ri_status = '예매' AND LEFT(RI.ri_date, 10) BETWEEN '" + nowDate.minusDays(7) + "' AND '" + nowDate + "' " + 
				"GROUP BY BL.bl_idx, BL.bl_type, SBT.bt_name, EBT.bt_name " + 
				"ORDER BY BL.bl_idx ";
		System.out.println(sql);
		List<SalesInfo> salesList = jdbc.query(sql, (ResultSet rs, int rowNum) -> {
			SalesInfo sl = new SalesInfo();
			sl.setBl_type(rs.getString("bl_type"));
			sl.setStart_spot(rs.getString("start_terminal"));
			sl.setEnd_spot(rs.getString("end_terminal"));
			sl.setCount_schedule(rs.getInt("num_of_trips"));
			sl.setCardP(rs.getInt("card_sales"));
			sl.setBankP(rs.getInt("bank_sales"));
			sl.setEasyP(rs.getInt("mobile_sales"));
			return sl;
		});
		
		return salesList;
		
	}
	
	public List<PaymoneyInfo> getPaymoneyList(String where) {
	      String sql = "select mph_idx, mi_id, mph_payment, mph_real_price, mph_pmoney, replace(left(mph_date, 16), '-', '.') wdate " +
	            " from t_member_pmoney_history " + where;
	      
	      
	      List<PaymoneyInfo> paymoneyList = jdbc.query(sql, (ResultSet rs, int rowNum) -> {
	         PaymoneyInfo pi = new PaymoneyInfo(rs.getInt("mph_idx"), rs.getInt("mph_real_price"), rs.getInt("mph_pmoney"), 
	               rs.getString("mi_id"), rs.getString("mph_payment"), rs.getString("wdate"));
	         return pi;
	      });
	      return paymoneyList;
	}
	
	

	
}
