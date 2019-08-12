package kr.co.passcombine.mes.vo;

import java.io.Serializable;
import kr.co.passcombine.mes.util.SessionUtil;

public class SYSelfInspHeaderVo implements Serializable{
	private String pordno;
	private String simaster_gr_no;	//	'마스터 GR 코드',
	private String siheader_seq;	// 	'SEQ',
	private String siheader_code;	//	
	private String dept_cd;	//	'사업부코드',
	private String display_seq;	//	'display순서',
	private String main_name;	//	'메인 name',
	private String sub_name;	//	'중간 name',
	private String item_value;	//	'input 값',
	private String rn_no;	//	'rn 번호',
	private String dmr_no;	//	'dmr 번호',
	private String sernp;	//	'set s/n(광영상)',
	private String doc_no;	//	'문서번호',
	private String use_yn;	//	'\'Y\' 사용 \'N\' 미사용',
	private String creator;	//
	private String updater;	//
	private String date_created;	//
	private String date_updated;	//
	private String confirm_id;	// 확정자 사번
	// master
	private String simaster_gr_nm;
	private String matnr;

	public String getPordno() {
		return pordno;
	}
	public void setPordno(String pordno) {
		this.pordno = pordno;
	}
	public String getSimaster_gr_nm() {
		return simaster_gr_nm;
	}
	public void setSimaster_gr_nm(String simaster_gr_nm) {
		this.simaster_gr_nm = simaster_gr_nm;
	}
	public String getMatnr() {
		return matnr;
	}
	public void setMatnr(String matnr) {
		this.matnr = matnr;
	}
	public String getSimaster_gr_no() {
		return simaster_gr_no;
	}
	public void setSimaster_gr_no(String simaster_gr_no) {
		this.simaster_gr_no = simaster_gr_no;
	}
	public String getSiheader_seq() {
		return siheader_seq;
	}
	public void setSiheader_seq(String siheader_seq) {
		this.siheader_seq = siheader_seq;
	}
	public String getSiheader_code() {
		return siheader_code;
	}
	public void setSiheader_code(String siheader_code) {
		this.siheader_code = siheader_code;
	}
	public String getDept_cd() {
		return dept_cd;
	}
	public void setDept_cd(String dept_cd) {
		this.dept_cd = dept_cd;
	}
	public String getDisplay_seq() {
		return display_seq;
	}
	public void setDisplay_seq(String display_seq) {
		this.display_seq = display_seq;
	}
	public String getMain_name() {
		return main_name;
	}
	public void setMain_name(String main_name) {
		this.main_name = main_name;
	}
	public String getSub_name() {
		return sub_name;
	}
	public void setSub_name(String sub_name) {
		this.sub_name = sub_name;
	}
	public String getItem_value() {
		return item_value;
	}
	public void setItem_value(String item_value) {
		this.item_value = item_value;
	}
	public String getRn_no() {
		return rn_no;
	}
	public void setRn_no(String rn_no) {
		this.rn_no = rn_no;
	}
	public String getDmr_no() {
		return dmr_no;
	}
	public void setDmr_no(String dmr_no) {
		this.dmr_no = dmr_no;
	}
	public String getSernp() {
		return sernp;
	}
	public void setSernp(String sernp) {
		this.sernp = sernp;
	}
	public String getDoc_no() {
		return doc_no;
	}
	public void setDoc_no(String doc_no) {
		this.doc_no = doc_no;
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
	public String getConfirm_id() {
		return confirm_id;
	}
	public void setConfirm_id(String confirm_id) {
		this.confirm_id = confirm_id;
	}
	@Override
	public String toString() {
		return "SYSelfInspHeaderVo [pordno=" + pordno + ", simaster_gr_no="
				+ simaster_gr_no + ", siheader_seq=" + siheader_seq
				+ ", siheader_code=" + siheader_code + ", dept_cd=" + dept_cd
				+ ", display_seq=" + display_seq + ", main_name=" + main_name
				+ ", sub_name=" + sub_name + ", item_value=" + item_value
				+ ", rn_no=" + rn_no + ", dmr_no=" + dmr_no + ", sernp="
				+ sernp + ", doc_no=" + doc_no + ", use_yn=" + use_yn
				+ ", creator=" + creator + ", updater=" + updater
				+ ", date_created=" + date_created + ", date_updated="
				+ date_updated + ", confirm_id=" + confirm_id
				+ ", simaster_gr_nm=" + simaster_gr_nm + ", matnr=" + matnr
				+ "]";
	}
}
