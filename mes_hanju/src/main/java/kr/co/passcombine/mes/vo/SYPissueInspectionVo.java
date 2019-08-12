package kr.co.passcombine.mes.vo;

import java.io.Serializable;
import java.util.ArrayList;

public class SYPissueInspectionVo implements Serializable{
	
	private static final long serialVersionUID = 1L;
	
	private String inspec_lot;
	private String insts;
	private String routing_no;
	private String org_no;
	private String werks;
	private String t_gubun;
	private String org_issue_code;
	private String org_issue_memo;
	private String org_remark;
	private String issue_code;
	private String issue_memo;
	private String matnr;
	private String maktx;
	private String budat;
	private String lgort;;
	private String meins;
	private String bdmng;
	private String sernp_no;
	private String insp_yn;
	private String mblnr;
	private String mjahr;
	private String s_mblnr;
	private String s_mjahr;
	private String n_mblnr;
	private String n_mjahr;
	private String c_mblnr;
	private String c_mjahr;
	private String cancel_yn;
	private String use_yn;
	private String creator;
	private String updater;
	private String date_created;
	private String date_updated;
	private String pordno;
	private String pdsts;
	
	private String cmdat;
	private String move_stloc;
	private String insts_nm;
	private String werks_nm;
	private String ref_doc_no;
	
