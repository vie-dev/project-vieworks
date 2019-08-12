package kr.co.passcombine.mes.vo;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import org.json.simple.JSONObject;

public class SYReqmMatnrTblVo implements Serializable {

	private static final long serialVersionUID = 1L;

	private String reqm_matnr_key;
	private String reqm_sub_key;
	private String reqd_matnr_key;
	private String matnr;
	private String werks;
	private String bdter;
	private String lgort;
	private String bdmng;
	private String meins;
	private String request_bdmng;
	private String grade_yn;
	private String serial_yn;	
	private String requester_status;
	private String grantor_status;
	private String grantor_if_status;
	private String grantor_if_msg;
	private String creator;
	private String grantor;
	private String creator_date;
	private String grantor_date;
	private String date_created;
	private String date_updated;
	private int idx;
	private String grade;
	private JSONObject attr;
	
	private String updater;
	
	private String grade_nm;
	private String from_loc;
	private String to_loc; 
	
	private String lgobe_lgfsb; 
	private String lgobe_lgpro;
	private String lgfsb;
	private String lgpro;
	
	private String reqm_matnr_tbl_data;
	private String reqd_matnr_tbl_data;

	private String from_req_date;
	private String to_req_date;
	
	private String sernp;
	private String sernr;
	private String gridData;
	private String gridData_1;
	private String sernr_seq;
	private String confirm_bdmng;
	
	private String matdoc_itm;
	private String tmp_matdoc_itm;
	
	private String maktx;
	private String wrkst;
	private String werks_nm;
	
	private int page;
	private int rows;
	  
	private String sidx;
	private String sord;
	
	private String jsonStr;
	
	private String stge_loc;
	private String move_stloc;
	private String move_type;
	private String plant;
	private String move_plant;
	
	private String pgm_nm;
	
	private String plant_nm;
	private String stge_loc_nm;
	private String move_plant_nm;
	private String move_stloc_nm;
	
	private String labst;
	
	private String confirm_user;
	private String member_nm;
	private String proc_gubun;
	
		
	public String getTmp_matdoc_itm() {
		return tmp_matdoc_itm;
	}

	public void setTmp_matdoc_itm(String tmp_matdoc_itm) {
		this.tmp_matdoc_itm = tmp_matdoc_itm;
	}

	public String getGrade_nm() {
		return grade_nm;
	}

	public void setGrade_nm(String grade_nm) {
		this.grade_nm = grade_nm;
	}

	public String getReqm_matnr_key() {
		return reqm_matnr_key;
	}

	public void setReqm_matnr_key(String reqm_matnr_key) {
		this.reqm_matnr_key = reqm_matnr_key;
	}

	public String getReqm_sub_key() {
		return reqm_sub_key;
	}

	public void setReqm_sub_key(String reqm_sub_key) {
		this.reqm_sub_key = reqm_sub_key;
	}

	public String getMatnr() {
		return matnr;
	}

	public void setMatnr(String matnr) {
		this.matnr = matnr;
	}

	public String getWerks() {
		return werks;
	}

	public void setWerks(String werks) {
		this.werks = werks;
	}

	public String getBdter() {
		return bdter;
	}

	public void setBdter(String bdter) {
		this.bdter = bdter;
	}

	public String getLgort() {
		return lgort;
	}

	public void setLgort(String lgort) {
		this.lgort = lgort;
	}

	public String getBdmng() {
		return bdmng;
	}

	public void setBdmng(String bdmng) {
		this.bdmng = bdmng;
	}

	public String getMeins() {
		return meins;
	}

	public void setMeins(String meins) {
		this.meins = meins;
	}

	public String getRequest_bdmng() {
		return request_bdmng;
	}

	public void setRequest_bdmng(String request_bdmng) {
		this.request_bdmng = request_bdmng;
	}

	public String getGrade_yn() {
		return grade_yn;
	}

	public void setGrade_yn(String grade_yn) {
		this.grade_yn = grade_yn;
	}

	public String getRequester_status() {
		return requester_status;
	}

	public void setRequester_status(String requester_status) {
		this.requester_status = requester_status;
	}

	public String getGrantor_status() {
		return grantor_status;
	}

	public void setGrantor_status(String grantor_status) {
		this.grantor_status = grantor_status;
	}

	public String getGrantor_if_status() {
		return grantor_if_status;
	}

	public void setGrantor_if_status(String grantor_if_status) {
		this.grantor_if_status = grantor_if_status;
	}

	public String getGrantor_if_msg() {
		return grantor_if_msg;
	}

