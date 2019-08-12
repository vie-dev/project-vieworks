
package kr.co.passcombine.mes.vo;

import java.io.Serializable;

public class SYQmVo implements Serializable{
	
	private static final long serialVersionUID = 1L;
	
	private String uni_key;
	private String pordno_seq;
	
	private String pordno;
	private String pdsts;
	private String sudat;
	private String cmdat;
	private String itnbr;
	private String pordno_status;
	private String mtart;
	private String auart;
	private String auart_nm;
	private String project_no;
	private String dept_cd;
	private String wkctr;
	private String issue_code;
	private String issue_memo;
	private String ref_doc_no;
	private String creator;
	private String updater;
	private String date_created;
	private String date_updated;
	private String werks;
	private String werks_nm;
	
	private int page;
	private int rows;
	  
	private String sidx;
	private String sord;
	
	private String gubun;
	private String from_sudate;
	private String to_sudate;
	private String from_cmdate;
	private String to_cmdate;
	
	private String pdqty;
	private String conf_date;
	private String gridData;
	
	private String plant;
	private String stge_loc;
	private String move_plant;
	private String move_stloc;
	
	private String jstr;
	private String issue_code_nm;
	
	private String maktx;
	private String meins;
	private String kzumw;
	
	private String iv_materialdocument;
	private String iv_matdocumentyear;
	private String iv_goodsmvt_pstng_date;
	private String iv_documentheader_text;
	
	private String mblnr;
	private String mjahr;
	private String s_mblnr;
	private String s_mjahr;
	 
	private String  routing_no;
	
	private String  member_nm;
	private String  last_sts;
	private String  zgrade;
	private String  worker_emp_no;
	private String  lgort;
	
	private String  last_sts_nm;
	
	private String routing_dscr;
	
	private String sap_send_yn;
	
	private String transfer_routing;
	
	
	private String atwtb_l;
	private String atwtb_m;
	private String atwtb_s;
	private String pre_remain_cnt;
	private String now_remain_cnt;
	private String now_done_cnt;
	private String now_pass_cnt;
	private String now_nonpass_cnt;
	private String entire_remain_cnt;
	
	private String total_remain_cnt;
	private String pass_rate;
	
	private String f_cmdat;
	private String t_cmdat;
	private String group_key;
	
	private String onenow_done_cnt;
	private String onenow_pass_cnt;
	private String twonow_done_cnt;
	private String twonow_pass_cnt;
	private String threenow_done_cnt;
	private String threenow_pass_cnt;
	private String fournow_done_cnt;
	private String fournow_pass_cnt;
	private String fivenow_done_cnt;
	private String fivenow_pass_cnt;
	private String sixnow_done_cnt;
	private String sixnow_pass_cnt;
	private String sevennow_done_cnt;
	private String sevennow_pass_cnt;
	private String eightnow_done_cnt;
	private String eightnow_pass_cnt;
	private String ninenow_done_cnt;
	private String ninenow_pass_cnt;
	private String tennow_done_cnt;
	private String tennow_pass_cnt;
	private String elevennow_done_cnt;
	private String elevennow_pass_cnt;
	private String twelvenow_done_cnt;
	private String twelvenow_pass_cnt;
	
	private String onepass_rate;
	private String twopass_rate;
	private String threepass_rate;
	private String fourpass_rate;
	private String fivepass_rate;
	private String sixpass_rate;
	private String sevenpass_rate;
	private String eightpass_rate;
	private String ninepass_rate;
	private String tenpass_rate;
	private String elevenpass_rate;
	private String twelvepass_rate;
	
	private String lifnr;
	private String name1;
	private String insp_entire_cnt;
	private String insp_incomplete_cnt;
	private String insp_complete_cnt;
	private String insp_pass_cnt;
	private String insp_nonpass_cnt;
	private String insp_pass_rate;
	
	private String dispo;
	private String dsnam;
	
