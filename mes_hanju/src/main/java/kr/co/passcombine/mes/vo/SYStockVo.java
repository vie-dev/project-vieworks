package kr.co.passcombine.mes.vo;

import java.io.Serializable;
import java.util.ArrayList;

public class SYStockVo implements Serializable{
	
	private static final long serialVersionUID = 1L;
	
	private String werks;
	private String lgort;
	private String lifnr;
	private String kunnr;
	private String matnr;
	private String labst;
	private String b_werk;
	private String b_werks;
	private String b_lager;
	
	private String lgort_nm;
	
	private String kdauf;
	private String kdpos;
	private String ps_psp_pnr;
	private String meins;
	private String sernr;
	private String sernp;
	private String creator;
	private String updater;
	
	private ArrayList<String> matnrList;
	private ArrayList<String> lgortList;

	private String maktx;
	private String wrkst;
	private String inspn;
	
	private int page;
	private int rows;
	  
	private String sidx;
	private String sord;
	
	private String insts;
	private String bdmng;
	private String t_gubun;
	private String inspec_lot;
	private String werks_nm;

	
	public String getWerks() {
		return werks;
	}
	public void setWerks(String werks) {
		this.werks = werks;
	}
	public String getLgort() {
		return lgort;
	}
	public void setLgort(String lgort) {
		this.lgort = lgort;
	}
	public String getLifnr() {
		return lifnr;
	}
	public void setLifnr(String lifnr) {
		this.lifnr = lifnr;
	}
	public String getKunnr() {
		return kunnr;
	}
	public void setKunnr(String kunnr) {
		this.kunnr = kunnr;
	}
	public String getMatnr() {
		return matnr;
	}
	public void setMatnr(String matnr) {
		this.matnr = matnr;
	}
	public String getLabst() {
		return labst;
	}
	public void setLabst(String labst) {
		this.labst = labst;
	}
	public String getB_werks() {
		return b_werks;
	}
	public void setB_werks(String b_werks) {
		this.b_werks = b_werks;
	}
	public String getB_lager() {
		return b_lager;
	}
	public void setB_lager(String b_lager) {
		this.b_lager = b_lager;
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
	public String getInspec_lot() {
		return inspec_lot;
	}
	public void setInspec_lot(String inspec_lot) {
		this.inspec_lot = inspec_lot;
	}
	public String getInsts() {
		return insts;
	}
	public void setInsts(String insts) {
		this.insts = insts;
	}
	public String getWerks_nm() {
		return werks_nm;
	}
	public void setWerks_nm(String werks_nm) {
		this.werks_nm = werks_nm;
	}
	public String getPs_psp_pnr() {
		return ps_psp_pnr;
	}
	public void setPs_psp_pnr(String ps_psp_pnr) {
		this.ps_psp_pnr = ps_psp_pnr;
	}
	public String getSernr() {
		return sernr;
	}
	public void setSernr(String sernr) {
		this.sernr = sernr;
	}
	public String getBdmng() {
		return bdmng;
	}
	public void setBdmng(String bdmng) {
		this.bdmng = bdmng;
	}
	public String getT_gubun() {
		return t_gubun;
	}
	public void setT_gubun(String t_gubun) {
		this.t_gubun = t_gubun;
	}
	public String getMeins() {
		return meins;
	}
	public void setMeins(String meins) {
		this.meins = meins;
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
	public ArrayList<String> getMatnrList() {
		return matnrList;
	}
	public void setMatnrList(ArrayList<String> matnrList) {
		this.matnrList = matnrList;
	}
	public String getB_werk() {
		return b_werk;
	}
	public void setB_werk(String b_werk) {
		this.b_werk = b_werk;
	}
	public String getLgort_nm() {
		return lgort_nm;
	}
	public void setLgort_nm(String lgort_nm) {
		this.lgort_nm = lgort_nm;
	}
	public String getSernp() {
		return sernp;
	}
	public void setSernp(String sernp) {
		this.sernp = sernp;
	}
	public ArrayList<String> getLgortList() {
		return lgortList;
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
	public void setLgortList(ArrayList<String> lgortList) {
		this.lgortList = lgortList;
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
	public String getInspn() {
		return inspn;
	}
	public void setInspn(String inspn) {
		this.inspn = inspn;
	}
	public void setWrkst(String wrkst) {
		this.wrkst = wrkst;
	}
	@Override
	public String toString() {
		return "SYStockVo [werks=" + werks + ", lgort=" + lgort + ", lifnr="
				+ lifnr + ", kunnr=" + kunnr + ", matnr=" + matnr + ", labst="
				+ labst + ", b_werk=" + b_werk + ", b_werks=" + b_werks
				+ ", b_lager=" + b_lager + ", lgort_nm=" + lgort_nm
				+ ", kdauf=" + kdauf + ", kdpos=" + kdpos + ", ps_psp_pnr="
				+ ps_psp_pnr + ", meins=" + meins + ", sernr=" + sernr
				+ ", sernp=" + sernp + ", creator=" + creator + ", updater="
				+ updater + ", matnrList=" + matnrList + ", lgortList="
				+ lgortList + "]";
	}

}
