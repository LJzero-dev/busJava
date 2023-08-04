package vo;

public class TerminalInfo {
	private int bt_idx;
	private String bt_name, bt_area, bt_type, bt_status;
	public TerminalInfo(int bt_idx, String bt_name, String bt_area, String bt_type, String bt_status) {
		this.bt_idx = bt_idx;
		this.bt_name = bt_name;
		this.bt_area = bt_area;
		this.bt_type = bt_type;
		this.bt_status = bt_status;
	}
	
	public TerminalInfo() {}
	
	public int getBt_idx() {
		return bt_idx;
	}
	public void setBt_idx(int bt_idx) {
		this.bt_idx = bt_idx;
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
	
}
