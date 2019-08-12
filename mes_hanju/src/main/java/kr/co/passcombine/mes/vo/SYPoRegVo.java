package kr.co.passcombine.mes.vo;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class SYPoRegVo implements Serializable{
	
  private static final long serialVersionUID = 1L;

	private String posale_no;              // 주문번호		seq table이용해서 생성
	private int posale_seq;                // 주문번호 seq	auto_increment	auto_increment
	private String matnr;                  // 아이템 코드		
	private String maktx;                  // 아이템 명		
	private String posale_status;          // 수주 등록 확정 구분	DEFAULT "00"	00' 확정전  '01'확정' 
	private String delivery_status;        // 출하확정구분	DEFAULT "00"	00' 확정전  '01'확정' 
	private String lifnr;                  // 사업자번호		
	private String lifnr_nm;               // 납품처명		
	private String project_no;             // 프로젝트코드		
	private String project_nm;             // 프로젝트명		
	private String netwr;                  // 발주금액		
	private String project_menge;          // 수량		
	private String menge;                  // 주문번호기준 수량		
	private String meins;                  // 단위		
	private String remark;                 // 요구사항		
	private String plan_dt;                // 설계일자		
	private String eindt;                  // 완료일자		
	private String eindt_from;                  // 완료일자		
	private String eindt_to;                  // 완료일자		
	private String purdt;                  // 구매일자		
	private String jidat;                  // 지시일자		
	private String sedat;                  // 납품요청일		
	private String sedat_from;                  // 납품요청일		
	private String sedat_to;                  // 납품요청일		
	private String posale_dt;              // 주문등록일		
	private String posale_dt_from;              // 주문등록일		
	private String posale_dt_to;              // 주문등록일		
	private String file_group;             // 도면정보 key		*sy_file_info key
	private String creator;                // 생성자		
	private String updater;                // 수정자		
	private String date_created;           // 생성일자		
	private String date_updated;           // 수정일자
	
	private int page;
	private int rows;
	
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
	public String getPosale_status() {
		return posale_status;
	}
	public void setPosale_status(String posale_status) {
		this.posale_status = posale_status;
	}
	public String getDelivery_status() {
		return delivery_status;
	}
	public void setDelivery_status(String delivery_status) {
		this.delivery_status = delivery_status;
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
	public String getNetwr() {
		return netwr;
	}
	public void setNetwr(String netwr) {
		this.netwr = netwr;
	}
	public String getProject_menge() {
		return project_menge;
	}
	public void setProject_menge(String project_menge) {
		this.project_menge = project_menge;
	}
	public String getMenge() {
		return menge;
	}
	public void setMenge(String menge) {
		this.menge = menge;
	}
	public String getMeins() {
		return meins;
	}
	public void setMeins(String meins) {
		this.meins = meins;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public String getPlan_dt() {
		return plan_dt;
	}
	public void setPlan_dt(String plan_dt) {
		this.plan_dt = plan_dt;
	}
	public String getEindt() {
		return eindt;
	}
	public void setEindt(String eindt) {
		this.eindt = eindt;
	}
	public String getPurdt() {
		return purdt;
	}
	public void setPurdt(String purdt) {
		this.purdt = purdt;
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
	public String getPosale_dt() {
		return posale_dt;
	}
	public void setPosale_dt(String posale_dt) {
		this.posale_dt = posale_dt;
	}
	public String getFile_group() {
		return file_group;
	}
	public void setFile_group(String file_group) {
		this.file_group = file_group;
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
	public String getEindt_from() {
		return eindt_from;
	}
	public void setEindt_from(String eindt_from) {
		this.eindt_from = eindt_from;
	}
	public String getEindt_to() {
		return eindt_to;
	}
	public void setEindt_to(String eindt_to) {
		this.eindt_to = eindt_to;
	}
	public String getSedat_from() {
		return sedat_from;
	}
	public void setSedat_from(String sedat_from) {
		this.sedat_from = sedat_from;
	}
	public String getSedat_to() {
		return sedat_to;
	}
	public void setSedat_to(String sedat_to) {
		this.sedat_to = sedat_to;
	}
	public String getPosale_dt_from() {
		return posale_dt_from;
	}
	public void setPosale_dt_from(String posale_dt_from) {
		this.posale_dt_from = posale_dt_from;
	}
	public String getPosale_dt_to() {
		return posale_dt_to;
	}
	public void setPosale_dt_to(String posale_dt_to) {
		this.posale_dt_to = posale_dt_to;
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
	@Override
	public String toString() {
		return "SYPoRegVo [posale_no=" + posale_no + ", posale_seq="
				+ posale_seq + ", matnr=" + matnr + ", posale_status="
				+ posale_status + ", delivery_status=" + delivery_status
				+ ", lifnr=" + lifnr + ", lifnr_nm=" + lifnr_nm
				+ ", project_no=" + project_no + ", project_nm=" + project_nm
				+ ", netwr=" + netwr + ", project_menge=" + project_menge
				+ ", menge=" + menge + ", meins=" + meins + ", remark="
				+ remark + ", plan_dt=" + plan_dt + ", eindt=" + eindt
				+ ", eindt_from=" + eindt_from + ", eindt_to=" + eindt_to
				+ ", purdt=" + purdt + ", jidat=" + jidat + ", sedat=" + sedat
				+ ", sedat_from=" + sedat_from + ", sedat_to=" + sedat_to
				+ ", posale_dt=" + posale_dt + ", posale_dt_from="
				+ posale_dt_from + ", posale_dt_to=" + posale_dt_to
				+ ", file_group=" + file_group + ", creator=" + creator
				+ ", updater=" + updater + ", date_created=" + date_created
				+ ", date_updated=" + date_updated + ", page=" + page
				+ ", rows=" + rows + "]";
	}
	
}