	public void setGrantor_if_msg(String grantor_if_msg) {
		this.grantor_if_msg = grantor_if_msg;
	}

	public String getCreator() {
		return creator;
	}

	public void setCreator(String creator) {
		this.creator = creator;
	}

	public String getGrantor() {
		return grantor;
	}

	public void setGrantor(String grantor) {
		this.grantor = grantor;
	}

	public String getCreator_date() {
		return creator_date;
	}

	public void setCreator_date(String creator_date) {
		this.creator_date = creator_date;
	}

	public String getGrantor_date() {
		return grantor_date;
	}

	public void setGrantor_date(String grantor_date) {
		this.grantor_date = grantor_date;
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

	public JSONObject getAttr() {
		return attr;
	}

	public void setAttr(JSONObject attr) {
		this.attr = attr;
	}

	public int getIdx() {
		return idx;
	}

	public void setIdx(int idx) {
		this.idx = idx;
	}

	public String getGrade() {
		return grade;
	}

	public void setGrade(String grade) {
		this.grade = grade;
	}

	public String getFrom_loc() {
		return from_loc;
	}

	public void setFrom_loc(String from_loc) {
		this.from_loc = from_loc;
	}

	public String getTo_loc() {
		return to_loc;
	}

	public void setTo_loc(String to_loc) {
		this.to_loc = to_loc;
	}

	public String getLgobe_lgfsb() {
		return lgobe_lgfsb;
	}

	public void setLgobe_lgfsb(String lgobe_lgfsb) {
		this.lgobe_lgfsb = lgobe_lgfsb;
	}

	public String getLgobe_lgpro() {
		return lgobe_lgpro;
	}

	public void setLgobe_lgpro(String lgobe_lgpro) {
		this.lgobe_lgpro = lgobe_lgpro;
	}

	public String getReqm_matnr_tbl_data() {
		return reqm_matnr_tbl_data;
	}

	public void setReqm_matnr_tbl_data(String reqm_matnr_tbl_data) {
		this.reqm_matnr_tbl_data = reqm_matnr_tbl_data;
	}

	public String getReqd_matnr_tbl_data() {
		return reqd_matnr_tbl_data;
	}

	public void setReqd_matnr_tbl_data(String reqd_matnr_tbl_data) {
		this.reqd_matnr_tbl_data = reqd_matnr_tbl_data;
	}

	

	public String getFrom_req_date() {
		return from_req_date;
	}

	public void setFrom_req_date(String from_req_date) {
		this.from_req_date = from_req_date;
	}

	public String getTo_req_date() {
		return to_req_date;
	}

	public void setTo_req_date(String to_req_date) {
		this.to_req_date = to_req_date;
	}

	public String getReqd_matnr_key() {
		return reqd_matnr_key;
	}

	public void setReqd_matnr_key(String reqd_matnr_key) {
		this.reqd_matnr_key = reqd_matnr_key;
	}

	public String getSernp() {
		return sernp;
	}

	public void setSernp(String sernp) {
		this.sernp = sernp;
	}

	public String getGridData() {
		return gridData;
	}

	public void setGridData(String gridData) {
		this.gridData = gridData;
	}

	public String getUpdater() {
		return updater;
	}

	public void setUpdater(String updater) {
		this.updater = updater;
	}

	public String getSernr() {
		return sernr;
	}

	public void setSernr(String sernr) {
		this.sernr = sernr;
	}

	public String getConfirm_bdmng() {
		return confirm_bdmng;
	}

	public void setConfirm_bdmng(String confirm_bdmng) {
		this.confirm_bdmng = confirm_bdmng;
	}

	public String getSernr_seq() {
		return sernr_seq;
	}

	public void setSernr_seq(String sernr_seq) {
		this.sernr_seq = sernr_seq;
	}

	public String getLgfsb() {
		return lgfsb;
	}

	public void setLgfsb(String lgfsb) {
		this.lgfsb = lgfsb;
	}

	public String getLgpro() {
		return lgpro;
	}

	public void setLgpro(String lgpro) {
		this.lgpro = lgpro;
	}

	

	public String getGridData_1() {
		return gridData_1;
	}

	public void setGridData_1(String gridData_1) {
		this.gridData_1 = gridData_1;
	}

	public String getMatdoc_itm() {
		return matdoc_itm;
	}

	public void setMatdoc_itm(String matdoc_itm) {
		this.matdoc_itm = matdoc_itm;
	}

	@Override
	public String toString() {
		return "SYReqmMatnrTblVo [reqm_matnr_key=" + reqm_matnr_key
				+ ", reqm_sub_key=" + reqm_sub_key + ", reqd_matnr_key="
				+ reqd_matnr_key + ", matnr=" + matnr + ", werks=" + werks
				+ ", bdter=" + bdter + ", lgort=" + lgort + ", bdmng=" + bdmng
				+ ", meins=" + meins + ", request_bdmng=" + request_bdmng
				+ ", grade_yn=" + grade_yn + ", requester_status="
				+ requester_status + ", grantor_status=" + grantor_status
				+ ", grantor_if_status=" + grantor_if_status
				+ ", grantor_if_msg=" + grantor_if_msg + ", creator=" + creator
				+ ", grantor=" + grantor + ", creator_date=" + creator_date
				+ ", grantor_date=" + grantor_date + ", date_created="
				+ date_created + ", date_updated=" + date_updated + ", idx="
				+ idx + ", grade=" + grade + ", attr=" + attr + ", updater="
				+ updater + ", grade_nm=" + grade_nm + ", from_loc=" + from_loc
				+ ", to_loc=" + to_loc + ", lgobe_lgfsb=" + lgobe_lgfsb
				+ ", lgobe_lgpro=" + lgobe_lgpro + ", lgfsb=" + lgfsb
				+ ", lgpro=" + lgpro + ", reqm_matnr_tbl_data="
				+ reqm_matnr_tbl_data + ", reqd_matnr_tbl_data="
				+ reqd_matnr_tbl_data + ", from_req_date=" + from_req_date
				+ ", to_req_date=" + to_req_date + ", sernp=" + sernp
				+ ", sernr=" + sernr + ", gridData=" + gridData
				+ ", gridData_1=" + gridData_1 + ", sernr_seq=" + sernr_seq
				+ ", confirm_bdmng=" + confirm_bdmng + ", matdoc_itm="
				+ matdoc_itm + "]";
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

	public String getJsonStr() {
		return jsonStr;
	}

	public void setJsonStr(String jsonStr) {
		this.jsonStr = jsonStr;
	}

	public String getStge_loc() {
		return stge_loc;
	}

	public void setStge_loc(String stge_loc) {
		this.stge_loc = stge_loc;
	}

	public String getMove_stloc() {
		return move_stloc;
	}

	public void setMove_stloc(String move_stloc) {
		this.move_stloc = move_stloc;
	}

	public String getMove_type() {
		return move_type;
	}

	public void setMove_type(String move_type) {
		this.move_type = move_type;
	}

	public String getPlant() {
		return plant;
	}

	public void setPlant(String plant) {
		this.plant = plant;
	}

	public String getMove_plant() {
		return move_plant;
	}

	public void setMove_plant(String move_plant) {
		this.move_plant = move_plant;
	}

	public String getPgm_nm() {
		return pgm_nm;
	}

	public void setPgm_nm(String pgm_nm) {
		this.pgm_nm = pgm_nm;
	}

	public String getSerial_yn() {
		return serial_yn;
	}

	public void setSerial_yn(String serial_yn) {
		this.serial_yn = serial_yn;
	}

	public String getPlant_nm() {
		return plant_nm;
	}

	public void setPlant_nm(String plant_nm) {
		this.plant_nm = plant_nm;
	}

	public String getStge_loc_nm() {
		return stge_loc_nm;
	}

	public void setStge_loc_nm(String stge_loc_nm) {
		this.stge_loc_nm = stge_loc_nm;
	}

	public String getMove_plant_nm() {
		return move_plant_nm;
	}

	public void setMove_plant_nm(String move_plant_nm) {
		this.move_plant_nm = move_plant_nm;
	}

	public String getMove_stloc_nm() {
		return move_stloc_nm;
	}

	public void setMove_stloc_nm(String move_stloc_nm) {
		this.move_stloc_nm = move_stloc_nm;
	}

	public String getLabst() {
		return labst;
	}

	public void setLabst(String labst) {
		this.labst = labst;
	}
	
	public String getWerks_nm() {
		return werks_nm;
	}

	public void setWerks_nm(String werks_nm) {
		this.werks_nm = werks_nm;
	}

	public String getConfirm_user() {
		return confirm_user;
	}

	public void setConfirm_user(String confirm_user) {
		this.confirm_user = confirm_user;
	}

	public String getMember_nm() {
		return member_nm;
	}

	public void setMember_nm(String member_nm) {
		this.member_nm = member_nm;
	}

	public String getProc_gubun() {
		return proc_gubun;
	}

	public void setProc_gubun(String proc_gubun) {
		this.proc_gubun = proc_gubun;
	}
}
