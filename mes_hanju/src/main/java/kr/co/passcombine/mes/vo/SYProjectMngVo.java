package kr.co.passcombine.mes.vo;

import java.io.Serializable;
import java.util.ArrayList;

public class SYProjectMngVo implements Serializable{
	
	private static final long serialVersionUID = 1L;

	private String lifnr;                // 사업자번호
	private String lifnr_nm;			// 사업자명
	private String project_no;          // 프로젝트코드
	private String project_division;     // 구분
	private String project_nm;           // 프로젝트명
	private String netwr;                // 발주금액
	private String menge;                // 수량
	private String zdue_menge;           // 잔량
	private String meins;              // 단위
	private String remark;               // 요구사항
	private String success_yn;           // 완료유무
	private String plan_dt;              // 설계일자
	private String eindt;                // 완료일자
	private String purdt;                // 구매일자
	private String file_group;           // 도면정보 key
	private String creator;              // 생성자
	private String updater;              // 수정자
	private String date_created;         // 생성일자
	private String date_updated;         // 수정일자
	
	private int page;
	private int rows;
	
	public String getLifnr() {
		return lifnr;
	}
	public void setLifnr(String lifnr) {
		this.lifnr = lifnr;
	}
	public String getProject_no() {
		return project_no;
	}
	public void setProject_no(String project_no) {
		this.project_no = project_no;
	}
	public String getProject_division() {
		return project_division;
	}
	public void setProject_division(String project_division) {
		this.project_division = project_division;
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
	public String getMenge() {
		return menge;
	}
	public void setMenge(String menge) {
		this.menge = menge;
	}
	public String getZdue_menge() {
		return zdue_menge;
	}
	public void setZdue_menge(String zdue_menge) {
		this.zdue_menge = zdue_menge;
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
	public String getSuccess_yn() {
		return success_yn;
	}
	public void setSuccess_yn(String success_yn) {
		this.success_yn = success_yn;
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
	public String getLifnr_nm() {
		return lifnr_nm;
	}
	public void setLifnr_nm(String lifnr_nm) {
		this.lifnr_nm = lifnr_nm;
	}
}
