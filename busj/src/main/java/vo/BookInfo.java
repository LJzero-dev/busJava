package vo;

import java.util.List;

public class BookInfo {
	private int ri_acnt, ri_scnt, ri_ccnt, bt_sidx, bt_eidx;
	private String ri_status, ri_sday, bs_stime, bl_type, ri_idx, si_seat;
	private List<BusSeatList> busSeatList;

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
	
}