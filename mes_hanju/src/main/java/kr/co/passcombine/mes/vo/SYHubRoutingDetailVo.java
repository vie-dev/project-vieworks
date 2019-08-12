package kr.co.passcombine.mes.vo;

import java.io.Serializable;

public class SYHubRoutingDetailVo implements Serializable{
	private String routing_gno;		//라우팅그룹번호',
	private String matnr;			//'품목코드',
	private String maktx;			//'품목명',
	private String itnbr_spec;		//
	private String use_yn;			//'사용유무',
	private String creator;			//'작성자',
	private String updater;			//'수정자',
	private String date_created;	//'생성일자',
	private String date_updated;	//'수정일자',
	// params
	private String gridData;
	private String itnbr;
	
	private String routing_gno_gubun;   //포장라우팅 구분 
	
	
	public String getRouting_gno_gubun() {
		return routing_gno_gubun;
	}
	public void setRouting_gno_gubun(String routing_gno_gubun) {
		this.routing_gno_gubun = routing_gno_gubun;
	}
	public String getItnbr() {
		return itnbr;
	}
	public void setItnbr(String itnbr) {
		this.itnbr = itnbr;
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
	public void setRouting_gno(String routing_gno) {
		this.routing_gno = routing_gno;
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
	public void setGridData(String gridData) {
		this.gridData = gridData;
	}
	public void setItnbr_spec(String itnbr_spec) {
		this.itnbr_spec = itnbr_spec;
	}
	public String getRouting_gno() {
		return routing_gno;
	}
	public String getItnbr_spec() {
		return itnbr_spec;
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
	@Override
	public String toString() {
		return "SYHubRoutingDetailVo [routing_gno=" + routing_gno + ", matnr="
				+ matnr + ", maktx=" + maktx + ", itnbr_spec=" + itnbr_spec
				+ ", use_yn=" + use_yn + ", creator=" + creator + ", updater="
				+ updater + ", date_created=" + date_created
				+ ", date_updated=" + date_updated + ", gridData=" + gridData
				+ ", itnbr=" + itnbr + ", routing_gno_gubun="
				+ routing_gno_gubun + "]";
	}
	
}
