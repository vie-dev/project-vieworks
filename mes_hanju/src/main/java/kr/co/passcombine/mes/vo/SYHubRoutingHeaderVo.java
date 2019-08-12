package kr.co.passcombine.mes.vo;

import java.io.Serializable;

public class SYHubRoutingHeaderVo implements Serializable{
	private String routing_gno;		//'라우팅그룹번호',
	private String routing_no;		//'공정라우팅SEQ',
	private String routing_gnm;		//'라우팅그룹명',
	private String routing_code;	//'공정라우팅code',
	private String routing_dscr;	//'공정라우팅dscr',
	private String routing_gubun;	//'P생산,S자주검사,Q품질.C출하',
	private String routing_gubunnm;	//'P생산,S자주검사,Q품질.C출하',
	private String dept_cd;			//'의료(1110,광1210)',
	private String dept_nm;			//'의료(1110,광1210)',
	private String use_yn;			//'사용유무',
	private String creator;			//'작성자',
	private String updater;			//'수정자',
	private String date_created;	//'생성일자',
	private String date_updated;	//수정일자',
	
	private String routing_plast_gubun;	//실적포인트 ',
	private String routing_gno_gubun;	//포장 양산 라우팅 구분 ',
	private String routing_gno_gubun_nm;	//포장 양산 라우팅 구분명 ',
	
	private String itnbr;
	private String itnbr_nm;
	
	private String deletecheck;      //그룹삭제시 detail 삭제
	
	public String getRouting_dscr() {
		return routing_dscr;
	}
	public void setRouting_dscr(String routing_dscr) {
		this.routing_dscr = routing_dscr;
	}
	public String getItnbr() {
		return itnbr;
	}
	public void setItnbr(String itnbr) {
		this.itnbr = itnbr;
	}
	public String getItnbr_nm() {
		return itnbr_nm;
	}
	public void setItnbr_nm(String itnbr_nm) {
		this.itnbr_nm = itnbr_nm;
	}
	public String getDeletecheck() {
		return deletecheck;
	}
	public void setDeletecheck(String deletecheck) {
		this.deletecheck = deletecheck;
	}
	public String getRouting_plast_gubun() {
		return routing_plast_gubun;
	}
	public void setRouting_plast_gubun(String routing_plast_gubun) {
		this.routing_plast_gubun = routing_plast_gubun;
	}
	//params
	private String gridData;
	
	public void setRouting_gno(String routing_gno) {
		this.routing_gno = routing_gno;
	}
	public void setRouting_no(String routing_no) {
		this.routing_no = routing_no;
	}
	public void setRouting_gnm(String routing_gnm) {
		this.routing_gnm = routing_gnm;
	}
	public void setRouting_code(String routing_code) {
		this.routing_code = routing_code;
	}
	public void setRouting_gubun(String routing_gubun) {
		this.routing_gubun = routing_gubun;
	}
	public void setRouting_gubunnm(String routing_gubunnm) {
		this.routing_gubunnm = routing_gubunnm;
	}
	public void setDept_cd(String dept_cd) {
		this.dept_cd = dept_cd;
	}
	public void setDept_nm(String dept_nm) {
		this.dept_nm = dept_nm;
	}
	public void setUse_yn(String use_yn) {
		this.use_yn = use_yn;
	}
	public void setCreator(String creator) {
		this.creator = creator;
	}
	public void setUpdater(String updater) {
		this.updater = updater;
	}
	public void setDate_created(String date_created) {
		this.date_created = date_created;
	}
	public void setDate_updated(String date_updated) {
		this.date_updated = date_updated;
	}
	public String getRouting_gno() {
		return routing_gno;
	}
	public String getRouting_no() {
		return routing_no;
	}
	public String getRouting_gnm() {
		return routing_gnm;
	}
	public String getRouting_code() {
		return routing_code;
	}
	public String getRouting_gubun() {
		return routing_gubun;
	}
	public String getRouting_gubunnm() {
		return routing_gubunnm;
	}
	public String getDept_cd() {
		return dept_cd;
	}
	public String getDept_nm() {
		return dept_nm;
	}
	public String getUse_yn() {
		return use_yn;
	}
	public String getCreator() {
		return creator;
	}
	public String getUpdater() {
		return updater;
	}
	public String getDate_created() {
		return date_created;
	}
	public String getDate_updated() {
		return date_updated;
	}
	
	public String getGridData() {
		return gridData;
	}
	public void setGridData(String gridData) {
		this.gridData = gridData;
	}
 
	public String getRouting_gno_gubun() {
		return routing_gno_gubun;
	}
	public void setRouting_gno_gubun(String routing_gno_gubun) {
		this.routing_gno_gubun = routing_gno_gubun;
	}
	public String getRouting_gno_gubun_nm() {
		return routing_gno_gubun_nm;
	}
	public void setRouting_gno_gubun_nm(String routing_gno_gubun_nm) {
		this.routing_gno_gubun_nm = routing_gno_gubun_nm;
	}
	@Override
	public String toString() {
		return "SYHubRoutingHeaderVo [routing_gno=" + routing_gno
				+ ", routing_no=" + routing_no + ", routing_gnm=" + routing_gnm
				+ ", routing_code=" + routing_code + ", routing_dscr="
				+ routing_dscr + ", routing_gubun=" + routing_gubun
				+ ", routing_gubunnm=" + routing_gubunnm + ", dept_cd="
				+ dept_cd + ", dept_nm=" + dept_nm + ", use_yn=" + use_yn
				+ ", creator=" + creator + ", updater=" + updater
				+ ", date_created=" + date_created + ", date_updated="
				+ date_updated + ", routing_plast_gubun=" + routing_plast_gubun
				+ ", routing_gno_gubun=" + routing_gno_gubun
				+ ", routing_gno_gubun_nm=" + routing_gno_gubun_nm
				+ ", deletecheck=" + deletecheck + ", gridData=" + gridData
				+ "]";
	}
	
}
