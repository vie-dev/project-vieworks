package kr.co.passcombine.mes.vo;

import java.io.Serializable;
import java.util.HashMap;
import java.util.Map;

public class SYDmrFwVo implements Serializable{
	private String gr_no;
	private String gr_seq;
	private String fw_seq;
	private String gr_nm;
	private String fw_gubun;
	private String fw_type;
	private String fw_info;
	private String creator;
	private String updater;
	private String date_created;
	private String date_updated;
	
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
	public String getFw_seq() {
		return fw_seq;
	}
	public void setFw_seq(String fw_seq) {
		this.fw_seq = fw_seq;
	}
	public String getGr_nm() {
		return gr_nm;
	}
	public void setGr_nm(String gr_nm) {
		this.gr_nm = gr_nm;
	}
	public String getFw_gubun() {
		return fw_gubun;
	}
	public void setFw_gubun(String fw_gubun) {
		this.fw_gubun = fw_gubun;
	}
	public String getFw_type() {
		return fw_type;
	}
	public void setFw_type(String fw_type) {
		this.fw_type = fw_type;
	}
	public String getFw_info() {
		return fw_info;
	}
	public void setFw_info(String fw_info) {
		this.fw_info = fw_info;
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
		return "SYDmrFwVo [gr_no=" + gr_no + ", gr_seq=" + gr_seq + ", fw_seq="
				+ fw_seq + ", gr_nm=" + gr_nm + ", fw_gubun=" + fw_gubun
				+ ", fw_type=" + fw_type + ", fw_info=" + fw_info
				+ ", creator=" + creator + ", updater=" + updater
				+ ", date_created=" + date_created + ", date_updated="
				+ date_updated + "]";
	}
}
