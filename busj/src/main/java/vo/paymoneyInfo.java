package vo;

import java.sql.ResultSet;
import java.util.List;

public class paymoneyInfo {
	private String bt_sidx, bt_eidx, mph_date, cr_date, ri_idx, bl_type, mph_payment;
	private int mi_pmoney, mph_pmoney, cr_pmoney, total_cr_pmoney, mph_idx, mph_real_price;

	
	public paymoneyInfo(String mph_date, String mph_payment, int mph_pmoney, int mph_idx, int mph_real_price) {
		super();
		this.mph_date = mph_date;
		this.mph_payment = mph_payment;
		this.mph_pmoney = mph_pmoney;
		this.mph_idx = mph_idx;
		this.mph_real_price = mph_real_price;
	}

	public paymoneyInfo(String bt_sidx, String bt_eidx, String cr_date, String ri_idx, String bl_type,
			int total_cr_pmoney) {
		super();
		this.bt_sidx = bt_sidx;
		this.bt_eidx = bt_eidx;
		this.cr_date = cr_date;
		this.ri_idx = ri_idx;
		this.bl_type = bl_type;
		this.total_cr_pmoney = total_cr_pmoney;
	}
	

	public String getMph_payment() {
		return mph_payment;
	}

	public void setMph_payment(String mph_payment) {
		this.mph_payment = mph_payment;
	}

	public int getMph_idx() {
		return mph_idx;
	}

	public void setMph_idx(int mph_idx) {
		this.mph_idx = mph_idx;
	}

	public int getMph_real_price() {
		return mph_real_price;
	}

	public void setMph_real_price(int mph_real_price) {
		this.mph_real_price = mph_real_price;
	}

	public String getBt_sidx() {
		return bt_sidx;
	}
	public void setBt_sidx(String bt_sidx) {
		this.bt_sidx = bt_sidx;
	}
	public String getBt_eidx() {
		return bt_eidx;
	}
	public void setBt_eidx(String bt_eidx) {
		this.bt_eidx = bt_eidx;
	}
	public String getMph_date() {
		return mph_date;
	}
	public void setMph_date(String mph_date) {
		this.mph_date = mph_date;
	}
	public String getCr_date() {
		return cr_date;
	}
	public void setCr_date(String cr_date) {
		this.cr_date = cr_date;
	}
	public String getRi_idx() {
		return ri_idx;
	}
	public void setRi_idx(String ri_idx) {
		this.ri_idx = ri_idx;
	}
	public String getBl_type() {
		return bl_type;
	}
	public void setBl_type(String bl_type) {
		this.bl_type = bl_type;
	}
	public int getMi_pmoney() {
		return mi_pmoney;
	}
	public void setMi_pmoney(int mi_pmoney) {
		this.mi_pmoney = mi_pmoney;
	}
	public int getMph_pmoney() {
		return mph_pmoney;
	}
	public void setMph_pmoney(int mph_pmoney) {
		this.mph_pmoney = mph_pmoney;
	}
	public int getCr_pmoney() {
		return cr_pmoney;
	}
	public void setCr_pmoney(int cr_pmoney) {
		this.cr_pmoney = cr_pmoney;
	}
	public int getTotal_cr_pmoney() {
		return total_cr_pmoney;
	}
	public void setTotal_cr_pmoney(int total_cr_pmoney) {
		this.total_cr_pmoney = total_cr_pmoney;
	}
	
}


































