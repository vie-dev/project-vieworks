package kr.co.passcombine.mes.vo;

import java.io.Serializable;

public class SYShipmentHordTblVo implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String delivery_no;             // Dd/o 번호 (출하계획번호)		seq table이용해서 생성
	private int delivery_item;           // d/o seq	auto_increment	auto_increment
	private String delivery_nm;             // 출하계획명		
	private String delivery_remark;         // 출하계획 비고		
	private String delivery_total_menge;    // 전체 수량		
	private String delivery_status;         // 출하구분		"00" 출하계획확정 "01" 출하중 "02" 출하 완료  "03" 출하 계획취소
	private String prod_status;             // 생산 구분		"00"생산계획 미정 "01" 생산계획 확정 "02" 생산중 "03" 생산완료
	private String sedat;                   // 납품요청일		
	private String delivery_dt;             // 출하예정일		
	private String posale_no;               // 주문번호		po_Reg 참고
	private int posale_seq;              // 주문번호 seq		po_Reg 참고
	private String posale_dt;               // 주문등록일		
	private String project_no;              // 프로젝트코드		
	private String project_nm;              // 프로젝트명		
	private String lgort;                   // 저장위치		
	private String lgobe;                   // 저장위치명		
	private String car_no;                  // 배차차량번호		
	private String driver_nm;               // 배차차량 기사명		
	private String driver_phone;            // 배창 기사 전화번호		
	private String lifnr;                   // 사업자번호		
	private String lifnr_nm;                // 납품처명		
	private String creator;                 // 생성자		
	private String updater;                 // 수정자		
	private String date_created;            // 생성일자		
	private String date_updated;            // 수정일자		
	
	private int page;
	private int rows;
	
	public String getDelivery_no() {
		return delivery_no;
	}
	public void setDelivery_no(String delivery_no) {
		this.delivery_no = delivery_no;
	}
	public int getDelivery_item() {
		return delivery_item;
	}
	public void setDelivery_item(int delivery_item) {
		this.delivery_item = delivery_item;
	}
	public String getDelivery_nm() {
		return delivery_nm;
	}
	public void setDelivery_nm(String delivery_nm) {
		this.delivery_nm = delivery_nm;
	}
	public String getDelivery_remark() {
		return delivery_remark;
	}
	public void setDelivery_remark(String delivery_remark) {
		this.delivery_remark = delivery_remark;
	}
	public String getDelivery_total_menge() {
		return delivery_total_menge;
	}
	public void setDelivery_total_menge(String delivery_total_menge) {
		this.delivery_total_menge = delivery_total_menge;
	}
	public String getDelivery_status() {
		return delivery_status;
	}
	public void setDelivery_status(String delivery_status) {
		this.delivery_status = delivery_status;
	}
	public String getProd_status() {
		return prod_status;
	}
	public void setProd_status(String prod_status) {
		this.prod_status = prod_status;
	}
	public String getSedat() {
		return sedat;
	}
	public void setSedat(String sedat) {
		this.sedat = sedat;
	}
	public String getDelivery_dt() {
		return delivery_dt;
	}
	public void setDelivery_dt(String delivery_dt) {
		this.delivery_dt = delivery_dt;
	}
	public String getPosale_no() {
		return posale_no;
	}
	public void setPosale_no(String posale_no) {
		this.posale_no = posale_no;
	}
	public int getPosale_seq() {
		return posale_seq;
	}
	public void setPosale_seq(int posale_seq) {
		this.posale_seq = posale_seq;
	}
	public String getPosale_dt() {
		return posale_dt;
	}
	public void setPosale_dt(String posale_dt) {
		this.posale_dt = posale_dt;
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
	public String getLgort() {
		return lgort;
	}
	public void setLgort(String lgort) {
		this.lgort = lgort;
	}
	public String getLgobe() {
		return lgobe;
	}
	public void setLgobe(String lgobe) {
		this.lgobe = lgobe;
	}
	public String getCar_no() {
		return car_no;
	}
	public void setCar_no(String car_no) {
		this.car_no = car_no;
	}
	public String getDriver_nm() {
		return driver_nm;
	}
	public void setDriver_nm(String driver_nm) {
		this.driver_nm = driver_nm;
	}
	public String getDriver_phone() {
		return driver_phone;
	}
	public void setDriver_phone(String driver_phone) {
		this.driver_phone = driver_phone;
	}
	public String getLifnr() {
		return lifnr;
	}
	public void setLifnr(String lifnr) {
		this.lifnr = lifnr;
	}
	public String getLifnr_nm() {
		return lifnr_nm;
	}
	public void setLifnr_nm(String lifnr_nm) {
		this.lifnr_nm = lifnr_nm;
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
