package dao;

import java.sql.ResultSet;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.jdbc.core.JdbcTemplate;

import vo.*;

public class TravelDao {
	private JdbcTemplate jdbc;
	
	public TravelDao(DataSource dataSource) {
		this.jdbc = new JdbcTemplate(dataSource);
	}

	public int getTraverListCount(String where) {
		String sql = "select count(*) from t_travel_list " + where;
		int rcnt = jdbc.queryForObject(sql, Integer.class);
		return rcnt;
	}

	public List<TravelList> getTravelList(String where, int cpage, int psize) {
		String sql = "select tl_idx, ai_idx, tl_ctgr, tl_area, tl_title, tl_content, tl_img, tl_isview, "+ 
				"if(curdate() = date(tl_date), left(time(tl_date), 5), mid(tl_date, 3, 8)) wdate from t_travel_list " + where + 
				" order by tl_idx desc limit " + ((cpage - 1) * psize) + ", " + psize;
		List<TravelList> travelList = jdbc.query(sql, (ResultSet rs, int rowNum) -> {
			TravelList tl = new TravelList();
			tl.setTl_idx(rs.getInt("tl_idx"));
			tl.setAi_idx(rs.getInt("ai_idx"));
			tl.setTl_ctgr(rs.getString("tl_ctgr"));
			tl.setTl_area(rs.getString("tl_area"));
			tl.setTl_content(rs.getString("tl_content"));
			tl.setTl_img(rs.getString("tl_img"));
			tl.setTl_date(rs.getString("wdate").replace("-", "."));
			
			String title = "";	int cnt = 30;
			if (rs.getString("tl_title").length() > cnt)
				title = rs.getString("tl_title").substring(0, cnt - 3) + "..." + title;
			else
				title = rs.getString("tl_title") + title;
			tl.setTl_title(title);
			
			String isview = "";
			if (rs.getString("tl_isview").equals("y"))	isview = "Y";
			else 										isview = "N";
			tl.setTl_isview(isview);
			
			return tl;
		});
		return travelList;
	}
	
}
