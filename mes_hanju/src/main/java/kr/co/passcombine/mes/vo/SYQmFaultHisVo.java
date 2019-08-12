package kr.co.passcombine.mes.vo;

import java.io.Serializable;

public class SYQmFaultHisVo implements Serializable{
	private static final long serialVersionUID = 1L;
	  
	private String fault_no;
	private String fault_no_seq;
	private String fault_status;
	private String matnr;
	private String maktx;
	private String sernr;
	private String meins;
	private String bdmng;
	private String f_lgort;
	private String t_lgort;
	private String issue_code;
	private String issue_memo;
	private String issue_remark;
	private String pordno;
	private String werks;
	private String routing_no;
	private String routing_nm;
	private String f_lgort_nm;
	private String in_gubun;
	private String creator;
	private String updater;
	private String date_created;
	private String date_updated;	
	
	private String f_date;
	private String t_date;
	private String ord_matnr;
	private String ord_maktx;
	private String ord_sernr;
	private String level1_code;
	private String level2_code;
	private String level3_code;
	private String level1_name;
	private String level2_name;
	private String level3_name;
	private String gr_code;
	private String jsonStr;

	
	public String getRouting_nm() {
		return routing_nm;
	}
	public void setRouting_nm(String routing_nm) {
		this.routing_nm = routing_nm;
	}
	public String getF_lgort_nm() {
		return f_lgort_nm;
	}
	public void setF_lgort_nm(String f_lgort_nm) {
		this.f_lgort_nm = f_lgort_nm;
	}
	public String getUpdater() {
		return updater;
	}
	public void setUpdater(String updater) {
		this.updater = updater;
	}
	public String getDate_updated() {
		return date_updated;
	}
	public void setDate_updated(String date_updated) {
		this.date_updated = date_updated;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	public String getJsonStr() {
		return jsonStr;
	}
	public void setJsonStr(String jsonStr) {
		this.jsonStr = jsonStr;
	}
	public String getFault_no() {
		return fault_no;
	}
	public void setFault_no(String fault_no) {
		this.fault_no = fault_no;
	}
	public String getFault_no_seq() {
		return fault_no_seq;
	}
	public void setFault_no_seq(String fault_no_seq) {
		this.fault_no_seq = fault_no_seq;
	}
	public String getFault_status() {
		return fault_status;
	}
	public void setFault_status(String fault_status) {
		this.fault_status = fault_status;
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
	public String getSernr() {
		return sernr;
	}
	public void setSernr(String sernr) {
		this.sernr = sernr;
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
	public String getF_lgort() {
		return f_lgort;
	}
	public void setF_lgort(String f_lgort) {
		this.f_lgort = f_lgort;
	}
	public String getT_lgort() {
		return t_lgort;
	}
	public void setT_lgort(String t_lgort) {
		this.t_lgort = t_lgort;
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
	public String getIssue_remark() {
		return issue_remark;
	}
	public void setIssue_remark(String issue_remark) {
		this.issue_remark = issue_remark;
	}
	public String getPordno() {
		return pordno;
	}
	public void setPordno(String pordno) {
		this.pordno = pordno;
	}
	public String getWerks() {
		return werks;
	}
	public void setWerks(String werks) {
		this.werks = werks;
	}
	public String getRouting_no() {
		return routing_no;
	}
	public void setRouting_no(String routing_no) {
		this.routing_no = routing_no;
	}
	public String getIn_gubun() {
		return in_gubun;
	}
	public void setIn_gubun(String in_gubun) {
		this.in_gubun = in_gubun;
	}
	public String getCreator() {
		return creator;
	}
	public void setCreator(String creator) {
		this.creator = creator;
	}
	public String getDate_created() {
		return date_created;
	}
	public void setDate_created(String date_created) {
		this.date_created = date_created;
	}
	public String getF_date() {
		return f_date;
	}
	public void setF_date(String f_date) {
		this.f_date = f_date;
	}
	public String getT_date() {
		return t_date;
	}
	public void setT_date(String t_date) {
		this.t_date = t_date;
	}
	public String getOrd_matnr() {
		return ord_matnr;
	}
	public void setOrd_matnr(String ord_matnr) {
		this.ord_matnr = ord_matnr;
	}
	public String getOrd_maktx() {
		return ord_maktx;
	}
	public void setOrd_maktx(String ord_maktx) {
		this.ord_maktx = ord_maktx;
	}
	public String getOrd_sernr() {
		return ord_sernr;
	}
	public void setOrd_sernr(String ord_sernr) {
		this.ord_sernr = ord_sernr;
	}
	public String getLevel1_code() {
		return level1_code;
	}
	public void setLevel1_code(String level1_code) {
		this.level1_code = level1_code;
	}
	public String getLevel2_code() {
		return level2_code;
	}
	public void setLevel2_code(String level2_code) {
		this.level2_code = level2_code;
	}
	public String getLevel3_code() {
		return level3_code;
	}
	public void setLevel3_code(String level3_code) {
		this.level3_code = level3_code;
	}
	public String getLevel1_name() {
		return level1_name;
	}
	public void setLevel1_name(String level1_name) {
		this.level1_name = level1_name;
	}
	public String getLevel2_name() {
		return level2_name;
	}
	public void setLevel2_name(String level2_name) {
		this.level2_name = level2_name;
	}
	public String getLevel3_name() {
		return level3_name;
	}
	public void setLevel3_name(String level3_name) {
		this.level3_name = level3_name;
	}
	public String getGr_code() {
		return gr_code;
	}
	public void setGr_code(String gr_code) {
		this.gr_code = gr_code;
	}
 }
  