package dao;

import java.util.*;
import java.sql.*;
import javax.sql.*;

import org.omg.PortableInterceptor.SYSTEM_EXCEPTION;
import org.springframework.jdbc.core.*;
import org.springframework.jdbc.support.*;
import vo.*;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

public class IndexDao {
   private JdbcTemplate jdbc;
   public IndexDao(DataSource dataSource) {
      this.jdbc = new JdbcTemplate(dataSource);
   }
   public List<String> getSales() {
      String sql = "SELECT 1, concat(count(ri_idx), \":\",  IFNULL(SUM(cr_pmoney + cr_pay), 0)) sales FROM t_count_rinfo WHERE LEFT(cr_date, 10) = adddate(curdate(), -1) " + 
            "UNION " + 
            "SELECT 2, concat(count(ri_idx), \":\",  IFNULL(SUM(cr_pmoney + cr_pay), 0)) sales FROM t_count_rinfo WHERE LEFT(cr_date, 10) >= adddate(curdate(), -7) " + 
            "UNION " + 
            "SELECT 3, concat(count(ri_idx), \":\",  IFNULL(SUM(cr_pmoney + cr_pay), 0)) sales FROM t_count_rinfo WHERE MID(cr_date, 6, 2) = MID(curdate(), 6, 2) " + 
            "UNION " + 
            "SELECT 4, concat(count(ri_idx), \":\",  IFNULL(SUM(cr_pmoney + cr_pay), 0)) sales FROM t_count_rinfo WHERE LEFT(cr_date, 4) = LEFT(curdate(), 4)";
      List<String> salesList = jdbc.query(sql, (ResultSet rs, int rowNum) -> {
         return rs.getString("sales");
      });
      
      return salesList;
   }
   public String getTopLine(String linetype) throws JsonProcessingException {
      String sql = "SELECT CONCAT(SBT.bt_name, \"-\" ,EBT.bt_name) bus_line, SUM(ri_acnt + ri_scnt + ri_ccnt) reserved_seats " + 
            "FROM t_reservation_info RI, T_BUS_SCHEDULE BS, T_BUS_LINE BL, T_BUS_TERMINAL SBT, T_BUS_TERMINAL EBT " + 
            "WHERE RI.bs_idx = BS.bs_idx AND BS.bl_idx = BL.bl_idx AND BL.bt_sidx = SBT.bt_idx AND BL.bt_eidx = EBT.bt_idx AND " +
            "BL.bl_type = '" + linetype + "' AND LEFT(RI.ri_date, 7) = LEFT(curdate(), 7) " + 
            "GROUP BY SBT.bt_name, EBT.bt_name " + 
            "ORDER BY reserved_seats desc " + 
            "LIMIT 0, 4";
      List<HashMap<String, Object>> topLineList = jdbc.query(
            sql, new RowMapper<HashMap<String, Object>>() {
               @Override
               public HashMap<String, Object> mapRow(ResultSet rs, int rowNum) throws SQLException {
                  HashMap<String, Object> tli = new HashMap<String, Object>();
                  tli.put("bus_line", rs.getString("bus_line"));
                  tli.put("reserved_seats", rs.getInt("reserved_seats"));
                  
                  return tli;
               }
            }
         );
      // ObjectMapper를 사용하여 List를 JSON 문자열로 변환
      ObjectMapper objectMapper = new ObjectMapper();
      String json = objectMapper.writeValueAsString(topLineList);

      return json;
   }
	public List<String> getSalesByQuarter(int i, String linetype) {
		String yearWhere = " AND YEAR(CR.cr_date) = LEFT(curdate(), 4) ";
		if (i == -1) {
			yearWhere = " AND YEAR(CR.cr_date) = LEFT(curdate(), 4) - 1 ";
		}
		String sql = "SELECT 1, IFNULL(SUM(CR.cr_pmoney + CR.cr_pay), 0) sales " + 
				"FROM T_COUNT_RINFO CR, T_RESERVATION_INFO RI, T_BUS_SCHEDULE BS, T_BUS_LINE BL " + 
				"WHERE CR.ri_idx = RI.ri_idx AND RI.bs_idx = BS.bs_idx AND BS.bl_idx = BL.bl_idx AND BL.bl_type = '" + linetype + "' " + yearWhere + " AND QUARTER(CR.cr_date) = 1 " + 
				"UNION " + 
				"SELECT 2, IFNULL(SUM(CR.cr_pmoney + CR.cr_pay), 0) sales " + 
				"FROM T_COUNT_RINFO CR, T_RESERVATION_INFO RI, T_BUS_SCHEDULE BS, T_BUS_LINE BL " + 
				"WHERE CR.ri_idx = RI.ri_idx AND RI.bs_idx = BS.bs_idx AND BS.bl_idx = BL.bl_idx AND BL.bl_type = '" + linetype + "' " + yearWhere + " AND QUARTER(CR.cr_date) = 2 " + 
				"UNION " + 
				"SELECT 3, IFNULL(SUM(CR.cr_pmoney + CR.cr_pay), 0) sales " + 
				"FROM T_COUNT_RINFO CR, T_RESERVATION_INFO RI, T_BUS_SCHEDULE BS, T_BUS_LINE BL " + 
				"WHERE CR.ri_idx = RI.ri_idx AND RI.bs_idx = BS.bs_idx AND BS.bl_idx = BL.bl_idx AND BL.bl_type = '" + linetype + "' " + yearWhere + " AND QUARTER(CR.cr_date) = 3 " + 
				"UNION " + 
				"SELECT 4, IFNULL(SUM(CR.cr_pmoney + CR.cr_pay), 0) sales " + 
				"FROM T_COUNT_RINFO CR, T_RESERVATION_INFO RI, T_BUS_SCHEDULE BS, T_BUS_LINE BL " + 
				"WHERE CR.ri_idx = RI.ri_idx AND RI.bs_idx = BS.bs_idx AND BS.bl_idx = BL.bl_idx AND BL.bl_type = '" + linetype + "' " + yearWhere + " AND QUARTER(CR.cr_date) = 4";
		List<String> salesQuarterList = jdbc.query(sql, (ResultSet rs, int rowNum) -> {
	        return rs.getString("sales");
	     });
	     
	     return salesQuarterList;
	}
}