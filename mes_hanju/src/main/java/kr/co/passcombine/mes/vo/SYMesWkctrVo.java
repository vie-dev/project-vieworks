package kr.co.passcombine.mes.vo;

import java.io.Serializable;
import java.util.HashMap;
import java.util.Map;

public class SYMesWkctrVo implements Serializable{
	
	private static final long serialVersionUID = 1L;
	
	private String dept_cd;
	private String wkctr;
	private String lgort;
	private String use_yn;
	
	
	public String getDept_cd() {
		return dept_cd;
	}
	public void setDept_cd(String dept_cd) {
		this.dept_cd = dept_cd;
	}
	public String getWkctr() {
		return wkctr;
	}
	public void setWkctr(String wkctr) {
		this.wkctr = wkctr;
	}
	public String getLgort() {
		return lgort;
	}
	public void setLgort(String lgort) {
		this.lgort = lgort;
	}
	public String getUse_yn() {
		return use_yn;
	}
	public void setUse_yn(String use_yn) {
		this.use_yn = use_yn;
	}
	
	 
}
