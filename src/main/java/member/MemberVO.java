package member;

public class MemberVO {
	private int idx;
	private String mid;
	private String pwd;
	private String nickName;
	private String name;
	private String gender;
	private String birthday;
	private String tel;
	private String address;
	private String email;
	private String content;
	private String photo;
	private int level;
	private String userInfo;
	private String userDel;
	private int point;
	private int visitCnt;
	private int todayCnt;
	private String startDate;
	private String lastDate;
	
	//테이블에 정의하지 않은 필드  VO에 추가하고 게터세터와 toString까지 다시 올려야 사용할 준비가 된다
	private String tempMid; //아이디 중복체크를 위한 임시 아이디. 추가된 필드
	private String tempNickName; //아이디 중복체크를 위한 임시 아이디. 추가된 필드
	private int elapsed_date; //최종접속 경과일(탈퇴시 사용) 숫자로 반환 추가된 필드
	private String strLevel; //회원 등급명 추가된 필드
	
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public String getMid() {
		return mid;
	}
	public void setMid(String mid) {
		this.mid = mid;
	}
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	public String getNickName() {
		return nickName;
	}
	public void setNickName(String nickName) {
		this.nickName = nickName;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getBirthday() {
		return birthday;
	}
	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getPhoto() {
		return photo;
	}
	public void setPhoto(String photo) {
		this.photo = photo;
	}
	public int getLevel() {
		return level;
	}
	public void setLevel(int level) {
		this.level = level;
	}
	public String getUserInfo() {
		return userInfo;
	}
	public void setUserInfo(String userInfo) {
		this.userInfo = userInfo;
	}
	public String getUserDel() {
		return userDel;
	}
	public void setUserDel(String userDel) {
		this.userDel = userDel;
	}
	public int getPoint() {
		return point;
	}
	public void setPoint(int point) {
		this.point = point;
	}
	public int getVisitCnt() {
		return visitCnt;
	}
	public void setVisitCnt(int visitCnt) {
		this.visitCnt = visitCnt;
	}
	public int getTodayCnt() {
		return todayCnt;
	}
	public void setTodayCnt(int todayCnt) {
		this.todayCnt = todayCnt;
	}
	public String getStartDate() {
		return startDate;
	}
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}
	public String getLastDate() {
		return lastDate;
	}
	public void setLastDate(String lastDate) {
		this.lastDate = lastDate;
	}
	public String getTempMid() {
		return tempMid;
	}
	public void setTempMid(String tempMid) {
		this.tempMid = tempMid;
	}
	public String getTempNickName() {
		return tempNickName;
	}
	public void setTempNickName(String tempNickName) {
		this.tempNickName = tempNickName;
	}
	public int getElapsed_date() {
		return elapsed_date;
	}
	public void setElapsed_date(int elapsed_date) {
		this.elapsed_date = elapsed_date;
	}
	public String getStrLevel() {
		return strLevel;
	}
	public void setStrLevel(String strLevel) {
		this.strLevel = strLevel;
	}
	
	//투스트링은 그냥 지우고 새로 만드는게 편하다
	@Override
	public String toString() {
		return "MemberVO [idx=" + idx + ", mid=" + mid + ", pwd=" + pwd + ", nickName=" + nickName + ", name=" + name
				+ ", gender=" + gender + ", birthday=" + birthday + ", tel=" + tel + ", address=" + address + ", email=" + email
				+ ", content=" + content + ", photo=" + photo + ", level=" + level + ", userInfo=" + userInfo + ", userDel="
				+ userDel + ", point=" + point + ", visitCnt=" + visitCnt + ", todayCnt=" + todayCnt + ", startDate="
				+ startDate + ", lastDate=" + lastDate + ", tempMid=" + tempMid + ", tempNickName=" + tempNickName
				+ ", elapsed_date=" + elapsed_date + ", strLevel=" + strLevel + "]";
	}
}
