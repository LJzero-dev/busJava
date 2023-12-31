package vo;

public class ReservationInfo {
	private int	ri_idx,	bs_idx,	ri_acnt, ri_scnt, ri_ccnt;
	private String mi_id, ri_sday, ri_status, ri_date, ri_type, si_idx;
	private String mode, sdate, sspot, espot, stime, etime, comname, level, seat, payment;	// 왕복편도 구분, 탑승일, 출발장소, 도착장소, 출발, 도착시간, 버스회사, 버스등급, seat 목록, 결제방식
	private int linenum, price, basePrice;	// 노선번호, 어른가격, 가는 날 총금액
	public int getRi_idx() {
		return ri_idx;
	}
	public void setRi_idx(int ri_idx) {
		this.ri_idx = ri_idx;
	}
	public int getBs_idx() {
		return bs_idx;
	}
	public void setBs_idx(int bs_idx) {
		this.bs_idx = bs_idx;
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
	public String getSi_idx() {
		return si_idx;
	}
	public void setSi_idx(String si_idx) {
		this.si_idx = si_idx;
	}
	public String getMi_id() {
		return mi_id;
	}
	public void setMi_id(String mi_id) {
		this.mi_id = mi_id;
	}
	public String getRi_sday() {
		return ri_sday;
	}
	public void setRi_sday(String ri_sday) {
		this.ri_sday = ri_sday;
	}
	public String getRi_status() {
		return ri_status;
	}
	public void setRi_status(String ri_status) {
		this.ri_status = ri_status;
	}
	public String getRi_date() {
		return ri_date;
	}
	public void setRi_date(String ri_date) {
		this.ri_date = ri_date;
	}
	public String getRi_type() {
		return ri_type;
	}
	public void setRi_type(String ri_type) {
		this.ri_type = ri_type;
	}
	public String getMode() {
		return mode;
	}
	public void setMode(String mode) {
		this.mode = mode;
	}
	public String getSdate() {
		return sdate;
	}
	public void setSdate(String sdate) {
		this.sdate = sdate;
	}
	public String getSspot() {
		return sspot;
	}
	public void setSspot(String sspot) {
		this.sspot = sspot;
	}
	public String getEspot() {
		return espot;
	}
	public void setEspot(String espot) {
		this.espot = espot;
	}
	public String getStime() {
		return stime;
	}
	public void setStime(String stime) {
		this.stime = stime;
	}
	public String getEtime() {
		return etime;
	}
	public void setEtime(String etime) {
		this.etime = etime;
	}
	public String getComname() {
		return comname;
	}
	public void setComname(String comname) {
		this.comname = comname;
	}
	public String getLevel() {
		return level;
	}
	public void setLevel(String level) {
		this.level = level;
	}
	public String getSeat() {
		return seat;
	}
	public void setSeat(String seat) {
		this.seat = seat;
	}
	public int getLinenum() {
		return linenum;
	}
	public void setLinenum(int linenum) {
		this.linenum = linenum;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getPayment() {
		return payment;
	}
	public void setPayment(String payment) {
		this.payment = payment;
	}
	public int getBasePrice() {
		return basePrice;
	}
	public void setBasePrice(int basePrice) {
		this.basePrice = basePrice;
	}

	
}
