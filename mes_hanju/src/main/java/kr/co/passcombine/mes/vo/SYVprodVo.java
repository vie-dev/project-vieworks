
package kr.co.passcombine.mes.vo;

import java.io.Serializable;
import java.util.ArrayList;

public class SYVprodVo implements Serializable{
	
	private static final long serialVersionUID = 1L;
	
	
	private String vpordno;
	private String vpdsts;
	private String vreg_date;
	private String matnr;
	private String maktx;
	private String menge;
	private String sernr;
	private String confirm_yn;
	private String confirm_user_nm;
	private String delivery_yn;
	private String del_yn;
	private String date_created;
	private String date_updated;
	private String wrkst;
	private String dept_cd;
	private String lifnr;
	private ArrayList<String> list;
	private String equnr;
	
	private String name1;
	private String pdqty;
	private String werks;
	
	private int page;
	private int rows;
	  
	private String sidx;
	private String sord;
	
	private String creator;
	private String updater;
	
	private String f_date;
	private String t_date;
	
	private String gr_no;
	private String gr_seq;
	
	public String getVpordno() {
		return vpordno;
	}
	public void setVpordno(String vpordno) {
		this.vpordno = vpordno;
	}
	public String getVpdsts() {
		return vpdsts;
	}
	public void setVpdsts(String vpdsts) {
		this.vpdsts = vpdsts;
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
	public String getMenge() {
		return menge;
	}
	public void setMenge(String menge) {
		this.menge = menge;
	}
	public String getSernr() {
		return sernr;
	}
	public void setSernr(String sernr) {
		this.sernr = sernr;
	}
	public String getConfirm_yn() {
		return confirm_yn;
	}
	public void setConfirm_yn(String confirm_yn) {
		this.confirm_yn = confirm_yn;
	}
	public String getConfirm_user_nm() {
		return confirm_user_nm;
	}
	public void setConfirm_user_nm(String confirm_user_nm) {
		this.confirm_user_nm = confirm_user_nm;
	}
	public String getDelivery_yn() {
		return delivery_yn;
	}
	public void setDelivery_yn(String delivery_yn) {
		this.delivery_yn = delivery_yn;
	}
	public String getDel_yn() {
		return del_yn;
	}
	public void setDel_yn(String del_yn) {
		this.del_yn = del_yn;
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
	public String getPdqty() {
		return pdqty;
	}
	public void setPdqty(String pdqty) {
		this.pdqty = pdqty;
	}
	public String getWerks() {
		return werks;
	}
	public void setWerks(String werks) {
		this.werks = werks;
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
	public String getVreg_date() {
		return vreg_date;
	}
	public void setVreg_date(String vreg_date) {
		this.vreg_date = vreg_date;
	}
	public String getWrkst() {
		return wrkst;
	}
	public void setWrkst(String wrkst) {
		this.wrkst = wrkst;
	}
	public String getDept_cd() {
		return dept_cd;
	}
	public void setDept_cd(String dept_cd) {
		this.dept_cd = dept_cd;
	}
	public String getLifnr() {
		return lifnr;
	}
	public void setLifnr(String lifnr) {
		this.lifnr = lifnr;
	}
	public ArrayList<String> getList() {
		return list;
	}
	public void setList(ArrayList<String> list) {
		this.list = list;
	}
	public String getName1() {
		return name1;
	}
	public void setName1(String name1) {
		this.name1 = name1;
	}
	public String getEqunr() {
		return equnr;
	}
	public void setEqunr(String equnr) {
		this.equnr = equnr;
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
}
