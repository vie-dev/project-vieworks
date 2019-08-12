package kr.co.passcombine.mes.vo;

import java.io.Serializable;

public class SYSernrManageVo implements Serializable{
	
	private static final long serialVersionUID = 1L;
	
	private String pordno_pop;	//'MES 내부 KEY',
	private String sernr_seq;	//'시리얼관리 seq',
	private String pordno;	//'sap po key',
	private String routing_gno;	//
	private String routing_no;	//
	private String matnr;	//'자재번호',
	private String menge;	//'출고수량',
	private String bdmng;	//'출고수량',
	private String meins;	//'단위',
	private String budat;	//'출고일',
	private String sernr;	//'시리얼번호',
	private String sernp;	//'시리얼번호',
	private String use_yn;	//'사용여부',
	private String use_memo;	//'비사용사유',
	private String if_status;	//DEFAULT 'N' COMMENT '전송상태(RFC전송완료 \'Y\',오류 E)',
	private String if_msg;	//'전송오류 \'E\' 상태 RFC 오류 메시지',
	private String creator;	//
	private String updater;	//
	private String date_created;	//
	private String date_updated;	//
	
	private String project_no;
	private String lgort;
	private String dept_cd;
	private String params;
	private String reverse;
	private String reversecheck;
	
	private String maktx;
	private String wrkst;
	private String rfc_chk;

	private String aufnr;
	private String werks;
	
	private String material;
	private String move_type;
	private String getentry_qnt;
	private String getentry_uom;
	private String plant;
	private String stge_loc;
	
	private String equals;
	private String move_mat;
	private String move_plant;
	private String move_stloc;
	private String entry_qnt;
	private String entry_uom;
	private String gr_rcpt;
	private String serialno;
	private String matdoc_itm;
	private String org_issue_code;
	private String org_issue_memo;
	private String org_remark;
	
	private String cmdat; 
	private String insp_yn; 
	private String jsonStr;
	
	private String matnr_lgort;
	
	private String uni_key;
	private String first_routing_no;

	private String fault_no;
	private String fault_no_seq;
	private String f_lgort;
	private String t_lgort;
	private String issue_code;
	private String issue_memo;
	private String issue_remark;
	private String in_gubun;
	
	private String org_menge;
	
