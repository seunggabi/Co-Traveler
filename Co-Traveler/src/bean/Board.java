package bean;

public class Board implements java.io.Serializable {
	private static final long serialVersionUID = 2193897931951340673L;
	
	private int b_id;
	private String name;
	private String kname;
	private String u_id;
	private String title;
	private String content;
	private String wtime;
	private int cnt;
	private String writer;
	
	public Board(){}
	public Board( String u_id, String name, String title, String content )
	{
		this.u_id = u_id;
		this.name = name;
		this.title = title;
		this.content = content;
	}
	public Board(int b_id, String u_id, String name, String title, String content )
	{
		this.b_id = b_id;
		this.u_id = u_id;
		this.name = name;
		this.title = title;
		this.content = content;
	}
	public Board( int b_id, String name, String u_id, String title,
			String content, String wtime, int cnt)
			{
				this.b_id = b_id;
				this.name = name;
				this.u_id = u_id;
				this.title = title;
				this.content = content;
				this.wtime = wtime;
				this.cnt = cnt;
			}
	
	public int getB_id() {
		return b_id;
	}
	public void setB_id(int b_id) {
		this.b_id = b_id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
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
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getWtime() {
		return wtime;
	}
	public void setWtime(String wtime) {
		this.wtime = wtime;
	}
	public int getCnt() {
		return cnt;
	}
	public void setCnt(int cnt) {
		this.cnt = cnt;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	public String getKname() {
		return kname;
	}
	public void setKname(String kname) {
		this.kname = kname;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	
}
