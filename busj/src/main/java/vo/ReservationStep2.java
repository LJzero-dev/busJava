package vo;

public class ReservationStep2 {
// 버스예매 2단계 시간표조회 시 필요한 컬럼들
	private int bs_idx, bl_idx, bi_idx, bl_adult, total_seat, left_seat;
	// 시간표 인덱스, 노선번호, 버스번호, 성인요금
	private String bs_stime, bs_etime, bl_type, bc_name, bi_level;
	// 출발시간, 도착시간, 버스구분(고속/시외), 버스회사이름, 버스등급
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
	public String getBl_type() {
		return bl_type;
	}
	public void setBl_type(String bl_type) {
		this.bl_type = bl_type;
	}
	public String getBc_name() {
		return bc_name;
	}
	public void setBc_name(String bc_name) {
		this.bc_name = bc_name;
	}
	public String getBi_level() {
		return bi_level;
	}
	public void setBi_level(String bi_level) {
		this.bi_level = bi_level;
	}
	
}