	public String getJsonStr() {
		return jsonStr;
	}
	public void setJsonStr(String jsonStr) {
		this.jsonStr = jsonStr;
	}
	
	
	public String getMatdoc_itm() {
		return matdoc_itm;
	}
	public void setMatdoc_itm(String matdoc_itm) {
		this.matdoc_itm = matdoc_itm;
	}
	public String getSerialno() {
		return serialno;
	}
	public void setSerialno(String serialno) {
		this.serialno = serialno;
	}
	public String getDept_cd() {
		return dept_cd;
	}
	public void setDept_cd(String dept_cd) {
		this.dept_cd = dept_cd;
	}
	public String getReversecheck() {
		return reversecheck;
	}
	public void setReversecheck(String reversecheck) {
		this.reversecheck = reversecheck;
	}
	public String getReverse() {
		return reverse;
	}
	public void setReverse(String reverse) {
		this.reverse = reverse;
	}
	public String getBdmng() {
		return bdmng;
	}
	public void setBdmng(String bdmng) {
		this.bdmng = bdmng;
	}
	public String getParams() {
		return params;
	}
	public void setParams(String params) {
		this.params = params;
	}
	public String getPordno_pop() {
		return pordno_pop;
	}
	public void setPordno_pop(String pordno_pop) {
		this.pordno_pop = pordno_pop;
	}
	public String getSernr_seq() {
		return sernr_seq;
	}
	public void setSernr_seq(String sernr_seq) {
		this.sernr_seq = sernr_seq;
	}
	public String getSernp() {
		return sernp;
	}
	public void setSernp(String sernp) {
		this.sernp = sernp;
	}
	public String getPordno() {
		return pordno;
	}
	public void setPordno(String pordno) {
		this.pordno = pordno;
	}
	public String getRouting_gno() {
		return routing_gno;
	}
	public void setRouting_gno(String routing_gno) {
		this.routing_gno = routing_gno;
	}
	public String getRouting_no() {
		return routing_no;
	}
	public void setRouting_no(String routing_no) {
		this.routing_no = routing_no;
	}
	public String getMatnr() {
		return matnr;
	}
	public void setMatnr(String matnr) {
		this.matnr = matnr;
	}
	public String getMenge() {
		return menge;
	}
	public void setMenge(String menge) {
		this.menge = menge;
	}
	public String getMeins() {
		return meins;
	}
	public void setMeins(String meins) {
		this.meins = meins;
	}
	public String getBudat() {
		return budat;
	}
	public void setBudat(String budat) {
		this.budat = budat;
	}
	public String getSernr() {
		return sernr;
	}
	public void setSernr(String sernr) {
		this.sernr = sernr;
	}
	public String getUse_yn() {
		return use_yn;
	}
	public void setUse_yn(String use_yn) {
		this.use_yn = use_yn;
	}
	public String getUse_memo() {
		return use_memo;
	}
	public void setUse_memo(String use_memo) {
		this.use_memo = use_memo;
	}
	public String getIf_status() {
		return if_status;
	}
	public void setIf_status(String if_status) {
		this.if_status = if_status;
	}
	public String getIf_msg() {
		return if_msg;
	}
	public void setIf_msg(String if_msg) {
		this.if_msg = if_msg;
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
	public String getProject_no() {
		return project_no;
	}
	public void setProject_no(String project_no) {
		this.project_no = project_no;
	}
	public String getLgort() {
		return lgort;
	}
	public void setLgort(String lgort) {
		this.lgort = lgort;
	}
	public String getWerks() {
		return werks;
	}
	public void setWerks(String werks) {
		this.werks = werks;
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
	public String getRfc_chk() {
		return rfc_chk;
	}
	public void setRfc_chk(String rfc_chk) {
		this.rfc_chk = rfc_chk;
	}
	public String getAufnr() {
		return aufnr;
	}
	public void setAufnr(String aufnr) {
		this.aufnr = aufnr;
	}
	public String getMaterial() {
		return material;
	}
	public void setMaterial(String material) {
		this.material = material;
	}
	public String getMove_type() {
		return move_type;
	}
	public void setMove_type(String move_type) {
		this.move_type = move_type;
	}
	public String getGetentry_qnt() {
		return getentry_qnt;
	}
	public void setGetentry_qnt(String getentry_qnt) {
		this.getentry_qnt = getentry_qnt;
	}
	public String getGetentry_uom() {
		return getentry_uom;
	}
	public void setGetentry_uom(String getentry_uom) {
		this.getentry_uom = getentry_uom;
	}
	public String getPlant() {
		return plant;
	}
	public void setPlant(String plant) {
		this.plant = plant;
	}
	public String getStge_loc() {
		return stge_loc;
	}
	public void setStge_loc(String stge_loc) {
		this.stge_loc = stge_loc;
	}
	public String getEquals() {
		return equals;
	}
	public void setEquals(String equals) {
		this.equals = equals;
	}
	public String getMove_mat() {
		return move_mat;
	}
	public void setMove_mat(String move_mat) {
		this.move_mat = move_mat;
	}
	public String getMove_plant() {
		return move_plant;
	}
	public void setMove_plant(String move_plant) {
		this.move_plant = move_plant;
	}
	public String getMove_stloc() {
		return move_stloc;
	}
	public void setMove_stloc(String move_stloc) {
		this.move_stloc = move_stloc;
	}
	public String getEntry_qnt() {
		return entry_qnt;
	}
	public void setEntry_qnt(String entry_qnt) {
		this.entry_qnt = entry_qnt;
	}
	public String getEntry_uom() {
		return entry_uom;
	}
	public void setEntry_uom(String entry_uom) {
		this.entry_uom = entry_uom;
	}
	public String getGr_rcpt() {
		return gr_rcpt;
	}
	public void setGr_rcpt(String gr_rcpt) {
		this.gr_rcpt = gr_rcpt;
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
	public String getOrg_remark() {
		return org_remark;
	}
	public void setOrg_remark(String org_remark) {
		this.org_remark = org_remark;
	}
	public String getCmdat() {
		return cmdat;
	}
	public void setCmdat(String cmdat) {
		this.cmdat = cmdat;
	}
	public String getInsp_yn() {
		return insp_yn;
	}
	public void setInsp_yn(String insp_yn) {
		this.insp_yn = insp_yn;
	}
	public String getMatnr_lgort() {
		return matnr_lgort;
	}
	public void setMatnr_lgort(String matnr_lgort) {
		this.matnr_lgort = matnr_lgort;
	}
	public String getUni_key() {
		return uni_key;
	}
	public void setUni_key(String uni_key) {
		this.uni_key = uni_key;
	}
	public String getFirst_routing_no() {
		return first_routing_no;
	}
	public void setFirst_routing_no(String first_routing_no) {
		this.first_routing_no = first_routing_no;
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
	public String getIn_gubun() {
		return in_gubun;
	}
	public void setIn_gubun(String in_gubun) {
		this.in_gubun = in_gubun;
	}
	public String getOrg_menge() {
		return org_menge;
	}
	public void setOrg_menge(String org_menge) {
		this.org_menge = org_menge;
	}
	@Override
	public String toString() {
		return "SYSernrManageVo [pordno_pop=" + pordno_pop + ", sernr_seq="
				+ sernr_seq + ", pordno=" + pordno + ", routing_gno="
				+ routing_gno + ", routing_no=" + routing_no + ", matnr="
				+ matnr + ", menge=" + menge + ", bdmng=" + bdmng + ", meins="
				+ meins + ", budat=" + budat + ", sernr=" + sernr + ", sernp="
				+ sernp + ", use_yn=" + use_yn + ", use_memo=" + use_memo
				+ ", if_status=" + if_status + ", if_msg=" + if_msg
				+ ", creator=" + creator + ", updater=" + updater
				+ ", date_created=" + date_created + ", date_updated="
				+ date_updated + ", project_no=" + project_no + ", lgort="
				+ lgort + ", dept_cd=" + dept_cd + ", params=" + params
				+ ", reverse=" + reverse + ", reversecheck=" + reversecheck
				+ ", maktx=" + maktx + ", wrkst=" + wrkst + ", rfc_chk="
				+ rfc_chk + ", aufnr=" + aufnr + ", werks=" + werks
				+ ", material=" + material + ", move_type=" + move_type
				+ ", getentry_qnt=" + getentry_qnt + ", getentry_uom="
				+ getentry_uom + ", plant=" + plant + ", stge_loc=" + stge_loc
				+ ", equals=" + equals + ", move_mat=" + move_mat
				+ ", move_plant=" + move_plant + ", move_stloc=" + move_stloc
				+ ", entry_qnt=" + entry_qnt + ", entry_uom=" + entry_uom
				+ ", gr_rcpt=" + gr_rcpt + ", serialno=" + serialno
				+ ", matdoc_itm=" + matdoc_itm + ", org_issue_code="
				+ org_issue_code + ", org_issue_memo=" + org_issue_memo
				+ ", org_remark=" + org_remark + ", cmdat=" + cmdat
				+ ", insp_yn=" + insp_yn + ", jsonStr=" + jsonStr
				+ ", matnr_lgort=" + matnr_lgort + ", uni_key=" + uni_key + "]";
	}	
	
}