	public String getSap_send_yn() {
		return sap_send_yn;
	}
	public void setSap_send_yn(String sap_send_yn) {
		this.sap_send_yn = sap_send_yn;
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
	private String pdsts_nm;
	private String dept_cd_nm;
	
	public String getMblnr() {
		return mblnr;
	}
	public String getPdqty() {
		return pdqty;
	}
	public void setPdqty(String pdqty) {
		this.pdqty = pdqty;
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
	private String mblnr_cancel;
	private String mjahr_cancel;
	
	public String getIv_materialdocument() {
		return iv_materialdocument;
	}
	public void setIv_materialdocument(String iv_materialdocument) {
		this.iv_materialdocument = iv_materialdocument;
	}
	public String getIv_matdocumentyear() {
		return iv_matdocumentyear;
	}
	public void setIv_matdocumentyear(String iv_matdocumentyear) {
		this.iv_matdocumentyear = iv_matdocumentyear;
	}
	public String getIv_goodsmvt_pstng_date() {
		return iv_goodsmvt_pstng_date;
	}
	public void setIv_goodsmvt_pstng_date(String iv_goodsmvt_pstng_date) {
		this.iv_goodsmvt_pstng_date = iv_goodsmvt_pstng_date;
	}
	public String getIv_documentheader_text() {
		return iv_documentheader_text;
	}
	public void setIv_documentheader_text(String iv_documentheader_text) {
		this.iv_documentheader_text = iv_documentheader_text;
	}
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
	public String getSudat() {
		return sudat;
	}
	public void setSudat(String sudat) {
		this.sudat = sudat;
	}
	public String getCmdat() {
		return cmdat;
	}
	public void setCmdat(String cmdat) {
		this.cmdat = cmdat;
	}
	public String getItnbr() {
		return itnbr;
	}
	public void setItnbr(String itnbr) {
		this.itnbr = itnbr;
	}
	public String getPordno_status() {
		return pordno_status;
	}
	public void setPordno_status(String pordno_status) {
		this.pordno_status = pordno_status;
	}
	public String getMtart() {
		return mtart;
	}
	public void setMtart(String mtart) {
		this.mtart = mtart;
	}
	public String getAuart() {
		return auart;
	}
	public void setAuart(String auart) {
		this.auart = auart;
	}
	public String getProject_no() {
		return project_no;
	}
	public void setProject_no(String project_no) {
		this.project_no = project_no;
	}
	public String getDept_cd() {
		return dept_cd;
	}
	public void setDept_cd(String dept_cd) {
		this.dept_cd = dept_cd;
	}
	public String getWkctr() {
		return wkctr;
	}
	public void setWkctr(String wkctr) {
		this.wkctr = wkctr;
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
	public String getRef_doc_no() {
		return ref_doc_no;
	}
	public void setRef_doc_no(String ref_doc_no) {
		this.ref_doc_no = ref_doc_no;
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
	public String getGubun() {
		return gubun;
	}
	public void setGubun(String gubun) {
		this.gubun = gubun;
	}
	public String getFrom_sudate() {
		return from_sudate;
	}
	public void setFrom_sudate(String from_sudate) {
		this.from_sudate = from_sudate;
	}
	public String getTo_sudate() {
		return to_sudate;
	}
	public void setTo_sudate(String to_sudate) {
		this.to_sudate = to_sudate;
	}
	public String getFrom_cmdate() {
		return from_cmdate;
	}
	public void setFrom_cmdate(String from_cmdate) {
		this.from_cmdate = from_cmdate;
	}
	public String getTo_cmdate() {
		return to_cmdate;
	}
	public void setTo_cmdate(String to_cmdate) {
		this.to_cmdate = to_cmdate;
	}
	public String getGridData() {
		return gridData;
	}
	public void setGridData(String gridData) {
		this.gridData = gridData;
	}
	public String getConf_date() {
		return conf_date;
	}
	public void setConf_date(String conf_date) {
		this.conf_date = conf_date;
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
	public String getJstr() {
		return jstr;
	}
	public void setJstr(String jstr) {
		this.jstr = jstr;
	}
	public String getPdsts_nm() {
		return pdsts_nm;
	}
	public void setPdsts_nm(String pdsts_nm) {
		this.pdsts_nm = pdsts_nm;
	}
	public String getDept_cd_nm() {
		return dept_cd_nm;
	}
	public void setDept_cd_nm(String dept_cd_nm) {
		this.dept_cd_nm = dept_cd_nm;
	}
	public String getRouting_no() {
		return routing_no;
	}
	public void setRouting_no(String routing_no) {
		this.routing_no = routing_no;
	}
	public String getUni_key() {
		return uni_key;
	}
	public void setUni_key(String uni_key) {
		this.uni_key = uni_key;
	}
	public String getPordno_seq() {
		return pordno_seq;
	}
	public void setPordno_seq(String pordno_seq) {
		this.pordno_seq = pordno_seq;
	}
	public String getMember_nm() {
		return member_nm;
	}
	public void setMember_nm(String member_nm) {
		this.member_nm = member_nm;
	}
	public String getLast_sts() {
		return last_sts;
	}
	public void setLast_sts(String last_sts) {
		this.last_sts = last_sts;
	}
	public String getZgrade() {
		return zgrade;
	}
	public void setZgrade(String zgrade) {
		this.zgrade = zgrade;
	}
	public String getWorker_emp_no() {
		return worker_emp_no;
	}
	public void setWorker_emp_no(String worker_emp_no) {
		this.worker_emp_no = worker_emp_no;
	}
	public String getLgort() {
		return lgort;
	}
	public void setLgort(String lgort) {
		this.lgort = lgort;
	}
	public String getIssue_code_nm() {
		return issue_code_nm;
	}
	public void setIssue_code_nm(String issue_code_nm) {
		this.issue_code_nm = issue_code_nm;
	}
	@Override
	public String toString() {
		return "SYQmVo [uni_key=" + uni_key + ", pordno_seq=" + pordno_seq
				+ ", pordno=" + pordno + ", pdsts=" + pdsts + ", sudat="
				+ sudat + ", cmdat=" + cmdat + ", itnbr=" + itnbr
				+ ", pordno_status=" + pordno_status + ", mtart=" + mtart
				+ ", auart=" + auart + ", auart_nm=" + auart_nm
				+ ", project_no=" + project_no + ", dept_cd=" + dept_cd
				+ ", wkctr=" + wkctr + ", issue_code=" + issue_code
				+ ", issue_memo=" + issue_memo + ", ref_doc_no=" + ref_doc_no
				+ ", creator=" + creator + ", updater=" + updater
				+ ", date_created=" + date_created + ", date_updated="
				+ date_updated + ", page=" + page + ", rows=" + rows
				+ ", sidx=" + sidx + ", sord=" + sord + ", gubun=" + gubun
				+ ", from_sudate=" + from_sudate + ", to_sudate=" + to_sudate
				+ ", from_cmdate=" + from_cmdate + ", to_cmdate=" + to_cmdate
				+ ", pdqty=" + pdqty + ", conf_date=" + conf_date
				+ ", gridData=" + gridData + ", plant=" + plant + ", stge_loc="
				+ stge_loc + ", move_plant=" + move_plant + ", move_stloc="
				+ move_stloc + ", jstr=" + jstr + ", issue_code_nm="
				+ issue_code_nm + ", maktx=" + maktx + ", meins=" + meins
				+ ", iv_materialdocument=" + iv_materialdocument
				+ ", iv_matdocumentyear=" + iv_matdocumentyear
				+ ", iv_goodsmvt_pstng_date=" + iv_goodsmvt_pstng_date
				+ ", iv_documentheader_text=" + iv_documentheader_text
				+ ", mblnr=" + mblnr + ", mjahr=" + mjahr + ", s_mblnr="
				+ s_mblnr + ", s_mjahr=" + s_mjahr + ", routing_no="
				+ routing_no + ", member_nm=" + member_nm + ", last_sts="
				+ last_sts + ", zgrade=" + zgrade + ", worker_emp_no="
				+ worker_emp_no + ", lgort=" + lgort + ", last_sts_nm="
				+ last_sts_nm + ", routing_dscr=" + routing_dscr
				+ ", sap_send_yn=" + sap_send_yn + ", pdsts_nm=" + pdsts_nm
				+ ", dept_cd_nm=" + dept_cd_nm + ", mblnr_cancel="
				+ mblnr_cancel + ", mjahr_cancel=" + mjahr_cancel + "]";
	}
	public String getLast_sts_nm() {
		return last_sts_nm;
	}
	public void setLast_sts_nm(String last_sts_nm) {
		this.last_sts_nm = last_sts_nm;
	}
	public String getRouting_dscr() {
		return routing_dscr;
	}
	public void setRouting_dscr(String routing_dscr) {
		this.routing_dscr = routing_dscr;
	}
	public String getAuart_nm() {
		return auart_nm;
	}
	public void setAuart_nm(String auart_nm) {
		this.auart_nm = auart_nm;
	}
	public String getTransfer_routing() {
		return transfer_routing;
	}
	public void setTransfer_routing(String transfer_routing) {
		this.transfer_routing = transfer_routing;
	}
	public String getKzumw() {
		return kzumw;
	}
	public void setKzumw(String kzumw) {
		this.kzumw = kzumw;
	}
	public String getAtwtb_l() {
		return atwtb_l;
	}
	public void setAtwtb_l(String atwtb_l) {
		this.atwtb_l = atwtb_l;
	}
	public String getAtwtb_m() {
		return atwtb_m;
	}
	public void setAtwtb_m(String atwtb_m) {
		this.atwtb_m = atwtb_m;
	}
	public String getAtwtb_s() {
		return atwtb_s;
	}
	public void setAtwtb_s(String atwtb_s) {
		this.atwtb_s = atwtb_s;
	}
	public String getPre_remain_cnt() {
		return pre_remain_cnt;
	}
	public void setPre_remain_cnt(String pre_remain_cnt) {
		this.pre_remain_cnt = pre_remain_cnt;
	}
	public String getNow_remain_cnt() {
		return now_remain_cnt;
	}
	public void setNow_remain_cnt(String now_remain_cnt) {
		this.now_remain_cnt = now_remain_cnt;
	}
	public String getNow_done_cnt() {
		return now_done_cnt;
	}
	public void setNow_done_cnt(String now_done_cnt) {
		this.now_done_cnt = now_done_cnt;
	}
	public String getNow_pass_cnt() {
		return now_pass_cnt;
	}
	public void setNow_pass_cnt(String now_pass_cnt) {
		this.now_pass_cnt = now_pass_cnt;
	}
	public String getNow_nonpass_cnt() {
		return now_nonpass_cnt;
	}
	public void setNow_nonpass_cnt(String now_nonpass_cnt) {
		this.now_nonpass_cnt = now_nonpass_cnt;
	}
	public String getF_cmdat() {
		return f_cmdat;
	}
	public void setF_cmdat(String f_cmdat) {
		this.f_cmdat = f_cmdat;
	}
	public String getT_cmdat() {
		return t_cmdat;
	}
	public void setT_cmdat(String t_cmdat) {
		this.t_cmdat = t_cmdat;
	}
	public String getGroup_key() {
		return group_key;
	}
	public void setGroup_key(String group_key) {
		this.group_key = group_key;
	}
	public String getTotal_remain_cnt() {
		return total_remain_cnt;
	}
	public void setTotal_remain_cnt(String total_remain_cnt) {
		this.total_remain_cnt = total_remain_cnt;
	}
	public String getPass_rate() {
		return pass_rate;
	}
	public void setPass_rate(String pass_rate) {
		this.pass_rate = pass_rate;
	}
	public String getEntire_remain_cnt() {
		return entire_remain_cnt;
	}
	public void setEntire_remain_cnt(String entire_remain_cnt) {
		this.entire_remain_cnt = entire_remain_cnt;
	}
	public String getOnenow_done_cnt() {
		return onenow_done_cnt;
	}
	public void setOnenow_done_cnt(String onenow_done_cnt) {
		this.onenow_done_cnt = onenow_done_cnt;
	}
	public String getOnenow_pass_cnt() {
		return onenow_pass_cnt;
	}
	public void setOnenow_pass_cnt(String onenow_pass_cnt) {
		this.onenow_pass_cnt = onenow_pass_cnt;
	}
	public String getTwonow_done_cnt() {
		return twonow_done_cnt;
	}
	public void setTwonow_done_cnt(String twonow_done_cnt) {
		this.twonow_done_cnt = twonow_done_cnt;
	}
	public String getTwonow_pass_cnt() {
		return twonow_pass_cnt;
	}
	public void setTwonow_pass_cnt(String twonow_pass_cnt) {
		this.twonow_pass_cnt = twonow_pass_cnt;
	}
	public String getThreenow_done_cnt() {
		return threenow_done_cnt;
	}
	public void setThreenow_done_cnt(String threenow_done_cnt) {
		this.threenow_done_cnt = threenow_done_cnt;
	}
	public String getThreenow_pass_cnt() {
		return threenow_pass_cnt;
	}
	public void setThreenow_pass_cnt(String threenow_pass_cnt) {
		this.threenow_pass_cnt = threenow_pass_cnt;
	}
	public String getFournow_done_cnt() {
		return fournow_done_cnt;
	}
	public void setFournow_done_cnt(String fournow_done_cnt) {
		this.fournow_done_cnt = fournow_done_cnt;
	}
	public String getFournow_pass_cnt() {
		return fournow_pass_cnt;
	}
	public void setFournow_pass_cnt(String fournow_pass_cnt) {
		this.fournow_pass_cnt = fournow_pass_cnt;
	}
	public String getFivenow_done_cnt() {
		return fivenow_done_cnt;
	}
	public void setFivenow_done_cnt(String fivenow_done_cnt) {
		this.fivenow_done_cnt = fivenow_done_cnt;
	}
	public String getFivenow_pass_cnt() {
		return fivenow_pass_cnt;
	}
	public void setFivenow_pass_cnt(String fivenow_pass_cnt) {
		this.fivenow_pass_cnt = fivenow_pass_cnt;
	}
	public String getSixnow_done_cnt() {
		return sixnow_done_cnt;
	}
	public void setSixnow_done_cnt(String sixnow_done_cnt) {
		this.sixnow_done_cnt = sixnow_done_cnt;
	}
	public String getSixnow_pass_cnt() {
		return sixnow_pass_cnt;
	}
	public void setSixnow_pass_cnt(String sixnow_pass_cnt) {
		this.sixnow_pass_cnt = sixnow_pass_cnt;
	}
	public String getSevennow_done_cnt() {
		return sevennow_done_cnt;
	}
	public void setSevennow_done_cnt(String sevennow_done_cnt) {
		this.sevennow_done_cnt = sevennow_done_cnt;
	}
	public String getSevennow_pass_cnt() {
		return sevennow_pass_cnt;
	}
	public void setSevennow_pass_cnt(String sevennow_pass_cnt) {
		this.sevennow_pass_cnt = sevennow_pass_cnt;
	}
	public String getEightnow_done_cnt() {
		return eightnow_done_cnt;
	}
	public void setEightnow_done_cnt(String eightnow_done_cnt) {
		this.eightnow_done_cnt = eightnow_done_cnt;
	}
	public String getEightnow_pass_cnt() {
		return eightnow_pass_cnt;
	}
	public void setEightnow_pass_cnt(String eightnow_pass_cnt) {
		this.eightnow_pass_cnt = eightnow_pass_cnt;
	}
	public String getNinenow_done_cnt() {
		return ninenow_done_cnt;
	}
	public void setNinenow_done_cnt(String ninenow_done_cnt) {
		this.ninenow_done_cnt = ninenow_done_cnt;
	}
	public String getNinenow_pass_cnt() {
		return ninenow_pass_cnt;
	}
	public void setNinenow_pass_cnt(String ninenow_pass_cnt) {
		this.ninenow_pass_cnt = ninenow_pass_cnt;
	}
	public String getElevennow_done_cnt() {
		return elevennow_done_cnt;
	}
	public void setElevennow_done_cnt(String elevennow_done_cnt) {
		this.elevennow_done_cnt = elevennow_done_cnt;
	}
	public String getElevennow_pass_cnt() {
		return elevennow_pass_cnt;
	}
	public void setElevennow_pass_cnt(String elevennow_pass_cnt) {
		this.elevennow_pass_cnt = elevennow_pass_cnt;
	}
	public String getTwelvenow_done_cnt() {
		return twelvenow_done_cnt;
	}
	public void setTwelvenow_done_cnt(String twelvenow_done_cnt) {
		this.twelvenow_done_cnt = twelvenow_done_cnt;
	}
	public String getTwelvenow_pass_cnt() {
		return twelvenow_pass_cnt;
	}
	public void setTwelvenow_pass_cnt(String twelvenow_pass_cnt) {
		this.twelvenow_pass_cnt = twelvenow_pass_cnt;
	}
	public String getTennow_done_cnt() {
		return tennow_done_cnt;
	}
	public void setTennow_done_cnt(String tennow_done_cnt) {
		this.tennow_done_cnt = tennow_done_cnt;
	}
	public String getTennow_pass_cnt() {
		return tennow_pass_cnt;
	}
	public void setTennow_pass_cnt(String tennow_pass_cnt) {
		this.tennow_pass_cnt = tennow_pass_cnt;
	}
	public String getOnepass_rate() {
		return onepass_rate;
	}
	public void setOnepass_rate(String onepass_rate) {
		this.onepass_rate = onepass_rate;
	}
	public String getTwopass_rate() {
		return twopass_rate;
	}
	public void setTwopass_rate(String twopass_rate) {
		this.twopass_rate = twopass_rate;
	}
	public String getThreepass_rate() {
		return threepass_rate;
	}
	public void setThreepass_rate(String threepass_rate) {
		this.threepass_rate = threepass_rate;
	}
	public String getFourpass_rate() {
		return fourpass_rate;
	}
	public void setFourpass_rate(String fourpass_rate) {
		this.fourpass_rate = fourpass_rate;
	}
	public String getFivepass_rate() {
		return fivepass_rate;
	}
	public void setFivepass_rate(String fivepass_rate) {
		this.fivepass_rate = fivepass_rate;
	}
	public String getSixpass_rate() {
		return sixpass_rate;
	}
	public void setSixpass_rate(String sixpass_rate) {
		this.sixpass_rate = sixpass_rate;
	}
	public String getSevenpass_rate() {
		return sevenpass_rate;
	}
	public void setSevenpass_rate(String sevenpass_rate) {
		this.sevenpass_rate = sevenpass_rate;
	}
	public String getEightpass_rate() {
		return eightpass_rate;
	}
	public void setEightpass_rate(String eightpass_rate) {
		this.eightpass_rate = eightpass_rate;
	}
	public String getNinepass_rate() {
		return ninepass_rate;
	}
	public void setNinepass_rate(String ninepass_rate) {
		this.ninepass_rate = ninepass_rate;
	}
	public String getTenpass_rate() {
		return tenpass_rate;
	}
	public void setTenpass_rate(String tenpass_rate) {
		this.tenpass_rate = tenpass_rate;
	}
	public String getElevenpass_rate() {
		return elevenpass_rate;
	}
	public void setElevenpass_rate(String elevenpass_rate) {
		this.elevenpass_rate = elevenpass_rate;
	}
	public String getTwelvepass_rate() {
		return twelvepass_rate;
	}
	public void setTwelvepass_rate(String twelvepass_rate) {
		this.twelvepass_rate = twelvepass_rate;
	}
	public String getLifnr() {
		return lifnr;
	}
	public void setLifnr(String lifnr) {
		this.lifnr = lifnr;
	}
	public String getName1() {
		return name1;
	}
	public void setName1(String name1) {
		this.name1 = name1;
	}
	public String getInsp_entire_cnt() {
		return insp_entire_cnt;
	}
	public void setInsp_entire_cnt(String insp_entire_cnt) {
		this.insp_entire_cnt = insp_entire_cnt;
	}
	public String getInsp_incomplete_cnt() {
		return insp_incomplete_cnt;
	}
	public void setInsp_incomplete_cnt(String insp_incomplete_cnt) {
		this.insp_incomplete_cnt = insp_incomplete_cnt;
	}
	public String getInsp_complete_cnt() {
		return insp_complete_cnt;
	}
	public void setInsp_complete_cnt(String insp_complete_cnt) {
		this.insp_complete_cnt = insp_complete_cnt;
	}
	public String getInsp_pass_cnt() {
		return insp_pass_cnt;
	}
	public void setInsp_pass_cnt(String insp_pass_cnt) {
		this.insp_pass_cnt = insp_pass_cnt;
	}
	public String getInsp_nonpass_cnt() {
		return insp_nonpass_cnt;
	}
	public void setInsp_nonpass_cnt(String insp_nonpass_cnt) {
		this.insp_nonpass_cnt = insp_nonpass_cnt;
	}
	public String getInsp_pass_rate() {
		return insp_pass_rate;
	}
	public void setInsp_pass_rate(String insp_pass_rate) {
		this.insp_pass_rate = insp_pass_rate;
	}
	public String getDispo() {
		return dispo;
	}
	public void setDispo(String dispo) {
		this.dispo = dispo;
	}
	public String getDsnam() {
		return dsnam;
	}
	public void setDsnam(String dsnam) {
		this.dsnam = dsnam;
	}
	public String getWerks() {
		return werks;
	}
	public void setWerks(String werks) {
		this.werks = werks;
	}
	public String getWerks_nm() {
		return werks_nm;
	}
	public void setWerks_nm(String werks_nm) {
		this.werks_nm = werks_nm;
	}
}
