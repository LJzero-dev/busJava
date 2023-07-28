package vo;

public class ReservationInfo {
	private int	ri_idx,	bs_idx,	ri_acnt, ri_scnt, ri_ccnt;
	private String mi_id, ri_sday, ri_status, ri_date, ri_type;
	private String mode, sdate, edate, sspot, espot;	// 왕복편도 구분, 출발일, 도착일, 출발장소, 도착장소 ===> 왕복이면 세션2개로 한다
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
	public String getEdate() {
		return edate;
	}
	public void setEdate(String edate) {
		this.edate = edate;
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
	
	
	
}
