package vo;

public class LineInfo {
// 버스노선의 정보를 담은 인스턴스 (+ 출도착지의 이름 : sname, ename / + 출도착지의 지역 : sarea, earea)
	private int bl_idx, bt_sidx, bt_eidx, bl_adult;
	private String sname, ename, sarea, earea, bl_type, bl_status;
	public LineInfo(int bl_idx, int bt_sidx, String sname, String sarea, int bt_eidx, String ename, String earea,
			int bl_adult, String bl_type, String bl_status) {
		this.bl_idx = bl_idx;
		this.bt_sidx = bt_sidx;
		this.sname = sname;
		this.sarea = sarea;
		this.bt_eidx = bt_eidx;
		this.ename = ename;
		this.earea = earea;
		this.bl_adult = bl_adult;
		this.bl_type = bl_type;
		this.bl_status = bl_status;
	}
	public int getBl_idx() {
		return bl_idx;
	}
	public void setBl_idx(int bl_idx) {
		this.bl_idx = bl_idx;
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
	public int getBl_adult() {
		return bl_adult;
	}
	public void setBl_adult(int bl_adult) {
		this.bl_adult = bl_adult;
	}
	public String getSname() {
		return sname;
	}
	public void setSname(String sname) {
		this.sname = sname;
	}
	public String getEname() {
		return ename;
	}
	public void setEname(String ename) {
		this.ename = ename;
	}
	public String getSarea() {
		return sarea;
	}
	public void setSarea(String sarea) {
		this.sarea = sarea;
	}
	public String getEarea() {
		return earea;
	}
	public void setEarea(String earea) {
		this.earea = earea;
	}
	public String getBl_type() {
		return bl_type;
	}
	public void setBl_type(String bl_type) {
		this.bl_type = bl_type;
	}
	public String getBl_status() {
		return bl_status;
	}
	public void setBl_status(String bl_status) {
		this.bl_status = bl_status;
	}
	
	
	
	
}
