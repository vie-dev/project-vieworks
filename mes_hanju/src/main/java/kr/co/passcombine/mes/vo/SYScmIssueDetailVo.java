package kr.co.passcombine.mes.vo;

import java.io.Serializable;

public class SYScmIssueDetailVo implements Serializable{

	private String level1_code;
	private String level2_code;
	private String level3_code;
	private String level1_name;
	private String level2_name;
	private String level3_name;
	private String gr_code;
	private String gr_nm;
	private String dept_cd;
	private String level_case;
	private String status;
	private String jsonStr;
	
	private String fault_no;
	private String fault_no_seq;
	
	private String fault_status;
	
	private String updater;
	
	
	public String getUpdater() {
		return updater;
	}
	public void setUpdater(String updater) {
		this.updater = updater;
	}
	public String getDate_updated() {
		return date_updated;
	}
	public void setDate_updated(String date_updated) {
		this.date_updated = date_updated;
	}
	private String date_updated;	
	
	
	public String getLevel1_code() {
		return level1_code;
	}
	public void setLevel1_code(String level1_code) {
		this.level1_code = level1_code;
	}
	public String getLevel2_code() {
		return level2_code;
	}
	public void setLevel2_code(String level2_code) {
		this.level2_code = level2_code;
	}
	public String getLevel3_code() {
		return level3_code;
	}
	public void setLevel3_code(String level3_code) {
		this.level3_code = level3_code;
	}
	public String getLevel1_name() {
		return level1_name;
	}
	public void setLevel1_name(String level1_name) {
		this.level1_name = level1_name;
	}
	public String getLevel2_name() {
		return level2_name;
	}
	public void setLevel2_name(String level2_name) {
		this.level2_name = level2_name;
	}
	public String getLevel3_name() {
		return level3_name;
	}
	public void setLevel3_name(String level3_name) {
		this.level3_name = level3_name;
	}
	public String getGr_code() {
		return gr_code;
	}
	public void setGr_code(String gr_code) {
		this.gr_code = gr_code;
	}
	public String getGr_nm() {
		return gr_nm;
	}
	public void setGr_nm(String gr_nm) {
		this.gr_nm = gr_nm;
	}
	public String getDept_cd() {
		return dept_cd;
	}
	public void setDept_cd(String dept_cd) {
		this.dept_cd = dept_cd;
	}
	public String getLevel_case() {
		return level_case;
	}
	public void setLevel_case(String level_case) {
		this.level_case = level_case;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getJsonStr() {
		return jsonStr;
	}
	public void setJsonStr(String jsonStr) {
		this.jsonStr = jsonStr;
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
	public String getFault_status() {
		return fault_status;
	}
	public void setFault_status(String fault_status) {
		this.fault_status = fault_status;
	}
	@Override
	public String toString() {
		return "SYScmIssueDetailVo [level1_code=" + level1_code
				+ ", level2_code=" + level2_code + ", level3_code="
				+ level3_code + ", level1_name=" + level1_name
				+ ", level2_name=" + level2_name + ", level3_name="
				+ level3_name + ", gr_code=" + gr_code + ", gr_nm=" + gr_nm
				+ "]";
	}
}
