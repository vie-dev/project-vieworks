package kr.co.passcombine.mes.vo;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class SYProdTblVo implements Serializable{
	
	private static final long serialVersionUID = 1L;
	
	private String pordno;           //키
	private long pordno_child;     //자식키 기본 "10"
	private String pdsts;            //상태 코드 p1
	private String ji_gubun;         //
	private String jidat;            //지시일자
	private String f_jidat;
	private String t_jidat;
	private String sedat;            //예정일자
	private String cmdat;            //확정일
	private String cmdat_seq;        //확정 작업순서
	private String itnbr;            //품목코드
	private String itnbr_spec;       //품목spec
	private String serno;            //시리얼번호
	private String sernp;            //시리얼대상여부
	private String dept_cd;          //부서코드
	private String project_no;       //프로젝트코드
	private long pdqty;            //수량
	private String auart;            //오더유형
	private String lgort;            //창고
	private String creator;          //생성자
	private String updater;          //수정자
	private String date_created;     //생성일자
	private String date_updated;     //수정일자
	
	public String getPordno() {
		return pordno;
	}
	public void setPordno(String pordno) {
		this.pordno = pordno;
	}
	public long getPordno_child() {
		return pordno_child;
	}
	public void setPordno_child(long pordno_child) {
		this.pordno_child = pordno_child;
	}
	public String getPdsts() {
		return pdsts;
	}
	public void setPdsts(String pdsts) {
		this.pdsts = pdsts;
	}
	public String getJi_gubun() {
		return ji_gubun;
	}
	public void setJi_gubun(String ji_gubun) {
		this.ji_gubun = ji_gubun;
	}
	public String getJidat() {
		return jidat;
	}
	public void setJidat(String jidat) {
		this.jidat = jidat;
	}
	public String getSedat() {
		return sedat;
	}
	public void setSedat(String sedat) {
		this.sedat = sedat;
	}
	public String getCmdat() {
		return cmdat;
	}
	public void setCmdat(String cmdat) {
		this.cmdat = cmdat;
	}
	public String getCmdat_seq() {
		return cmdat_seq;
	}
	public void setCmdat_seq(String cmdat_seq) {
		this.cmdat_seq = cmdat_seq;
	}
	public String getItnbr() {
		return itnbr;
	}
	public void setItnbr(String itnbr) {
		this.itnbr = itnbr;
	}
	public String getItnbr_spec() {
		return itnbr_spec;
	}
	public void setItnbr_spec(String itnbr_spec) {
		this.itnbr_spec = itnbr_spec;
	}
	public String getSerno() {
		return serno;
	}
	public void setSerno(String serno) {
		this.serno = serno;
	}
	public String getSernp() {
		return sernp;
	}
	public void setSernp(String sernp) {
		this.sernp = sernp;
	}
	public String getDept_cd() {
		return dept_cd;
	}
	public void setDept_cd(String dept_cd) {
		this.dept_cd = dept_cd;
	}
	public String getProject_no() {
		return project_no;
	}
	public void setProject_no(String project_no) {
		this.project_no = project_no;
	}
	public long getPdqty() {
		return pdqty;
	}
	public void setPdqty(long pdqty) {
		this.pdqty = pdqty;
	}
	public String getAuart() {
		return auart;
	}
	public void setAuart(String auart) {
		this.auart = auart;
	}
	public String getLgort() {
		return lgort;
	}
	public void setLgort(String lgort) {
		this.lgort = lgort;
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
	public String getF_jidat() {
		return f_jidat;
	}
	public void setF_jidat(String f_jidat) {
		this.f_jidat = f_jidat;
	}
	public String getT_jidat() {
		return t_jidat;
	}
	public void setT_jidat(String t_jidat) {
		this.t_jidat = t_jidat;
	}
}
