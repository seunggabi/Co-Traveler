package bean;

public class User implements java.io.Serializable {
	private static final long serialVersionUID = 2193897931951333123L;

	private int u_id;
	private String id;
	private String pw;
	private String name;
	private String email;
	private String tel;
	private String gender;
	private String join_type;
	private String adm;
	private String start;

	// No-arg constructor 가 있어야 한다.
	public User() {
	}
	public User(String id, String name) {
		this.id = id;
		this.name = name;
	}
	public User(int u_id, String join_type, String id, String pw, String name, String email,
			String tel, String gender, String start) {
		super();
		this.u_id = u_id;
		this.join_type = join_type;
		this.id = id;
		this.pw = pw;
		this.name = name;
		this.email = email;
		this.tel = tel;
		this.gender = gender;
		this.start = start;
	}
	public User(int u_id, String join_type, String id, String pw, String name, String email,
			String tel, String gender, String start,  String adm) {
		super();
		this.u_id = u_id;
		this.join_type = join_type;
		this.id = id;
		this.pw = pw;
		this.name = name;
		this.email = email;
		this.tel = tel;
		this.gender = gender;
		this.start = start;
		this.adm = adm;
	}
	public int getU_id() {
		return u_id;
	}
	public void setU_id(int u_id) {
		this.u_id = u_id;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPw() {
		return pw;
	}
	public void setPw(String pw) {
		this.pw = pw;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	public String getJoin_type() {
		return join_type;
	}
	public void setJoin_type(String join_type) {
		this.join_type = join_type;
	}
	public String getStart() {
		return start;
	}
	public void setStart(String start) {
		this.start = start;
	}
	public String getAdm() {
		return adm;
	}
	public void setAdm(String adm) {
		this.adm = adm;
	}	
	public String facebookUserName()
	{
		return "<a href = 'https://www.facebook.com/app_scoped_user_id/"+this.id+"'>"+this.name+"</a>";	
	}
}

