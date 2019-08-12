package kr.co.passcombine.mes.vo;

import java.io.Serializable;
import java.util.ArrayList;

import kr.co.passcombine.mes.util.SessionUtil;

public class SYVendorVo implements Serializable{
//	private String lifnr;
	private String vendor_code;
	private String txt30;
	private String name;
	private String addr;
	private String land1;
	private String telf1;
	private String telf2;
	private String telfx;
	private String smtp_addr;
	private String company_no;
	private String j_1kfrepre;
	private String j_1kftbus;
	private String j_1kftind;
	private String id_yn;
	private String date_created;
	private String date_updated;
	private String creater;
	private String updater;
	
	private ArrayList<String> codeList;
	
	public String getVendor_code() {
		return vendor_code;
	}
	public void setVendor_code(String vendor_code) {
		this.vendor_code = vendor_code;
	}
	public String getTxt30() {
		return txt30;
	}
	public void setTxt30(String txt30) {
		this.txt30 = txt30;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getAddr() {
		return addr;
	}
	public void setAddr(String addr) {
		this.addr = addr;
	}
	public String getLand1() {
		return land1;
	}
	public void setLand1(String land1) {
		this.land1 = land1;
	}
	public String getTelf1() {
		return telf1;
	}
	public void setTelf1(String telf1) {
		this.telf1 = telf1;
	}
	public String getTelf2() {
		return telf2;
	}
	public void setTelf2(String telf2) {
		this.telf2 = telf2;
	}
	public String getTelfx() {
		return telfx;
	}
	public void setTelfx(String telfx) {
		this.telfx = telfx;
	}
	public String getSmtp_addr() {
		return smtp_addr;
	}
	public void setSmtp_addr(String smtp_addr) {
		this.smtp_addr = smtp_addr;
	}
	public String getCompany_no() {
		return company_no;
	}
	public void setCompany_no(String company_no) {
		this.company_no = company_no;
	}
	public String getJ_1kfrepre() {
		return j_1kfrepre;
	}
	public void setJ_1kfrepre(String j_1kfrepre) {
		this.j_1kfrepre = j_1kfrepre;
	}
	public String getJ_1kftbus() {
		return j_1kftbus;
	}
	public void setJ_1kftbus(String j_1kftbus) {
		this.j_1kftbus = j_1kftbus;
	}
	public String getJ_1kftind() {
		return j_1kftind;
	}
	public void setJ_1kftind(String j_1kftind) {
		this.j_1kftind = j_1kftind;
	}
	public String getId_yn() {
		return id_yn;
	}
	public void setId_yn(String id_yn) {
		this.id_yn = id_yn;
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
	public String getCreater() {
		return creater;
	}
	public void setCreater(String creater) {
		this.creater = creater;
	}
	public String getUpdater() {
		return updater;
	}
	public void setUpdater(String updater) {
		this.updater = updater;
	}
	public ArrayList<String> getCodeList() {
		return codeList;
	}
	public void setCodeList(ArrayList<String> codeList) {
		this.codeList = codeList;
	}
	@Override
	public String toString() {
		return "SYVendorVo [vendor_code=" + vendor_code + ", txt30=" + txt30
				+ ", name=" + name + ", addr=" + addr + ", land1=" + land1
				+ ", telf1=" + telf1 + ", telf2=" + telf2 + ", telfx=" + telfx
				+ ", smtp_addr=" + smtp_addr + ", company_no=" + company_no
				+ ", j_1kfrepre=" + j_1kfrepre + ", j_1kftbus=" + j_1kftbus
				+ ", j_1kftind=" + j_1kftind + ", id_yn=" + id_yn
				+ ", date_created=" + date_created + ", date_updated="
				+ date_updated + ", creater=" + creater + ", updater="
				+ updater + ", codeList=" + codeList + "]";
	}
	
	
	/*private String ktokk;
	private String loevm;
	private String name2;
	private String mcod1;
	private String pstlz;
	private String ort01;
	private String regio;
	private String stenr;
	private String erdat;
	private String aedat;
	private String iv_fdate;
	private String iv_tdate;
	
	//vendor 계정 자동생성관련 추가
	private String dept_cd;
	private String params;
	private String member_emp_no;
	private String member_id;
	private String member_email;
	private String member_pwd;
	private String member_nm;
	private String member_nm_en;
	private String company_cd;
	private String init_yn;
	private String pwd_chg_date;
	private String member_lang;
	private String creator;
	private ArrayList<String> list;*/
 
	
}
