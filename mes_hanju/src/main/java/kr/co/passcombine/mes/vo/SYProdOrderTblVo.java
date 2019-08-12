package kr.co.passcombine.mes.vo;

import java.io.Serializable;

public class SYProdOrderTblVo implements Serializable{
	
	private static final long serialVersionUID = 1L;
	
	private String pordno;           // 키		
	private int pordno_child;        // 자식키 기본 "10"		
	private String pdsts;            // 상태 코드 p1		p1' 지시, p2 확정,p3 작업시작, p4 비가동, p5 재가동 p6 종료 p7 재작업지시,p8 생산완료 p9 최종검사합격,p10 최종검사불합격,p11출하검사합격,p12 출하검사 불합격,p13 공정검사대기,p14 공정강제종료
	private String ji_gubun;         // default 'i1'		i1 일반 i2 긴급
	private String jidat;            // 지시일자		
	private String sedat;            // 예정일자		
	private String cmdat;            // 확정일		화면에서 확정일자 input 해야함.
	private String cmdat_seq;        // 확정 작업순서		
	private String itnbr;            // 품목코드		
	private String itnbr_spec;       // 품목spec		
	private String serno;            // 시리얼번호		
	private String sernp;            // 시리얼대상여부		
	private String dept_cd;          // 부서코드		
	private String project_no;       // 프로젝트코드		
	private String project_nm;       // 프로젝트name		
	private int pdqty;               // 수량		
	private String auart;            // 오더유형		prod'생산 'repr'재작업
	private String lgort;            // 창고		
	private String delivery_no;      // 출하계획번호		
	private String delivery_item;    // 		
	private String matnr;            // 		
	private String creator;          // 생성자		
	private String updater;          // 수정자		
	private String date_created;     // 생성일자		
	private String date_updated;     // 수정일자	
	
	public String getPordno() {
		return pordno;
	}
	public void setPordno(String pordno) {
		this.pordno = pordno;
	}
	public int getPordno_child() {
		return pordno_child;
	}
	public void setPordno_child(int pordno_child) {
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
	public String getProject_nm() {
		return project_nm;
	}
	public void setProject_nm(String project_nm) {
		this.project_nm = project_nm;
	}
	public int getPdqty() {
		return pdqty;
	}
	public void setPdqty(int pdqty) {
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
	public String getDelivery_no() {
		return delivery_no;
	}
	public void setDelivery_no(String delivery_no) {
		this.delivery_no = delivery_no;
	}
	public String getDelivery_item() {
		return delivery_item;
	}
	public void setDelivery_item(String delivery_item) {
		this.delivery_item = delivery_item;
	}
	public String getMatnr() {
		return matnr;
	}
	public void setMatnr(String matnr) {
		this.matnr = matnr;
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
}
