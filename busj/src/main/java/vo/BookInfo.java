package vo;

import java.util.List;

public class BookInfo {
	private int ri_acnt, ri_scnt, ri_ccnt, bt_sidx, bt_eidx;
	private String ri_status, ri_sday, bs_stime, bl_type, ri_idx, si_seat;
	private List<BusSeatList> busSeatList;
	
	/* detail 부분 */
	private String cp_payment, cp_date, cr_age, cr_payment, cr_date, bt_name, bt_area, bt_type, bt_status, bi_level, bc_name;
	private int cp_idx, cp_pay,cr_idx, cr_pmoney, cr_coupon, cr_pay, bt_idx, bl_adult;
	
	
	

	public BookInfo(int ri_acnt, int ri_scnt, int ri_ccnt, String ri_status, String ri_sday, String bs_stime,
			String bl_type, String ri_idx, String cr_payment, String cr_date, int bt_sidx, int bt_eidx, String bi_level,
			String bc_name, int cr_pay, List<BusSeatList> busSeatList) {
		super();
		this.ri_acnt = ri_acnt;
		this.ri_scnt = ri_scnt;
		this.ri_ccnt = ri_ccnt;
		this.ri_status = ri_status;
		this.ri_sday = ri_sday;
		this.bs_stime = bs_stime;
		this.bl_type = bl_type;
		this.ri_idx = ri_idx;
		this.cr_payment = cr_payment;
		this.cr_date = cr_date;
		this.bt_sidx = bt_sidx;
		this.bt_eidx = bt_eidx;
		this.bi_level = bi_level;
		this.bc_name = bc_name;
		this.cr_pay = cr_pay;
		this.busSeatList = busSeatList;
	}


	public BookInfo(int ri_acnt, int ri_scnt, int ri_ccnt, int bt_sidx, int bt_eidx, String ri_status, String ri_sday,
			String bs_stime, String bl_type, String ri_idx, List<BusSeatList> busSeatList) {
		super();
		this.ri_acnt = ri_acnt;
		this.ri_scnt = ri_scnt;
		this.ri_ccnt = ri_ccnt;
		this.bt_sidx = bt_sidx;
		this.bt_eidx = bt_eidx;
		this.ri_status = ri_status;
		this.ri_sday = ri_sday;
		this.bs_stime = bs_stime;
		this.bl_type = bl_type;
		this.ri_idx = ri_idx;
		this.busSeatList = busSeatList;
	}

	


	// 디폴트 생성자 : 위에 있는 getter 와 setter 를 전부 다 사용하면 괜찮지만 그 중 몇가지만 가져온다면 생성자는 필수요소 
	public List<BusSeatList> getBusSeatList() {
		return busSeatList;
	}
	

	public void setBusSeatList(List<BusSeatList> busSeatList) {
		this.busSeatList = busSeatList;
	}
	
	public String getRi_idx() {
		return ri_idx;
	}
	public void setRi_idx(String ri_idx) {
		this.ri_idx = ri_idx;
	}
	public int getRi_acnt() {
		return ri_acnt;
	}
	public void setRi_acnt(int ri_acnt) {
		this.ri_acnt = ri_acnt;
	}
	public int getRi_scnt() {
		return ri_scnt;
	}
	public void setRi_scnt(int ri_scnt) {
		this.ri_scnt = ri_scnt;
	}
	public int getRi_ccnt() {
		return ri_ccnt;
	}
	public void setRi_ccnt(int ri_ccnt) {
		this.ri_ccnt = ri_ccnt;
	}
	public int getBt_sidx() {
		return bt_sidx;
	}
	public void setBt_sidx(int bt_sidx) {
		this.bt_sidx = bt_sidx;
	}
	public int getBt_eidx() {
		return bt_eidx;
	}
	public void setBt_eidx(int bt_eidx) {
		this.bt_eidx = bt_eidx;
	}
	public String getRi_status() {
		return ri_status;
	}
	public void setRi_status(String ri_status) {
		this.ri_status = ri_status;
	}
	public String getRi_sday() {
		return ri_sday;
	}
	public void setRi_sday(String ri_sday) {
		this.ri_sday = ri_sday;
	}
	public String getBs_stime() {
		return bs_stime;
	}
	public void setBs_stime(String bs_stime) {
		this.bs_stime = bs_stime;
	}
	public String getBl_type() {
		return bl_type;
	}
	public void setBl_type(String bl_type) {
		this.bl_type = bl_type;
	}

	public String getSi_seat() {
		return si_seat;
	}

	public void setSi_seat(String si_seat) {
		this.si_seat = si_seat;
	}
	
	/* ================================================================ */
			
	public String getCp_payment() {
		return cp_payment;
	}

	public void setCp_payment(String cp_payment) {
		this.cp_payment = cp_payment;
	}

	public String getCp_date() {
		return cp_date;
	}

	public void setCp_date(String cp_date) {
		this.cp_date = cp_date;
	}

	public String getCr_age() {
		return cr_age;
	}

	public void setCr_age(String cr_age) {
		this.cr_age = cr_age;
	}

	public String getCr_payment() {
		return cr_payment;
	}

	public void setCr_payment(String cr_payment) {
		this.cr_payment = cr_payment;
	}

	public String getCr_date() {
		return cr_date;
	}

	public void setCr_date(String cr_date) {
		this.cr_date = cr_date;
	}

	public String getBt_name() {
		return bt_name;
	}

	public void setBt_name(String bt_name) {
		this.bt_name = bt_name;
	}

	public String getBt_area() {
		return bt_area;
	}

	public void setBt_area(String bt_area) {
		this.bt_area = bt_area;
	}

	public String getBt_type() {
		return bt_type;
	}

	public void setBt_type(String bt_type) {
		this.bt_type = bt_type;
	}

	public String getBt_status() {
		return bt_status;
	}

	public void setBt_status(String bt_status) {
		this.bt_status = bt_status;
	}

	public String getBi_level() {
		return bi_level;
	}

	public void setBi_level(String bi_level) {
		this.bi_level = bi_level;
	}

	public String getBc_name() {
		return bc_name;
	}

	public void setBc_name(String bc_name) {
		this.bc_name = bc_name;
	}

	public int getCp_idx() {
		return cp_idx;
	}

	public void setCp_idx(int cp_idx) {
		this.cp_idx = cp_idx;
	}

	public int getCp_pay() {
		return cp_pay;
	}

	public void setCp_pay(int cp_pay) {
		this.cp_pay = cp_pay;
	}

	public int getCr_idx() {
		return cr_idx;
	}

	public void setCr_idx(int cr_idx) {
		this.cr_idx = cr_idx;
	}

	public int getCr_pmoney() {
		return cr_pmoney;
	}

	public void setCr_pmoney(int cr_pmoney) {
		this.cr_pmoney = cr_pmoney;
	}

	public int getCr_coupon() {
		return cr_coupon;
	}

	public void setCr_coupon(int cr_coupon) {
		this.cr_coupon = cr_coupon;
	}

	public int getCr_pay() {
		return cr_pay;
	}

	public void setCr_pay(int cr_pay) {
		this.cr_pay = cr_pay;
	}

	public int getBt_idx() {
		return bt_idx;
	}

	public void setBt_idx(int bt_idx) {
		this.bt_idx = bt_idx;
	}

	public int getBl_adult() {
		return bl_adult;
	}

	public void setBl_adult(int bl_adult) {
		this.bl_adult = bl_adult;
	}
}
