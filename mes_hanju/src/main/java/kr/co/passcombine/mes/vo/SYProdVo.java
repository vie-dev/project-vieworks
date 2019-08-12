package kr.co.passcombine.mes.vo;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class SYProdVo implements Serializable{
	
  private static final long serialVersionUID = 1L;

	private String pordno_pop;
	private String pordno_seq;
	private String pordno;
	private String pordno_child;
	private String pdsts;
	private String pdsts_nm;
	private String pordno_status;
	private String kunnr_se;
	private String customer_nm;
	private String jidat;
	private String sedat;
	private String cmdat;
	private String cmdat_seq;
	private String itnbr;
	private String itnbr_nm;
	private String pspec;
	private String pdqty;
	private String fedat;
	private String edatu;
	private String project_no;
	private String project_no_yn;
	private String sub_sernr;
	private String kdauf;
	private String kdpos;
	private String histno;
	private String dept_cd;
	private String member_emp_no;
	private String member_nm;
	private String jocod;
	private String wkctr;
	private String steus;
	private String frdlb;
	private String bezei;
	private String lgort;
	private String dispo;
	private String zaufnr;
	private String ktext;
	private String zmatnr;
	private String zcsreq;
	private String routing_gno;
	private String routing_gnm;
	private String routing_no;
	private String routing_nm;
	private String routing_dscr;
	private String routing_gubun;
	private String routing_gubun_nm;
	private String routing_code;
	private String routing_plast_gubun;
	private String worker_nm;
	private String prod_memo;
	private String prod_str_date;
	private String prod_str_time;
	private String prod_end_date;
	private String prod_end_time;
	private String sapdel_yn;
	private String create_date;
	private String change_date;
	private String if_status;
	private String if_msg;
	private String auart;
	private String auart_nm;
	private String inout_project_no;
	private String inout_sap_sts;
	private String if_out_sap;
	private String if_out_sap_msg;
	private String if_in_sap;
	private String if_in_sap_msg;
	private String pordno_cnt;
	private String cell;
	private String date_created;
	private String date_updated;
	private String creator;
	private String updater;
	private String insp_lgort;
	private String first_routing_no;
	private String zauart;
	private String zbezei;

	private String cmd;
	private String ukey;

	private String jidat_from;
	private String jidat_to;

	private String start_dt_tm; 
	private String end_dt_tm;
  
	private String pause_start_dt_tm;
	private String pause_end_dt_tm;  

	private String cmdat_from;
	private String cmdat_to;  
  
	private String serial_yn; 
	private String itnbr_qty;

	private Integer page;
	private Integer rows;
	
	private String params;
	private String mtart;
  
	private String uniqkey;

	private String werks;
	private String werks_nm;
	private String arbpl;
	private String arbpl_nm;
	
	private String matnr;
	private String gr_no;
	private String gr_nm;
	private String ecr_no;
	private String rn_no;
	private String dmr_no;
	private String change_remark;
	private String gr_seq;
	
	private String routing_yn;
	
	private String member_id;
	private String line_nm;
	private String jo_nm;
	private String member_cnt;
	
	
	private String next_routing;
	private String next_routing_code;
	
	private String routing_gno_gubun;
	private String routing_gno_gubun_nm;
	private String ad_name1;
	private String zzapplication;
	private String zzswoption;
	private String zzswoptiont;
	private String ztftserial;
	private String zlongtext;
	private String zgrade;
	
	private String pdsts_now;
	private String pdsts_before;
	
	private ArrayList<String> list;
	
	private String now_routing ;
	
	private String maktx;
	private String wrkst;
	private String kzumw;
	private String sernp;
	
	private String confirm_id;
	
 
	private String issue_code;
	private String issue_code_nm;
	private String issue_remark;
	private String diff_time;
	
	
	
	
 
	public String getDiff_time() {
		return diff_time;
	}
	public void setDiff_time(String diff_time) {
		this.diff_time = diff_time;
	}
	public String getNow_routing() {
		return now_routing;
	}
	public void setNow_routing(String now_routing) {
		this.now_routing = now_routing;
	}
	public String getNext_routing() {
		return next_routing;
	}
	public void setNext_routing(String next_routing) {
		this.next_routing = next_routing;
	}
	
	public String getRouting_plast_gubun() {
		return routing_plast_gubun;
	}
	public void setRouting_plast_gubun(String routing_plast_gubun) {
		this.routing_plast_gubun = routing_plast_gubun;
	}
	public String getUkey() {
		return ukey;
	}
	public void setUkey(String ukey) {
		this.ukey = ukey;
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
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	public String getParams() {
		return params;
	}
	public void setParams(String params) {
		this.params = params;
	}
	public String getZmatnr() {
			return zmatnr;
	}
	public void setZmatnr(String zmatnr) {
		this.zmatnr = zmatnr;
	}
	public String getUniqkey() {
		return uniqkey;
	}
	public void setUniqkey(String uniqkey) {
		this.uniqkey = uniqkey;
	}
	public String getMtart() {
		return mtart;
	}
	public void setMtart(String mtart) {
		this.mtart = mtart;
	}
	public Integer getPage() {
		return page;
	}
	public void setPage(Integer page) {
		this.page = page;
	}
	public Integer getRows() {
		return rows;
	}
	public void setRows(Integer rows) {
		this.rows = rows;
	}
	public String getMatnr() {
		return matnr;
	}
	public void setMatnr(String matnr) {
		this.matnr = matnr;
	}
	public String getGr_no() {
		return gr_no;
	}
	public void setGr_no(String gr_no) {
		this.gr_no = gr_no;
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
	public String getPordno_pop() {
		return pordno_pop;
	}
	public ArrayList<String> getList() {
		return list;
	}
	public void setList(ArrayList<String> list) {
		this.list = list;
	}
	public String getPordno_seq() {
		return pordno_seq;
	}
	public void setPordno_pop(String pordno_pop) {
		this.pordno_pop = pordno_pop;
	}
	public void setPordno_seq(String pordno_seq) {
		this.pordno_seq = pordno_seq;
	}
	public String getPordno() {
		return pordno;
	}
	public void setPordno(String pordno) {
		this.pordno = pordno;
	}
	public String getPordno_cnt() {
		return pordno_cnt;
	}
	public void setPordno_cnt(String pordno_cnt) {
		this.pordno_cnt = pordno_cnt;
	}
	public String getPordno_child() {
		return pordno_child;
	}
	public void setPordno_child(String pordno_child) {
		this.pordno_child = pordno_child;
	}
	public String getPordno_status() {
		return pordno_status;
	}
	public void setPordno_status(String pordno_status) {
		this.pordno_status = pordno_status;
	}
	public String getCustomer_nm() {
		return customer_nm;
	}
	public void setCustomer_nm(String customer_nm) {
		this.customer_nm = customer_nm;
	}
	public String getJidat() {
		return jidat;
	}
	public void setJidat(String jidat) {
		this.jidat = jidat;
	}
	public String getSedat() {
		return sedat;
	}
	public void setSedat(String sedat) {
		this.sedat = sedat;
	}
	public String getItnbr() {
		return itnbr;
	}
	public String getItnbr_nm() {
		return itnbr_nm;
	}
	public void setItnbr(String itnbr) {
		this.itnbr = itnbr;
	}
	public void setItnbr_nm(String itnbr_nm) {
		this.itnbr_nm = itnbr_nm;
	}
	public String getPspec() {
		return pspec;
	}
	public void setPspec(String pspec) {
		this.pspec = pspec;
	}
	public String getPdqty() {
		return pdqty;
	}
	public void setPdqty(String pdqty) {
		this.pdqty = pdqty;
	}
	public String getFedat() {
		return fedat;
	}
	public void setFedat(String fedat) {
		this.fedat = fedat;
	}
	public String getEdatu() {
		return edatu;
	}
	public void setEdatu(String edatu) {
		this.edatu = edatu;
	}
	public String getProject_no() {
		return project_no;
	}
	public void setProject_no(String project_no) {
		this.project_no = project_no;
	}
	public String getKdauf() {
		return kdauf;
	}
	public void setKdauf(String kdauf) {
		this.kdauf = kdauf;
	}
	public String getKdpos() {
		return kdpos;
	}
	public void setKdpos(String kdpos) {
		this.kdpos = kdpos;
	}
	public String getHistno() {
		return histno;
	}
	public void setHistno(String histno) {
		this.histno = histno;
	}
	public String getJocod() {
		return jocod;
	}
	public void setJocod(String jocod) {
		this.jocod = jocod;
	}
	public String getWkctr() {
		return wkctr;
	}
	public void setWkctr(String wkctr) {
		this.wkctr = wkctr;
	}
	public String getCell() {
		return cell;
	}
	public void setCell(String cell) {
		this.cell = cell;
	}
	public String getWorker_nm() {
		return worker_nm;
	}
	public void setWorker_nm(String worker_nm) {
		this.worker_nm = worker_nm;
	}
	public String getKunnr_se() {
		return kunnr_se;
	}
	public void setKunnr_se(String kunnr_se) {
		this.kunnr_se = kunnr_se;
	}
	public String getProd_memo() {
		return prod_memo;
	}
	public void setProd_memo(String prod_memo) {
		this.prod_memo = prod_memo;
	}
	public String getProd_str_date() {
		return prod_str_date;
	}
	public void setProd_str_date(String prod_str_date) {
		this.prod_str_date = prod_str_date;
	}
	public String getProd_str_time() {
		return prod_str_time;
	}
	public void setProd_str_time(String prod_str_time) {
		this.prod_str_time = prod_str_time;
	}
	public String getProd_end_date() {
		return prod_end_date;
	}
	public void setProd_end_date(String prod_end_date) {
		this.prod_end_date = prod_end_date;
	}
	public String getProd_end_time() {
		return prod_end_time;
	}
	public void setProd_end_time(String prod_end_time) {
		this.prod_end_time = prod_end_time;
	}
	public String getPdsts() {
		return pdsts;
	}
	public String getPdsts_nm() {
		return pdsts_nm;
	}
	public void setPdsts(String pdsts) {
		this.pdsts = pdsts;
	}
	public void setPdsts_nm(String pdsts_nm) {
		this.pdsts_nm = pdsts_nm;
	}
	public String getSapdel_yn() {
		return sapdel_yn;
	}
	public void setSapdel_yn(String sapdel_yn) {
		this.sapdel_yn = sapdel_yn;
	}
	public String getCreate_date() {
		return create_date;
	}
	public void setCreate_date(String create_date) {
		this.create_date = create_date;
	}
	public String getChange_date() {
		return change_date;
	}
	public void setChange_date(String change_date) {
		this.change_date = change_date;
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
	public String getAuart() {
		return auart;
	}
	public void setAuart(String auart) {
		this.auart = auart;
	}
	public String getInout_project_no() {
		return inout_project_no;
	}
	public void setInout_project_no(String inout_project_no) {
		this.inout_project_no = inout_project_no;
	}
	public String getInout_sap_sts() {
		return inout_sap_sts;
	}
	public void setInout_sap_sts(String inout_sap_sts) {
		this.inout_sap_sts = inout_sap_sts;
	}
	public String getIf_out_sap() {
		return if_out_sap;
	}
	public void setIf_out_sap(String if_out_sap) {
		this.if_out_sap = if_out_sap;
	}
	public String getIf_out_sap_msg() {
		return if_out_sap_msg;
	}
	public void setIf_out_sap_msg(String if_out_sap_msg) {
		this.if_out_sap_msg = if_out_sap_msg;
	}
	public String getIf_in_sap() {
		return if_in_sap;
	}
	public void setIf_in_sap(String if_in_sap) {
		this.if_in_sap = if_in_sap;
	}
	public String getIf_in_sap_msg() {
		return if_in_sap_msg;
	}
	public void setIf_in_sap_msg(String if_in_sap_msg) {
		this.if_in_sap_msg = if_in_sap_msg;
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
	  
	public String getCmd() {
		return cmd;
	}
	public void setCmd(String cmd) {
		this.cmd = cmd;
	}
	public String getJidat_from() {
		return jidat_from;
	}
	public void setJidat_from(String jidat_from) {
		this.jidat_from = jidat_from;
	}
	public String getJidat_to() {
		return jidat_to;
	}
	public void setJidat_to(String jidat_to) {
		this.jidat_to = jidat_to;
	}  
	public String getDept_cd() {
		return dept_cd;
	}
	public void setDept_cd(String dept_cd) {
		this.dept_cd = dept_cd;
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
	public String getRouting_gnm() {
		return routing_gnm;
	}
	public void setRouting_gnm(String routing_gnm) {
		this.routing_gnm = routing_gnm;
	}
	public String getRouting_nm() {
		return routing_nm;
	}
	public void setRouting_nm(String routing_nm) {
		this.routing_nm = routing_nm;
	}
	public String getStart_dt_tm() {
		return start_dt_tm;
	}
	public void setStart_dt_tm(String start_dt_tm) {
		this.start_dt_tm = start_dt_tm;
	}
	public String getEnd_dt_tm() {
		return end_dt_tm;
	}
	public void setEnd_dt_tm(String end_dt_tm) {
		this.end_dt_tm = end_dt_tm;
	}
	public String getPause_start_dt_tm() {
		return pause_start_dt_tm;
	}
	public void setPause_start_dt_tm(String pause_start_dt_tm) {
		this.pause_start_dt_tm = pause_start_dt_tm;
	}
	public String getPause_end_dt_tm() {
		return pause_end_dt_tm;
	}
	public void setPause_end_dt_tm(String pause_end_dt_tm) {
		this.pause_end_dt_tm = pause_end_dt_tm;
	}
	public String getMember_emp_no() {
		return member_emp_no;
	}
	public void setMember_emp_no(String member_emp_no) {
		this.member_emp_no = member_emp_no;
	}
	public String getMember_nm() {
		return member_nm;
	}
	public void setMember_nm(String member_nm) {
		this.member_nm = member_nm;
	}
	public String getSerial_yn() {
		return serial_yn;
	}
	public void setSerial_yn(String serial_yn) {
		this.serial_yn = serial_yn;
	}
	public String getItnbr_qty() {
		return itnbr_qty;
	}
	public void setItnbr_qty(String itnbr_qty) {
		this.itnbr_qty = itnbr_qty;
	}
	public String getCmdat() {
		return cmdat;
	}
	public void setCmdat(String cmdat) {
		this.cmdat = cmdat;
	}
	public String getCmdat_seq() {
		return cmdat_seq;
	}
	public void setCmdat_seq(String cmdat_seq) {
		this.cmdat_seq = cmdat_seq;
	}
	public String getRouting_code() {
		return routing_code;
	}
	public void setRouting_code(String routing_code) {
		this.routing_code = routing_code;
	}
	public String getProject_no_yn() {
		return project_no_yn;
	}
	public void setProject_no_yn(String project_no_yn) {
		this.project_no_yn = project_no_yn;
	}
	public String getSub_sernr() {
		return sub_sernr;
	}
	public void setSub_sernr(String sub_sernr) {
		this.sub_sernr = sub_sernr;
	}
	public String getSteus() {
		return steus;
	}
	public void setSteus(String steus) {
		this.steus = steus;
	}
	public String getFrdlb() {
		return frdlb;
	}
	public void setFrdlb(String frdlb) {
		this.frdlb = frdlb;
	}
	public String getBezei() {
		return bezei;
	}
	public void setBezei(String bezei) {
		this.bezei = bezei;
	}
	public String getLgort() {
		return lgort;
	}
	public void setLgort(String lgort) {
		this.lgort = lgort;
	}
	public String getDispo() {
		return dispo;
	}
	public void setDispo(String dispo) {
		this.dispo = dispo;
	}
	public String getZaufnr() {
		return zaufnr;
	}
	public void setZaufnr(String zaufnr) {
		this.zaufnr = zaufnr;
	}
	public String getKtext() {
		return ktext;
	}
	public void setKtext(String ktext) {
		this.ktext = ktext;
	}
	public String getZcsreq() {
		return zcsreq;
	}
	public void setZcsreq(String zcsreq) {
		this.zcsreq = zcsreq;
	}
	public String getRouting_gubun() {
		return routing_gubun;
	}
	public void setRouting_gubun(String routing_gubun) {
		this.routing_gubun = routing_gubun;
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
	public String getArbpl() {
		return arbpl;
	}
	public void setArbpl(String arbpl) {
		this.arbpl = arbpl;
	}
	public String getArbpl_nm() {
		return arbpl_nm;
	}
	public void setArbpl_nm(String arbpl_nm) {
		this.arbpl_nm = arbpl_nm;
	}
	public String getRouting_yn() {
		return routing_yn;
	}
	public void setRouting_yn(String routing_yn) {
		this.routing_yn = routing_yn;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public String getLine_nm() {
		return line_nm;
	}
	public void setLine_nm(String line_nm) {
		this.line_nm = line_nm;
	}
	public String getJo_nm() {
		return jo_nm;
	}
	public void setJo_nm(String jo_nm) {
		this.jo_nm = jo_nm;
	}
	
	public String getCmdat_from() {
		return cmdat_from;
	}
	public void setCmdat_from(String cmdat_from) {
		this.cmdat_from = cmdat_from;
	}
	public String getCmdat_to() {
		return cmdat_to;
	}
	public void setCmdat_to(String cmdat_to) {
		this.cmdat_to = cmdat_to;
	}
	public String getRouting_gno_gubun() {
		return routing_gno_gubun;
	}
	public void setRouting_gno_gubun(String routing_gno_gubun) {
		this.routing_gno_gubun = routing_gno_gubun;
	}
	public String getAd_name1() {
		return ad_name1;
	}
	public void setAd_name1(String ad_name1) {
		this.ad_name1 = ad_name1;
	}
	public String getZzapplication() {
		return zzapplication;
	}
	public void setZzapplication(String zzapplication) {
		this.zzapplication = zzapplication;
	}
	public String getZzswoption() {
		return zzswoption;
	}
	public void setZzswoption(String zzswoption) {
		this.zzswoption = zzswoption;
	}
	public String getZtftserial() {
		return ztftserial;
	}
	public void setZtftserial(String ztftserial) {
		this.ztftserial = ztftserial;
	}
	public String getZlongtext() {
		return zlongtext;
	}
	public void setZlongtext(String zlongtext) {
		this.zlongtext = zlongtext;
	}
	public String getNext_routing_code() {
		return next_routing_code;
	}
	public void setNext_routing_code(String next_routing_code) {
		this.next_routing_code = next_routing_code;
	}
	public String getGr_nm() {
		return gr_nm;
	}
	public void setGr_nm(String gr_nm) {
		this.gr_nm = gr_nm;
	}
	public String getChange_remark() {
		return change_remark;
	}
	public void setChange_remark(String change_remark) {
		this.change_remark = change_remark;
	}
	public String getMember_cnt() {
		return member_cnt;
	}
	public void setMember_cnt(String member_cnt) {
		this.member_cnt = member_cnt;
	}
	
	public String getRouting_gubun_nm() {
		return routing_gubun_nm;
	}
	public void setRouting_gubun_nm(String routing_gubun_nm) {
		this.routing_gubun_nm = routing_gubun_nm;
	}
	public String getRouting_gno_gubun_nm() {
		return routing_gno_gubun_nm;
	}
	public void setRouting_gno_gubun_nm(String routing_gno_gubun_nm) {
		this.routing_gno_gubun_nm = routing_gno_gubun_nm;
	}
	public String getZgrade() {
		return zgrade;
	}
	public void setZgrade(String zgrade) {
		this.zgrade = zgrade;
	}
	public String getZauart() {
		return zauart;
	}
	public void setZauart(String zauart) {
		this.zauart = zauart;
	}
	public String getZbezei() {
		return zbezei;
	}
	public void setZbezei(String zbezei) {
		this.zbezei = zbezei;
	}
	public String getPdsts_now() {
		return pdsts_now;
	}
	public void setPdsts_now(String pdsts_now) {
		this.pdsts_now = pdsts_now;
	}
	public String getPdsts_before() {
		return pdsts_before;
	}
	public void setPdsts_before(String pdsts_before) {
		this.pdsts_before = pdsts_before;
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
	public String getKzumw() {
		return kzumw;
	}
	public void setKzumw(String kzumw) {
		this.kzumw = kzumw;
	}
	public String getFirst_routing_no() {
		return first_routing_no;
	}
	public void setFirst_routing_no(String first_routing_no) {
		this.first_routing_no = first_routing_no;
	}
	public String getInsp_lgort() {
		return insp_lgort;
	}
	public void setInsp_lgort(String insp_lgort) {
		this.insp_lgort = insp_lgort;
	}
	public String getSernp() {
		return sernp;
	}
	public void setSernp(String sernp) {
		this.sernp = sernp;
	}
	public String getGr_seq() {
		return gr_seq;
	}
	public void setGr_seq(String gr_seq) {
		this.gr_seq = gr_seq;
	}
	
	public String getConfirm_id() {
		return confirm_id;
	}
	public void setConfirm_id(String confirm_id) {
		this.confirm_id = confirm_id;
	}
	public String getIssue_code() {
		return issue_code;
	}
	public void setIssue_code(String issue_code) {
		this.issue_code = issue_code;
	}
	public String getIssue_code_nm() {
		return issue_code_nm;
	}
	public void setIssue_code_nm(String issue_code_nm) {
		this.issue_code_nm = issue_code_nm;
	}
	public String getIssue_remark() {
		return issue_remark;
	}
	public void setIssue_remark(String issue_remark) {
		this.issue_remark = issue_remark;
	}
	public String getZzswoptiont() {
		return zzswoptiont;
	}
	public void setZzswoptiont(String zzswoptiont) {
		this.zzswoptiont = zzswoptiont;
	}
	@Override
	public String toString() {
		return "SYProdVo [pordno_pop=" + pordno_pop + ", pordno_seq="
				+ pordno_seq + ", pordno=" + pordno + ", pordno_child="
				+ pordno_child + ", pdsts=" + pdsts + ", pdsts_nm=" + pdsts_nm
				+ ", pordno_status=" + pordno_status + ", kunnr_se=" + kunnr_se
				+ ", customer_nm=" + customer_nm + ", jidat=" + jidat
				+ ", sedat=" + sedat + ", cmdat=" + cmdat + ", cmdat_seq="
				+ cmdat_seq + ", itnbr=" + itnbr + ", itnbr_nm=" + itnbr_nm
				+ ", pspec=" + pspec + ", pdqty=" + pdqty + ", fedat=" + fedat
				+ ", edatu=" + edatu + ", project_no=" + project_no
				+ ", project_no_yn=" + project_no_yn + ", sub_sernr="
				+ sub_sernr + ", kdauf=" + kdauf + ", kdpos=" + kdpos
				+ ", histno=" + histno + ", dept_cd=" + dept_cd
				+ ", member_emp_no=" + member_emp_no + ", member_nm="
				+ member_nm + ", jocod=" + jocod + ", wkctr=" + wkctr
				+ ", steus=" + steus + ", frdlb=" + frdlb + ", bezei=" + bezei
				+ ", lgort=" + lgort + ", dispo=" + dispo + ", zaufnr="
				+ zaufnr + ", ktext=" + ktext + ", zmatnr=" + zmatnr
				+ ", zcsreq=" + zcsreq + ", routing_gno=" + routing_gno
				+ ", routing_gnm=" + routing_gnm + ", routing_no=" + routing_no
				+ ", routing_nm=" + routing_nm + ", routing_dscr="
				+ routing_dscr + ", routing_gubun=" + routing_gubun
				+ ", routing_gubun_nm=" + routing_gubun_nm + ", routing_code="
				+ routing_code + ", routing_plast_gubun=" + routing_plast_gubun
				+ ", worker_nm=" + worker_nm + ", prod_memo=" + prod_memo
				+ ", prod_str_date=" + prod_str_date + ", prod_str_time="
				+ prod_str_time + ", prod_end_date=" + prod_end_date
				+ ", prod_end_time=" + prod_end_time + ", sapdel_yn="
				+ sapdel_yn + ", create_date=" + create_date + ", change_date="
				+ change_date + ", if_status=" + if_status + ", if_msg="
				+ if_msg + ", auart=" + auart + ", auart_nm=" + auart_nm
				+ ", inout_project_no=" + inout_project_no + ", inout_sap_sts="
				+ inout_sap_sts + ", if_out_sap=" + if_out_sap
				+ ", if_out_sap_msg=" + if_out_sap_msg + ", if_in_sap="
				+ if_in_sap + ", if_in_sap_msg=" + if_in_sap_msg
				+ ", pordno_cnt=" + pordno_cnt + ", cell=" + cell
				+ ", date_created=" + date_created + ", date_updated="
				+ date_updated + ", creator=" + creator + ", updater="
				+ updater + ", insp_lgort=" + insp_lgort
				+ ", first_routing_no=" + first_routing_no + ", zauart="
				+ zauart + ", zbezei=" + zbezei + ", cmd=" + cmd + ", ukey="
				+ ukey + ", jidat_from=" + jidat_from + ", jidat_to="
				+ jidat_to + ", start_dt_tm=" + start_dt_tm + ", end_dt_tm="
				+ end_dt_tm + ", pause_start_dt_tm=" + pause_start_dt_tm
				+ ", pause_end_dt_tm=" + pause_end_dt_tm + ", cmdat_from="
				+ cmdat_from + ", cmdat_to=" + cmdat_to + ", serial_yn="
				+ serial_yn + ", itnbr_qty=" + itnbr_qty + ", page=" + page
				+ ", rows=" + rows + ", params=" + params + ", mtart=" + mtart
				+ ", uniqkey=" + uniqkey + ", werks=" + werks + ", werks_nm="
				+ werks_nm + ", arbpl=" + arbpl + ", arbpl_nm=" + arbpl_nm
				+ ", matnr=" + matnr + ", gr_no=" + gr_no + ", gr_nm=" + gr_nm
				+ ", ecr_no=" + ecr_no + ", rn_no=" + rn_no + ", dmr_no="
				+ dmr_no + ", change_remark=" + change_remark + ", gr_seq="
				+ gr_seq + ", routing_yn=" + routing_yn + ", member_id="
				+ member_id + ", line_nm=" + line_nm + ", jo_nm=" + jo_nm
				+ ", member_cnt=" + member_cnt + ", next_routing="
				+ next_routing + ", next_routing_code=" + next_routing_code
				+ ", routing_gno_gubun=" + routing_gno_gubun
				+ ", routing_gno_gubun_nm=" + routing_gno_gubun_nm
				+ ", ad_name1=" + ad_name1 + ", zzapplication=" + zzapplication
				+ ", zzswoption=" + zzswoption + ", zzswoptiont=" + zzswoptiont
				+ ", ztftserial=" + ztftserial + ", zlongtext=" + zlongtext
				+ ", zgrade=" + zgrade + ", pdsts_now=" + pdsts_now
				+ ", pdsts_before=" + pdsts_before + ", list=" + list
				+ ", now_routing=" + now_routing + ", maktx=" + maktx
				+ ", wrkst=" + wrkst + ", kzumw=" + kzumw + ", sernp=" + sernp
				+ ", confirm_id=" + confirm_id + ", issue_code=" + issue_code
				+ ", issue_code_nm=" + issue_code_nm + ", issue_remark="
				+ issue_remark + ", diff_time=" + diff_time + "]";
	}
}
