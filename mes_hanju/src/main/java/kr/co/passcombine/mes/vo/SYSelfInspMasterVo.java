package kr.co.passcombine.mes.vo;

import java.io.Serializable;
import kr.co.passcombine.mes.util.SessionUtil;

public class SYSelfInspMasterVo implements Serializable{
	private String simaster_gr_no;
	private String simaster_seq;
	private String simaster_gr_nm;
	private String matnr;
	private String use_yn;
	private String creator;
	private String updater;
	private String date_created;
	private String date_updated;
	private String gubun;
	
	public String getSimaster_gr_no() {
		return simaster_gr_no;
	}
	public void setSimaster_gr_no(String simaster_gr_no) {
		this.simaster_gr_no = simaster_gr_no;
	}
	public String getSimaster_seq() {
		return simaster_seq;
	}
	public void setSimaster_seq(String simaster_seq) {
		this.simaster_seq = simaster_seq;
	}
	public String getSimaster_gr_nm() {
		return simaster_gr_nm;
	}
	public void setSimaster_gr_nm(String simaster_gr_nm) {
		this.simaster_gr_nm = simaster_gr_nm;
	}
	public String getMatnr() {
		return matnr;
	}
	public void setMatnr(String matnr) {
		this.matnr = matnr;
	}
	public String getUse_yn() {
		return use_yn;
	}
	public void setUse_yn(String use_yn) {
		this.use_yn = use_yn;
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
	public String getGubun() {
		return gubun;
	}
	public void setGubun(String gubun) {
		this.gubun = gubun;
	}
	@Override
	public String toString() {
		return "SYSelfInspMasterVo [simaster_gr_no=" + simaster_gr_no
				+ ", simaster_seq=" + simaster_seq + ", simaster_gr_nm="
				+ simaster_gr_nm + ", matnr=" + matnr + ", use_yn=" + use_yn
				+ ", creator=" + creator + ", updater=" + updater
				+ ", date_created=" + date_created + ", date_updated="
				+ date_updated + "]";
	}
}
