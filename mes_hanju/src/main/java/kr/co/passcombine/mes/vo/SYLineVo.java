package kr.co.passcombine.mes.vo;

import java.io.Serializable;
import java.util.HashMap;
import java.util.Map;

public class SYLineVo implements Serializable{
	
	private static final long serialVersionUID = 1L;
	
	private String jocod;
	private String dept_cd;
	private String dept_nm;
	private String line_nm;
	private String jo_nm;
	private String member_id;
	private String member_nm;
	private String use_yn;
	
	private String creator;
	private String updater;
	
	
	private int page;
	private int rows;
	
	
	 
	
	public String getJocod() {
		return jocod;
	}
	public void setJocod(String jocod) {
		this.jocod = jocod;
	}
	public String getDept_cd() {
		return dept_cd;
	}
	public void setDept_cd(String dept_cd) {
		this.dept_cd = dept_cd;
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
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public String getMember_nm() {
		return member_nm;
	}
	public void setMember_nm(String member_nm) {
		this.member_nm = member_nm;
	}
	public String getUse_yn() {
		return use_yn;
	}
	public void setUse_yn(String use_yn) {
		this.use_yn = use_yn;
	}
	@Override
	public String toString() {
		return "SYLineVo [jocod=" + jocod + ", dept_cd=" + dept_cd
				+ ", dept_nm=" + dept_nm + ", line_nm=" + line_nm + ", jo_nm="
				+ jo_nm + ", member_id=" + member_id + ", member_nm="
				+ member_nm + ", use_yn=" + use_yn + ", creator=" + creator
				+ ", updater=" + updater + ", page=" + page + ", rows=" + rows
				+ "]";
	}
	public String getDept_nm() {
		return dept_nm;
	}
	public void setDept_nm(String dept_nm) {
		this.dept_nm = dept_nm;
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
	  
}
