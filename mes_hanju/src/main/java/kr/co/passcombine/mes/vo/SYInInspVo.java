package kr.co.passcombine.mes.vo;

import java.io.Serializable;

public class SYInInspVo implements Serializable{
	
	private static final long serialVersionUID = 1L;
	
	private String pordno;
	private String ebeln;
	private String ebelp;
	private String partial_seq;
	private String matnr;
	private String rorder_status;
	private String rvendor_status;
	private String confirm_date;
	private String confirm_date_from;
	private String confirm_date_to;
	private String order_delivery_date;
	private String vendor_delivery_date;
	private String menge;
	private String zdeli_menge;
	private String werks;
	private String bukrs;
	private String lgort;
	private String diff_date;
	private String mblnr;
	private String mjahr;
	private String c_mblnr;
	private String c_mjahr;
	private String sap_doc_no;
	private String labnr;
	private String lifnr;
	private String success_yn;
	private String fail_yn;
	private String ref_doc_no;
	private String maktx;		
	private String wrkst;		
	private String meins;		
	private String insp_gubun;		
	private String insp_check_gubun;		
	private String insp_status;		
	private String not_insp_status;		
	private String in_delivery_date;		
	private String in_delivery_date_from;		
	private String in_delivery_date_to;		
	private String in_confirm_date;		
	private String in_confirm_date_from;		
	private String in_confirm_date_to;
	private String in_fail_date;
	private String in_fail_date_from;
	private String in_fail_date_to;
	private String mblnr_cancel;
	private String mjahr_cancel;
	private String in_labnr;
	private String remark;
	
	private String s_mblnr;
	private String s_mjahr;
	
	private String insp_gubun_nm;
	private String insp_check_gubun_nm;
	private String insp_status_nm;
	
	private String name1;
	private String txz01;
	
	private String insp_model;
	private String insp_maql;
	private String insp_vaql; 
	private String insp_doc;
	
	private String insp_ecr;
	private String insp_remark;
	
