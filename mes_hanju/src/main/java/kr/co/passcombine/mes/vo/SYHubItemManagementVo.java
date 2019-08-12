package kr.co.passcombine.mes.vo;

import java.io.Serializable;
import java.util.ArrayList;

public class SYHubItemManagementVo implements Serializable{
	private String zrequest_no;
	private String zseq;
	private String matnr;
	private String maktx;
	private String wrkst;
	private String meins;
	private String zcreate_flag;
	private String zcms_history;
	private String crdat;
	private String crtim;
	private String crusr;
	
	private String grid_items_data; 
	
	private String creator;
	private String updater;
	
	public String getZrequest_no() {
		return zrequest_no;
	}
	public void setZrequest_no(String zrequest_no) {
		this.zrequest_no = zrequest_no;
	}
	public String getZseq() {
		return zseq;
	}
	public void setZseq(String zseq) {
		this.zseq = zseq;
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
	public String getZcreate_flag() {
		return zcreate_flag;
	}
	public void setZcreate_flag(String zcreate_flag) {
		this.zcreate_flag = zcreate_flag;
	}
	public String getZcms_history() {
		return zcms_history;
	}
	public void setZcms_history(String zcms_history) {
		this.zcms_history = zcms_history;
	}
	public String getCrdat() {
		return crdat;
	}
	public void setCrdat(String crdat) {
		this.crdat = crdat;
	}
	public String getCrtim() {
		return crtim;
	}
	public void setCrtim(String crtim) {
		this.crtim = crtim;
	}
	public String getCrusr() {
		return crusr;
	}
	public void setCrusr(String crusr) {
		this.crusr = crusr;
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
	public String getGrid_items_data() {
		return grid_items_data;
	}
	public void setGrid_items_data(String grid_items_data) {
		this.grid_items_data = grid_items_data;
	}	
}
