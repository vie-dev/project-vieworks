package kr.co.passcombine.mes.vo;

import java.io.Serializable;

public class SYHubRecvinspeVo implements Serializable{
	private String inspection_gcode;		//'검사그룹번호',
	private String inspection_gnm;		    //'검사그룹명',
	private String inspection_code;			//'검사리스트 코드',
	private String inspection_list;			//'검사항목명',
	private String inspection_standard;		//'검사기준명',
	private String inspection_value_max;	//'검사 수치 max 기준값',
	private String inspection_value_low;	//'검사 수치 low 기준값',
	private String inspection_remark;		//'검사 방법',
	
	private String inspection_remark_code;		//'검사 방법코드 ',
	
	public String getInspection_remark_code() {
		return inspection_remark_code;
	}

	public void setInspection_remark_code(String inspection_remark_code) {
		this.inspection_remark_code = inspection_remark_code;
	}

	private String dept_cd;					//'의료(1110,광1210)',
	private String dept_nm;					//'의료(1110,광1210)',
	private String use_yn;					//'사용유무',
	private String creator;					//'작성자',
	private String updater;					//'수정자',
	private String date_created;			//'생성일자',
	private String date_updated;			//'수정일자'
	//params
	private String gridData;
	private String matnr;
	private String maktx;
	private String wrkst;
	private int rows;
	private int page;
	private String sidx;
	private String sord;
	 
	
	 
	public String getSidx() {
		return sidx;
	}

	public void setSidx(String sidx) {
		this.sidx = sidx;
	}

	public String getSord() {
		return sord;
	}

	public void setSord(String sord) {
		this.sord = sord;
	}

	public String getWrkst() {
		return wrkst;
	}

	public void setWrkst(String wrkst) {
		this.wrkst = wrkst;
	}

	public String getInspection_gcode() {
		return inspection_gcode;
	}

	public void setInspection_gcode(String inspection_gcode) {
		this.inspection_gcode = inspection_gcode;
	}

	public String getInspection_gnm() {
		return inspection_gnm;
	}

	public void setInspection_gnm(String inspection_gnm) {
		this.inspection_gnm = inspection_gnm;
	}

	public String getInspection_code() {
		return inspection_code;
	}

	public void setInspection_code(String inspection_code) {
		this.inspection_code = inspection_code;
	}

	public String getInspection_list() {
		return inspection_list;
	}

	public void setInspection_list(String inspection_list) {
		this.inspection_list = inspection_list;
	}

	public String getInspection_standard() {
		return inspection_standard;
	}

	public void setInspection_standard(String inspection_standard) {
		this.inspection_standard = inspection_standard;
	}

	public String getInspection_value_max() {
		return inspection_value_max;
	}

	public void setInspection_value_max(String inspection_value_max) {
		this.inspection_value_max = inspection_value_max;
	}

	public String getInspection_value_low() {
		return inspection_value_low;
	}

	public void setInspection_value_low(String inspection_value_low) {
		this.inspection_value_low = inspection_value_low;
	}

	public String getInspection_remark() {
		return inspection_remark;
	}

	public void setInspection_remark(String inspection_remark) {
		this.inspection_remark = inspection_remark;
	}

	public String getDept_cd() {
		return dept_cd;
	}

	public void setDept_cd(String dept_cd) {
		this.dept_cd = dept_cd;
	}

	public String getDept_nm() {
		return dept_nm;
	}

	public void setDept_nm(String dept_nm) {
		this.dept_nm = dept_nm;
	}

	public String getUse_yn() {
		return use_yn;
	}

	public void setUse_yn(String use_yn) {
		this.use_yn = use_yn;
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

	public String getGridData() {
		return gridData;
	}

	public void setGridData(String gridData) {
		this.gridData = gridData;
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
		return "SYHubRecvinspeVo [inspection_gcode=" + inspection_gcode
				+ ", inspection_gnm=" + inspection_gnm + ", inspection_code=" + inspection_code
				+ ", inspection_list=" + inspection_list + ", inspection_standard="+ inspection_standard 
				+ ", inspection_value_max=" + inspection_value_max + ", inspection_value_low=" + inspection_value_low
				+ ", inspection_remark=" + inspection_remark + ", inspection_remark_code=" + inspection_remark_code
				+ ", dept_cd=" + dept_cd + ", dept_nm=" + dept_nm + ", use_yn=" + use_yn + ", creator="
				+ creator + ", updater=" + updater + ", date_created="
				+ date_created + ", date_updated=" + date_updated + "]";
	}
}