	public String getInsp_gubun_nm() {
		return insp_gubun_nm;
	}
	public void setInsp_gubun_nm(String insp_gubun_nm) {
		this.insp_gubun_nm = insp_gubun_nm;
	}
	public String getInsp_check_gubun_nm() {
		return insp_check_gubun_nm;
	}
	public void setInsp_check_gubun_nm(String insp_check_gubun_nm) {
		this.insp_check_gubun_nm = insp_check_gubun_nm;
	}
	public String getInsp_status_nm() {
		return insp_status_nm;
	}
	public void setInsp_status_nm(String insp_status_nm) {
		this.insp_status_nm = insp_status_nm;
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
	private int page;
	private int rows;
	  
	private String sidx;
	private String sord;
	
	public String getMblnr_cancel() {
		return mblnr_cancel;
	}
	public void setMblnr_cancel(String mblnr_cancel) {
		this.mblnr_cancel = mblnr_cancel;
	}
	public String getMjahr_cancel() {
		return mjahr_cancel;
	}
	public void setMjahr_cancel(String mjahr_cancel) {
		this.mjahr_cancel = mjahr_cancel;
	}
	public String getIn_labnr() {
		return in_labnr;
	}
	public void setIn_labnr(String in_labnr) {
		this.in_labnr = in_labnr;
	}
	public String getMaktx() {
		return maktx;
	}
	public void setMaktx(String maktx) {
		this.maktx = maktx;
	}
	public String getWrkst() {
		return wrkst;
	}
	public void setWrkst(String wrkst) {
		this.wrkst = wrkst;
	}
	public String getMeins() {
		return meins;
	}
	public void setMeins(String meins) {
		this.meins = meins;
	}
	public String getInsp_gubun() {
		return insp_gubun;
	}
	public void setInsp_gubun(String insp_gubun) {
		this.insp_gubun = insp_gubun;
	}
	public String getInsp_check_gubun() {
		return insp_check_gubun;
	}
	public void setInsp_check_gubun(String insp_check_gubun) {
		this.insp_check_gubun = insp_check_gubun;
	}
	public String getInsp_status() {
		return insp_status;
	}
	public void setInsp_status(String insp_status) {
		this.insp_status = insp_status;
	}
	public String getNot_insp_status() {
		return not_insp_status;
	}
	public void setNot_insp_status(String not_insp_status) {
		this.not_insp_status = not_insp_status;
	}
	public String getIn_delivery_date() {
		return in_delivery_date;
	}
	public void setIn_delivery_date(String in_delivery_date) {
		this.in_delivery_date = in_delivery_date;
	}
	public String getIn_confirm_date() {
		return in_confirm_date;
	}
	public void setIn_confirm_date(String in_confirm_date) {
		this.in_confirm_date = in_confirm_date;
	}
	public String getPordno() {
		return pordno;
	}
	public void setPordno(String pordno) {
		this.pordno = pordno;
	}
	public String getEbeln() {
		return ebeln;
	}
	public void setEbeln(String ebeln) {
		this.ebeln = ebeln;
	}
	public String getEbelp() {
		return ebelp;
	}
	public void setEbelp(String ebelp) {
		this.ebelp = ebelp;
	}
	public String getPartial_seq() {
		return partial_seq;
	}
	public void setPartial_seq(String partial_seq) {
		this.partial_seq = partial_seq;
	}
	public String getMatnr() {
		return matnr;
	}
	public void setMatnr(String matnr) {
		this.matnr = matnr;
	}
	public String getRorder_status() {
		return rorder_status;
	}
	public void setRorder_status(String rorder_status) {
		this.rorder_status = rorder_status;
	}
	public String getRvendor_status() {
		return rvendor_status;
	}
	public void setRvendor_status(String rvendor_status) {
		this.rvendor_status = rvendor_status;
	}
	public String getConfirm_date() {
		return confirm_date;
	}
	public void setConfirm_date(String confirm_date) {
		this.confirm_date = confirm_date;
	}
	public String getOrder_delivery_date() {
		return order_delivery_date;
	}
	public void setOrder_delivery_date(String order_delivery_date) {
		this.order_delivery_date = order_delivery_date;
	}
	public String getVendor_delivery_date() {
		return vendor_delivery_date;
	}
	public void setVendor_delivery_date(String vendor_delivery_date) {
		this.vendor_delivery_date = vendor_delivery_date;
	}
	public String getMenge() {
		return menge;
	}
	public void setMenge(String menge) {
		this.menge = menge;
	}
	public String getZdeli_menge() {
		return zdeli_menge;
	}
	public void setZdeli_menge(String zdeli_menge) {
		this.zdeli_menge = zdeli_menge;
	}
	public String getWerks() {
		return werks;
	}
	public void setWerks(String werks) {
		this.werks = werks;
	}
	public String getBukrs() {
		return bukrs;
	}
	public void setBukrs(String bukrs) {
		this.bukrs = bukrs;
	}
	public String getLgort() {
		return lgort;
	}
	public void setLgort(String lgort) {
		this.lgort = lgort;
	}
	public String getDiff_date() {
		return diff_date;
	}
	public void setDiff_date(String diff_date) {
		this.diff_date = diff_date;
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
	public String getSap_doc_no() {
		return sap_doc_no;
	}
	public void setSap_doc_no(String sap_doc_no) {
		this.sap_doc_no = sap_doc_no;
	}
	public String getLabnr() {
		return labnr;
	}
	public void setLabnr(String labnr) {
		this.labnr = labnr;
	}
	public String getLifnr() {
		return lifnr;
	}
	public void setLifnr(String lifnr) {
		this.lifnr = lifnr;
	}
	public String getSuccess_yn() {
		return success_yn;
	}
	public void setSuccess_yn(String success_yn) {
		this.success_yn = success_yn;
	}
	public String getFail_yn() {
		return fail_yn;
	}
	public void setFail_yn(String fail_yn) {
		this.fail_yn = fail_yn;
	}
	public String getRef_doc_no() {
		return ref_doc_no;
	}
	public void setRef_doc_no(String ref_doc_no) {
		this.ref_doc_no = ref_doc_no;
	}
	public int getPage() {
		return page;
	}
	public void setPage(int page) {
		this.page = page;
	}
	public int getRows() {
		return rows;
	}
	public void setRows(int rows) {
		this.rows = rows;
	}
	public String getSidx() {
		return sidx;
	}
	public void setSidx(String sidx) {
		this.sidx = sidx;
	}
	public String getSord() {
		return sord;
	}
	public void setSord(String sord) {
		this.sord = sord;
	}
	public String getConfirm_date_from() {
		return confirm_date_from;
	}
	public void setConfirm_date_from(String confirm_date_from) {
		this.confirm_date_from = confirm_date_from;
	}
	public String getConfirm_date_to() {
		return confirm_date_to;
	}
	public void setConfirm_date_to(String confirm_date_to) {
		this.confirm_date_to = confirm_date_to;
	}
	public String getIn_delivery_date_from() {
		return in_delivery_date_from;
	}
	public void setIn_delivery_date_from(String in_delivery_date_from) {
		this.in_delivery_date_from = in_delivery_date_from;
	}
	public String getIn_delivery_date_to() {
		return in_delivery_date_to;
	}
	public void setIn_delivery_date_to(String in_delivery_date_to) {
		this.in_delivery_date_to = in_delivery_date_to;
	}
	public String getIn_confirm_date_from() {
		return in_confirm_date_from;
	}
	public void setIn_confirm_date_from(String in_confirm_date_from) {
		this.in_confirm_date_from = in_confirm_date_from;
	}
	public String getIn_confirm_date_to() {
		return in_confirm_date_to;
	}
	public void setIn_confirm_date_to(String in_confirm_date_to) {
		this.in_confirm_date_to = in_confirm_date_to;
	}
	public String getIn_fail_date() {
		return in_fail_date;
	}
	public void setIn_fail_date(String in_fail_date) {
		this.in_fail_date = in_fail_date;
	}
	public String getIn_fail_date_from() {
		return in_fail_date_from;
	}
	public void setIn_fail_date_from(String in_fail_date_from) {
		this.in_fail_date_from = in_fail_date_from;
	}
	public String getIn_fail_date_to() {
		return in_fail_date_to;
	}
	public void setIn_fail_date_to(String in_fail_date_to) {
		this.in_fail_date_to = in_fail_date_to;
	}
	public String getName1() {
		return name1;
	}
	public void setName1(String name1) {
		this.name1 = name1;
	}
	public String getTxz01() {
		return txz01;
	}
	public void setTxz01(String txz01) {
		this.txz01 = txz01;
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
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public String getInsp_model() {
		return insp_model;
	}
	public void setInsp_model(String insp_model) {
		this.insp_model = insp_model;
	}
	public String getInsp_maql() {
		return insp_maql;
	}
	public void setInsp_maql(String insp_maql) {
		this.insp_maql = insp_maql;
	}
	public String getInsp_vaql() {
		return insp_vaql;
	}
	public void setInsp_vaql(String insp_vaql) {
		this.insp_vaql = insp_vaql;
	}
	public String getInsp_doc() {
		return insp_doc;
	}
	public void setInsp_doc(String insp_doc) {
		this.insp_doc = insp_doc;
	}
	public String getInsp_ecr() {
		return insp_ecr;
	}
	public void setInsp_ecr(String insp_ecr) {
		this.insp_ecr = insp_ecr;
	}
	public String getInsp_remark() {
		return insp_remark;
	}
	public void setInsp_remark(String insp_remark) {
		this.insp_remark = insp_remark;
	}
	@Override
	public String toString() {
		return "SYInInspVo [pordno=" + pordno + ", ebeln=" + ebeln + ", ebelp="
				+ ebelp + ", partial_seq=" + partial_seq + ", matnr=" + matnr
				+ ", rorder_status=" + rorder_status + ", rvendor_status="
				+ rvendor_status + ", confirm_date=" + confirm_date
				+ ", confirm_date_from=" + confirm_date_from
				+ ", confirm_date_to=" + confirm_date_to
				+ ", order_delivery_date=" + order_delivery_date
				+ ", vendor_delivery_date=" + vendor_delivery_date + ", menge="
				+ menge + ", zdeli_menge=" + zdeli_menge + ", werks=" + werks
				+ ", bukrs=" + bukrs + ", lgort=" + lgort + ", diff_date="
				+ diff_date + ", mblnr=" + mblnr + ", mjahr=" + mjahr
				+ ", c_mblnr=" + c_mblnr + ", c_mjahr=" + c_mjahr
				+ ", sap_doc_no=" + sap_doc_no + ", labnr=" + labnr
				+ ", lifnr=" + lifnr + ", success_yn=" + success_yn
				+ ", fail_yn=" + fail_yn + ", ref_doc_no=" + ref_doc_no
				+ ", maktx=" + maktx + ", wrkst=" + wrkst + ", meins=" + meins
				+ ", insp_gubun=" + insp_gubun + ", insp_check_gubun="
				+ insp_check_gubun + ", insp_status=" + insp_status
				+ ", not_insp_status=" + not_insp_status
				+ ", in_delivery_date=" + in_delivery_date
				+ ", in_delivery_date_from=" + in_delivery_date_from
				+ ", in_delivery_date_to=" + in_delivery_date_to
				+ ", in_confirm_date=" + in_confirm_date
				+ ", in_confirm_date_from=" + in_confirm_date_from
				+ ", in_confirm_date_to=" + in_confirm_date_to
				+ ", in_fail_date=" + in_fail_date + ", in_fail_date_from="
				+ in_fail_date_from + ", in_fail_date_to=" + in_fail_date_to
				+ ", mblnr_cancel=" + mblnr_cancel + ", mjahr_cancel="
				+ mjahr_cancel + ", in_labnr=" + in_labnr + ", remark="
				+ remark + ", s_mblnr=" + s_mblnr + ", s_mjahr=" + s_mjahr
				+ ", insp_gubun_nm=" + insp_gubun_nm + ", insp_check_gubun_nm="
				+ insp_check_gubun_nm + ", insp_status_nm=" + insp_status_nm
				+ ", name1=" + name1 + ", txz01=" + txz01 + ", page=" + page
				+ ", rows=" + rows + ", sidx=" + sidx + ", sord=" + sord + "]";
	}
}
