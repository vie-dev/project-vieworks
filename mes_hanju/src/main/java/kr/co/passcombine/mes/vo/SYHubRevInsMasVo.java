package kr.co.passcombine.mes.vo;

import java.io.Serializable;

public class SYHubRevInsMasVo implements Serializable{
	// table column name
	// master
	private String rvmaster_gr_code;	//Key	그룹코드
	private String gr_name;		//그룹명
	private String gr_dscr;		//그룹dscr
	private String dept_cd;		//플랜트
	private String temp1;		//예비
	private String temp2;		//예비
	private String temp3;		//예비
	private String temp4;		//예비
	private String use_yn;		//사용유무
	private String creator;		//작성자
	private String updater;		//수정자
	private String date_created;		//생성일자
	private String date_updated;		//수정일자

	// params name
	private String comp_kind;	// 부품 종류  
	private String vendor;		// vendor code
	public String getRvmaster_gr_code() {
		return rvmaster_gr_code;
	}
	public void setRvmaster_gr_code(String rvmaster_gr_code) {
		this.rvmaster_gr_code = rvmaster_gr_code;
	}
	public String getGr_name() {
		return gr_name;
	}
	public void setGr_name(String gr_name) {
		this.gr_name = gr_name;
	}
	public String getGr_dscr() {
		return gr_dscr;
	}
	public void setGr_dscr(String gr_dscr) {
		this.gr_dscr = gr_dscr;
	}
	public String getDept_cd() {
		return dept_cd;
	}
	public void setDept_cd(String dept_cd) {
		this.dept_cd = dept_cd;
	}
	public String getTemp1() {
		return temp1;
	}
	public void setTemp1(String temp1) {
		this.temp1 = temp1;
	}
	public String getTemp2() {
		return temp2;
	}
	public void setTemp2(String temp2) {
		this.temp2 = temp2;
	}
	public String getTemp3() {
		return temp3;
	}
	public void setTemp3(String temp3) {
		this.temp3 = temp3;
	}
	public String getTemp4() {
		return temp4;
	}
	public void setTemp4(String temp4) {
		this.temp4 = temp4;
	}
	public String getUse_yn() {
		return use_yn;
	}
	public void setUse_yn(String use_yn) {
		this.use_yn = use_yn;
	}
	public String getCreator() {
		return creator;
	}
	public void setCreator(String creator) {
		this.creator = creator;
	}
	public String getUpdater() {
		return updater;
	}
	public void setUpdater(String updater) {
		this.updater = updater;
	}
	public String getDate_created() {
		return date_created;
	}
	public void setDate_created(String date_created) {
		this.date_created = date_created;
	}
	public String getDate_updated() {
		return date_updated;
	}
	public void setDate_updated(String date_updated) {
		this.date_updated = date_updated;
	}
	public String getComp_kind() {
		return comp_kind;
	}
	public void setComp_kind(String comp_kind) {
		this.comp_kind = comp_kind;
	}
	public String getVendor() {
		return vendor;
	}
	public void setVendor(String vendor) {
		this.vendor = vendor;
	}
	@Override
	public String toString() {
		return "SYHubRevInsMasVo [rvmaster_gr_code=" + rvmaster_gr_code
				+ ", gr_name=" + gr_name + ", gr_dscr=" + gr_dscr
				+ ", dept_cd=" + dept_cd + ", temp1=" + temp1 + ", temp2="
				+ temp2 + ", temp3=" + temp3 + ", temp4=" + temp4 + ", use_yn="
				+ use_yn + ", creator=" + creator + ", updater=" + updater
				+ ", date_created=" + date_created + ", date_updated="
				+ date_updated + ", comp_kind=" + comp_kind + ", vendor="
				+ vendor + "]";
	}
}
