package vo;

public class PaymoneyInfo {
	private int mph_idx, mph_real_price, mph_pmoney;
	private String mi_id, mph_payment, mph_date;
	
	public PaymoneyInfo(int mph_idx, int mph_real_price, int mph_pmoney, String mi_id, String mph_payment,
			String mph_date) {
		super();
		this.mph_idx = mph_idx;
		this.mph_real_price = mph_real_price;
		this.mph_pmoney = mph_pmoney;
		this.mi_id = mi_id;
		this.mph_payment = mph_payment;
		this.mph_date = mph_date;
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

	public int getMph_pmoney() {
		return mph_pmoney;
	}

	public void setMph_pmoney(int mph_pmoney) {
		this.mph_pmoney = mph_pmoney;
	}

	public String getMi_id() {
		return mi_id;
	}

	public void setMi_id(String mi_id) {
		this.mi_id = mi_id;
	}

	public String getMph_payment() {
		return mph_payment;
	}

	public void setMph_payment(String mph_payment) {
		this.mph_payment = mph_payment;
	}

	public String getMph_date() {
		return mph_date;
	}

	public void setMph_date(String mph_date) {
		this.mph_date = mph_date;
	}
	
	
	
	
	
}