	public String getPordno() {
		return pordno;
	}
	public void setPordno(String pordno) {
		this.pordno = pordno;
	}
	public String getPdsts() {
		return pdsts;
	}
	public void setPdsts(String pdsts) {
		this.pdsts = pdsts;
	}
	public String getInsts() {
		return insts;
	}
	public void setInsts(String insts) {
		this.insts = insts;
	}
	public String getInspec_lot() {
		return inspec_lot;
	}
	public void setInspec_lot(String inspec_lot) {
		this.inspec_lot = inspec_lot;
	}
	public String getRouting_no() {
		return routing_no;
	}
	public void setRouting_no(String routing_no) {
		this.routing_no = routing_no;
	}
	public String getOrg_no() {
		return org_no;
	}
	public void setOrg_no(String org_no) {
		this.org_no = org_no;
	}
	public String getT_gubun() {
		return t_gubun;
	}
	public void setT_gubun(String t_gubun) {
		this.t_gubun = t_gubun;
	}
	public String getOrg_issue_code() {
		return org_issue_code;
	}
	public void setOrg_issue_code(String org_issue_code) {
		this.org_issue_code = org_issue_code;
	}
	public String getOrg_issue_memo() {
		return org_issue_memo;
	}
	public void setOrg_issue_memo(String org_issue_memo) {
		this.org_issue_memo = org_issue_memo;
	}
	public String getIssue_code() {
		return issue_code;
	}
	public void setIssue_code(String issue_code) {
		this.issue_code = issue_code;
	}
	public String getIssue_memo() {
		return issue_memo;
	}
	public void setIssue_memo(String issue_memo) {
		this.issue_memo = issue_memo;
	}
	public String getMatnr() {
		return matnr;
	}
	public void setMatnr(String matnr) {
		this.matnr = matnr;
	}
	public String getMaktx() {
		return maktx;
	}
	public void setMaktx(String maktx) {
		this.maktx = maktx;
	}
	public String getMeins() {
		return meins;
	}
	public void setMeins(String meins) {
		this.meins = meins;
	}
	public String getBdmng() {
		return bdmng;
	}
	public void setBdmng(String bdmng) {
		this.bdmng = bdmng;
	}
	public String getSernp_no() {
		return sernp_no;
	}
	public void setSernp_no(String sernp_no) {
		this.sernp_no = sernp_no;
	}
	public String getInsp_yn() {
		return insp_yn;
	}
	public void setInsp_yn(String insp_yn) {
		this.insp_yn = insp_yn;
	}
	public String getMblnr() {
		return mblnr;
	}
	public void setMblnr(String mblnr) {
		this.mblnr = mblnr;
	}
	public String getMjahr() {
		return mjahr;
	}
	public void setMjahr(String mjahr) {
		this.mjahr = mjahr;
	}
	public String getS_mblnr() {
		return s_mblnr;
	}
	public void setS_mblnr(String s_mblnr) {
		this.s_mblnr = s_mblnr;
	}
	public String getS_mjahr() {
		return s_mjahr;
	}
	public void setS_mjahr(String s_mjahr) {
		this.s_mjahr = s_mjahr;
	}
	public String getN_mblnr() {
		return n_mblnr;
	}
	public void setN_mblnr(String n_mblnr) {
		this.n_mblnr = n_mblnr;
	}
	public String getN_mjahr() {
		return n_mjahr;
	}
	public void setN_mjahr(String n_mjahr) {
		this.n_mjahr = n_mjahr;
	}
	public String getC_mblnr() {
		return c_mblnr;
	}
	public void setC_mblnr(String c_mblnr) {
		this.c_mblnr = c_mblnr;
	}
	public String getC_mjahr() {
		return c_mjahr;
	}
	public void setC_mjahr(String c_mjahr) {
		this.c_mjahr = c_mjahr;
	}
	public String getCancel_yn() {
		return cancel_yn;
	}
	public void setCancel_yn(String cancel_yn) {
		this.cancel_yn = cancel_yn;
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
	public String getOrg_remark() {
		return org_remark;
	}
	public void setOrg_remark(String org_remark) {
		this.org_remark = org_remark;
	}
	public String getWerks() {
		return werks;
	}
	public void setWerks(String werks) {
		this.werks = werks;
	}
	public String getBudat() {
		return budat;
	}
	public void setBudat(String budat) {
		this.budat = budat;
	}
	public String getLgort() {
		return lgort;
	}
	public void setLgort(String lgort) {
		this.lgort = lgort;
	}
	public String getCmdat() {
		return cmdat;
	}
	public void setCmdat(String cmdat) {
		this.cmdat = cmdat;
	}
	public String getMove_stloc() {
		return move_stloc;
	}
	public void setMove_stloc(String move_stloc) {
		this.move_stloc = move_stloc;
	}
	public String getInsts_nm() {
		return insts_nm;
	}
	public void setInsts_nm(String insts_nm) {
		this.insts_nm = insts_nm;
	}
	public String getWerks_nm() {
		return werks_nm;
	}
	public void setWerks_nm(String werks_nm) {
		this.werks_nm = werks_nm;
	}
	public String getRef_doc_no() {
		return ref_doc_no;
	}
	public void setRef_doc_no(String ref_doc_no) {
		this.ref_doc_no = ref_doc_no;
	}
	@Override
	public String toString() {
		return "SYPissueInspectionVo [inspec_lot=" + inspec_lot + ", insts="
				+ insts + ", routing_no=" + routing_no + ", org_no=" + org_no
				+ ", werks=" + werks + ", t_gubun=" + t_gubun
				+ ", org_issue_code=" + org_issue_code + ", org_issue_memo="
				+ org_issue_memo + ", org_remark=" + org_remark
				+ ", issue_code=" + issue_code + ", issue_memo=" + issue_memo
				+ ", matnr=" + matnr + ", maktx=" + maktx + ", budat=" + budat
				+ ", lgort=" + lgort + ", meins=" + meins + ", bdmng=" + bdmng
				+ ", sernp_no=" + sernp_no + ", insp_yn=" + insp_yn
				+ ", mblnr=" + mblnr + ", mjahr=" + mjahr + ", s_mblnr="
				+ s_mblnr + ", s_mjahr=" + s_mjahr + ", n_mblnr=" + n_mblnr
				+ ", n_mjahr=" + n_mjahr + ", c_mblnr=" + c_mblnr
				+ ", c_mjahr=" + c_mjahr + ", cancel_yn=" + cancel_yn
				+ ", use_yn=" + use_yn + ", creator=" + creator + ", updater="
				+ updater + ", date_created=" + date_created
				+ ", date_updated=" + date_updated + ", pordno=" + pordno
				+ ", pdsts=" + pdsts + ", cmdat=" + cmdat + ", move_stloc="
				+ move_stloc + ", insts_nm=" + insts_nm + ", werks_nm="
				+ werks_nm + ", ref_doc_no=" + ref_doc_no + "]";
	}
	
	
		
	
}
