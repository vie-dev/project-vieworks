package kr.co.passcombine.mes.vo;

import java.io.Serializable;
import java.util.HashMap;
import java.util.Map;

public class SYDmrMasterVo implements Serializable{
	private String gr_no;
	private String gr_seq;
	private String gr_nm;
	private String dept_cd;
	private String change_date;
	private String confirm_date;
	private String change_remark;
	private String change_memo;
	private String special_note;
	private String ecr_no;
	private String rn_no;
	private String dmr_no;
	private String apply_yn;
	private String creator;
	private String updater;
	private String date_created;
	private String date_updated;
	private String werks;
	private String aennr;
	private String aetxt;
	private String datuv;
	private String aegru;
	private String ltext;
	private String werks_nm;
	private String matnr;
	private String use_yn;
	 
	
	 
	public String getWerks_nm() {
		return werks_nm;
	}
	public void setWerks_nm(String werks_nm) {
		this.werks_nm = werks_nm;
	}
	public String getLtext() {
		return ltext;
	}
	public void setLtext(String ltext) {
		this.ltext = ltext;
	}
	public String getAennr() {
		return aennr;
	}
	public void setAennr(String aennr) {
		this.aennr = aennr;
	}
	public String getAetxt() {
		return aetxt;
	}
	public void setAetxt(String aetxt) {
		this.aetxt = aetxt;
	}
	public String getDatuv() {
		return datuv;
	}
	public void setDatuv(String datuv) {
		this.datuv = datuv;
	}
	public String getAegru() {
		return aegru;
	}
	public void setAegru(String aegru) {
		this.aegru = aegru;
	}
 
	public String getWerks() {
		return werks;
	}
	public void setWerks(String werks) {
		this.werks = werks;
	}
	private String ukey;
	
	public String getUkey() {
		return ukey;
	}
	public void setUkey(String ukey) {
		this.ukey = ukey;
	}
	public String getGr_no() {
		return gr_no;
	}
	public void setGr_no(String gr_no) {
		this.gr_no = gr_no;
	}
	public String getGr_seq() {
		return gr_seq;
	}
	public void setGr_seq(String gr_seq) {
		this.gr_seq = gr_seq;
	}
	public String getGr_nm() {
		return gr_nm;
	}
	public void setGr_nm(String gr_nm) {
		this.gr_nm = gr_nm;
	}
	public String getDept_cd() {
		return dept_cd;
	}
	public void setDept_cd(String dept_cd) {
		this.dept_cd = dept_cd;
	}
	public String getChange_date() {
		return change_date;
	}
	public void setChange_date(String change_date) {
		this.change_date = change_date;
	}
	public String getConfirm_date() {
		return confirm_date;
	}
	public void setConfirm_date(String confirm_date) {
		this.confirm_date = confirm_date;
	}
	public String getChange_remark() {
		return change_remark;
	}
	public void setChange_remark(String change_remark) {
		this.change_remark = change_remark;
	}
	public String getChange_memo() {
		return change_memo;
	}
	public void setChange_memo(String change_memo) {
		this.change_memo = change_memo;
	}
	public String getSpecial_note() {
		return special_note;
	}
	public void setSpecial_note(String special_note) {
		this.special_note = special_note;
	}
	public String getEcr_no() {
		return ecr_no;
	}
	public void setEcr_no(String ecr_no) {
		this.ecr_no = ecr_no;
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
	public String getApply_yn() {
		return apply_yn;
	}
	public void setApply_yn(String apply_yn) {
		this.apply_yn = apply_yn;
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
	public String getMatnr() {
		return matnr;
	}
	public void setMatnr(String matnr) {
		this.matnr = matnr;
	}
	public String getUse_yn() {
		return use_yn;
	}
	public void setUse_yn(String use_yn) {
		this.use_yn = use_yn;
	}
	@Override
	public String toString() {
		return "SYDmrMasterVo [gr_no=" + gr_no + ", gr_seq=" + gr_seq
				+ ", gr_nm=" + gr_nm + ", dept_cd=" + dept_cd
				+ ", change_date=" + change_date + ", confirm_date="
				+ confirm_date + ", change_remark=" + change_remark
				+ ", change_memo=" + change_memo + ", special_note="
				+ special_note + ", ecr_no=" + ecr_no + ", rn_no=" + rn_no
				+ ", dmr_no=" + dmr_no + ", apply_yn=" + apply_yn
				+ ", creator=" + creator + ", updater=" + updater
				+ ", date_created=" + date_created + ", date_updated="
				+ date_updated + ", werks=" + werks + ", aennr=" + aennr
				+ ", aetxt=" + aetxt + ", datuv=" + datuv + ", aegru=" + aegru
				+ ", ltext=" + ltext + ", ukey=" + ukey + "]";
	}
}
