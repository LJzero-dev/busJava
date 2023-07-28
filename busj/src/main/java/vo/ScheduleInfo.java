package vo;

public class ScheduleInfo {
	private int bs_idx,	bl_idx,	bi_idx;
	private String bs_stime, bs_etime, bs_date;
	private int level, company, aprice, aseat, lseat;	// 버스등급, 버스회사, 어른금액, 전체좌석, 예매가능좌석(live-seat)
	public int getBs_idx() {
		return bs_idx;
	}
	public void setBs_idx(int bs_idx) {
		this.bs_idx = bs_idx;
	}
	public int getBl_idx() {
		return bl_idx;
	}
	public void setBl_idx(int bl_idx) {
		this.bl_idx = bl_idx;
	}
	public int getBi_idx() {
		return bi_idx;
	}
	public void setBi_idx(int bi_idx) {
		this.bi_idx = bi_idx;
	}
	public String getBs_stime() {
		return bs_stime;
	}
	public void setBs_stime(String bs_stime) {
		this.bs_stime = bs_stime;
	}
	public String getBs_etime() {
		return bs_etime;
	}
	public void setBs_etime(String bs_etime) {
		this.bs_etime = bs_etime;
	}
	public String getBs_date() {
		return bs_date;
	}
	public void setBs_date(String bs_date) {
		this.bs_date = bs_date;
	}
	
}
