package bean;

public class Trip {
	private static final long serialVersionUID = 2193897931951340675L;
	
	private int t_id;
	private String u_id;
	private String title;
	private String start;
	private String dest;
	private int tripnum;
	private String content;
	private String wdate;
	private String sdate;
	private String edate;
	private String spos_x;
	private String spos_y;
	private String dpos_x;
	private String dpos_y;
	
	public Trip(){}
	public Trip(int t_id, String u_id, String title, String start, String dest, int tripnum, 
			String content, String wdate, String sdate, String edate, String spos_x, String spos_y, String dpos_x, String dpos_y)
	{
		this.t_id = t_id;
		this.u_id = u_id;
		this.title = title;
		this.start = start;
		this.dest = dest;
		this.tripnum = tripnum;
		this.content = content;
		this.wdate = wdate;
		this.sdate = sdate;
		this.edate = edate;
		this.spos_x = spos_x;
		this.spos_y = spos_y;
		this.dpos_x = dpos_x;
		this.dpos_y = dpos_y;
	}
	
	public int getT_id() {
		return t_id;
	}
	public void setT_id(int t_id) {
		this.t_id = t_id;
	}
	public String getU_id() {
		return u_id;
	}
	public void setU_id(String u_id) {
		this.u_id = u_id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getStart() {
		return start;
	}
	public void setStart(String start) {
		this.start = start;
	}
	public String getDest() {
		return dest;
	}
	public void setDest(String dest) {
		this.dest = dest;
	}
	public int getTripnum() {
		return tripnum;
	}
	public void setTripnum(int tripnum) {
		this.tripnum = tripnum;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getWdate() {
		return wdate;
	}
	public void setWdate(String wdate) {
		this.wdate = wdate;
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
	public String getSpos_x() {
		return spos_x;
	}
	public void setSpos_x(String spos_x) {
		this.spos_x = spos_x;
	}
	public String getSpos_y() {
		return spos_y;
	}
	public void setSpos_y(String spos_y) {
		this.spos_y = spos_y;
	}
	public String getdpos_x() {
		return dpos_x;
	}
	public void setdpos_x(String dpos_x) {
		this.dpos_x = dpos_x;
	}
	public String getdpos_y() {
		return dpos_y;
	}
	public void setdpos_y(String dpos_y) {
		this.dpos_y = dpos_y;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
}
