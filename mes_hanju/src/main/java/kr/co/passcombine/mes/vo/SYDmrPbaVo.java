package kr.co.passcombine.mes.vo;

import java.io.Serializable;
import java.util.HashMap;
import java.util.Map;

public class SYDmrPbaVo implements Serializable{
	private String gr_no;
	private String gr_seq;
	private String pba_seq;
	private String gr_nm;
	private String pba_gubun;
	private String pba_matnr;
	private String pba_maktx;
	private String pba_wrkst;
	private String creator;
	private String updater;
	private String date_created;
	private String date_updated;
	
	private String params;
	
	public String getParams() {
		return params;
	}
	public void setParams(String params) {
		this.params = params;
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
	public String getPba_seq() {
		return pba_seq;
	}
	public void setPba_seq(String pba_seq) {
		this.pba_seq = pba_seq;
	}
	public String getGr_nm() {
		return gr_nm;
	}
	public void setGr_nm(String gr_nm) {
		this.gr_nm = gr_nm;
	}
	public String getPba_gubun() {
		return pba_gubun;
	}
	public void setPba_gubun(String pba_gubun) {
		this.pba_gubun = pba_gubun;
	}
	public String getPba_matnr() {
		return pba_matnr;
	}
	public void setPba_matnr(String pba_matnr) {
		this.pba_matnr = pba_matnr;
	}
	public String getPba_maktx() {
		return pba_maktx;
	}
	public void setPba_maktx(String pba_maktx) {
		this.pba_maktx = pba_maktx;
	}
	public String getPba_wrkst() {
		return pba_wrkst;
	}
	public void setPba_wrkst(String pba_wrkst) {
		this.pba_wrkst = pba_wrkst;
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
	@Override
	public String toString() {
		return "SYDmrPbaVo [gr_no=" + gr_no + ", gr_seq=" + gr_seq
				+ ", pba_seq=" + pba_seq + ", gr_nm=" + gr_nm + ", pba_gubun="
				+ pba_gubun + ", pba_matnr=" + pba_matnr + ", pba_maktx="
				+ pba_maktx + ", pba_wrkst=" + pba_wrkst + ", creator="
				+ creator + ", updater=" + updater + ", date_created="
				+ date_created + ", date_updated=" + date_updated + "]";
	}
}
