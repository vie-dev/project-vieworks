package kr.co.passcombine.mes.vo;

import java.io.Serializable;

public class SYHubItnbrVo implements Serializable{
	private String routing_gno;
	private String itnbr;		//'품목코드',
	private String itnbr_nm;		//'품목명',
	private String itnbr_spec;		//'spec',
	private String normat;		//
	private String create_date;		//
	private String change_date;		//
	
	public void setItnbr(String itnbr) {
		this.itnbr = itnbr;
	}
	public void setItnbr_nm(String itnbr_nm) {
		this.itnbr_nm = itnbr_nm;
	}
	public void setItnbr_spec(String itnbr_spec) {
		this.itnbr_spec = itnbr_spec;
	}
	public void setNormat(String normat) {
		this.normat = normat;
	}
	public void setCreate_date(String create_date) {
		this.create_date = create_date;
	}
	public void setChange_date(String change_date) {
		this.change_date = change_date;
	}
	public void setRouting_gno(String routing_gno) {
		this.routing_gno = routing_gno;
	}
	public String getItnbr() {
		return itnbr;
	}
	public String getItnbr_nm() {
		return itnbr_nm;
	}
	public String getItnbr_spec() {
		return itnbr_spec;
	}
	public String getNormat() {
		return normat;
	}
	public String getCreate_date() {
		return create_date;
	}
	public String getChange_date() {
		return change_date;
	}
	public String getRouting_gno() {
		return routing_gno;
	}
	@Override
	public String toString() {
		return "SYHubItnbrVo [itnbr=" + itnbr + ", itnbr_nm=" + itnbr_nm + ", routing_gno=" + routing_gno
				+ ", itnbr_spec=" + itnbr_spec + ", normat=" + normat
				+ ", create_date=" + create_date + ", change_date="
				+ change_date + "]";
	}
 }
    