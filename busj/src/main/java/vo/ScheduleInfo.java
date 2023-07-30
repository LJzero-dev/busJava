package vo;

public class ScheduleInfo {
	private int bs_idx,	bl_idx,	bi_idx;
	private String bs_stime, bs_etime, bs_date;
	
	// 2단계 화면에서 보여주기위한 필드 추가
	private int bl_adult, total_seat, left_seat;
	private String comname, bi_level; 

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
	public int getBl_adult() {
		return bl_adult;
	}
	public void setBl_adult(int bl_adult) {
		this.bl_adult = bl_adult;
	}
	public int getTotal_seat() {
		return total_seat;
	}
	public void setTotal_seat(int total_seat) {
		this.total_seat = total_seat;
	}
	public int getLeft_seat() {
		return left_seat;
	}
	public void setLeft_seat(int left_seat) {
		this.left_seat = left_seat;
	}
	public String getComname() {
		return comname;
	}
	public void setComname(String comname) {
		this.comname = comname;
	}
	public String getBi_level() {
		return bi_level;
	}
	public void setBi_level(String bi_level) {
		this.bi_level = bi_level;
	}
	
	
}
