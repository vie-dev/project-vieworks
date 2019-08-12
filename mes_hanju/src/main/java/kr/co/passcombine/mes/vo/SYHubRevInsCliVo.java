package kr.co.passcombine.mes.vo;

import java.io.Serializable;

public class SYHubRevInsCliVo implements Serializable{
	// table column name
	private String rvmaster_gr_code;	// 그룹코드
	private String rvdetail_code;		// level2 key
	private String rvdetail_seq;		//
	private String detail_name;			// 상세명
	private String detail_dscr;			// 상세dscr
	private String matnr;				// 품목코드
	private String matnr_sub;			// sub품목코드
	private String matnr_rev;			// sub품목 rev num
	private String matnr_nm;			// 품목명
	private String inspection_item;		// 검사항목
	private String inspection_standard;	// 검사기준
	private String inspection_method;	// 검사방법
	private String vendor_code;			// vendor code
	private String vendor_name;			// vendor name
	private String use_yn;				// 사용유무
	private String creator;				// 작성자
	private String updater;				// 수정자
	private String create_date;			// 제정일
	private String update_date;			// 개정일
	private String date_created;		// 생성일자
	private String date_updated;		// 수정일자
	public String getRvmaster_gr_code() {
		return rvmaster_gr_code;
	}
	public void setRvmaster_gr_code(String rvmaster_gr_code) {
		this.rvmaster_gr_code = rvmaster_gr_code;
	}
	public String getRvdetail_code() {
		return rvdetail_code;
	}
	public void setRvdetail_code(String rvdetail_code) {
		this.rvdetail_code = rvdetail_code;
	}
	public String getRvdetail_seq() {
		return rvdetail_seq;
	}
	public void setRvdetail_seq(String rvdetail_seq) {
		this.rvdetail_seq = rvdetail_seq;
	}
	public String getDetail_name() {
		return detail_name;
	}
	public void setDetail_name(String detail_name) {
		this.detail_name = detail_name;
	}
	public String getDetail_dscr() {
		return detail_dscr;
	}
	public void setDetail_dscr(String detail_dscr) {
		this.detail_dscr = detail_dscr;
	}
	public String getMatnr() {
		return matnr;
	}
	public void setMatnr(String matnr) {
		this.matnr = matnr;
	}
	public String getMatnr_sub() {
		return matnr_sub;
	}
	public void setMatnr_sub(String matnr_sub) {
		this.matnr_sub = matnr_sub;
	}
	public String getMatnr_rev() {
		return matnr_rev;
	}
	public void setMatnr_rev(String matnr_rev) {
		this.matnr_rev = matnr_rev;
	}
	public String getMatnr_nm() {
		return matnr_nm;
	}
	public void setMatnr_nm(String matnr_nm) {
		this.matnr_nm = matnr_nm;
	}
	public String getInspection_item() {
		return inspection_item;
	}
	public void setInspection_item(String inspection_item) {
		this.inspection_item = inspection_item;
	}
	public String getInspection_standard() {
		return inspection_standard;
	}
	public void setInspection_standard(String inspection_standard) {
		this.inspection_standard = inspection_standard;
	}
	public String getInspection_method() {
		return inspection_method;
	}
	public void setInspection_method(String inspection_method) {
		this.inspection_method = inspection_method;
	}
	public String getVendor_code() {
		return vendor_code;
	}
	public void setVendor_code(String vendor_code) {
		this.vendor_code = vendor_code;
	}
	public String getVendor_name() {
		return vendor_name;
	}
	public void setVendor_name(String vendor_name) {
		this.vendor_name = vendor_name;
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
	public String getCreate_date() {
		return create_date;
	}
	public void setCreate_date(String create_date) {
		this.create_date = create_date;
	}
	public String getUpdate_date() {
		return update_date;
	}
	public void setUpdate_date(String update_date) {
		this.update_date = update_date;
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
	@Override
	public String toString() {
		return "SYHubRevInsCliVo [rvmaster_gr_code=" + rvmaster_gr_code
				+ ", rvdetail_code=" + rvdetail_code + ", rvdetail_seq="
				+ rvdetail_seq + ", detail_name=" + detail_name
				+ ", detail_dscr=" + detail_dscr + ", matnr=" + matnr
				+ ", matnr_sub=" + matnr_sub + ", matnr_rev=" + matnr_rev
				+ ", matnr_nm=" + matnr_nm + ", inspection_item="
				+ inspection_item + ", inspection_standard="
				+ inspection_standard + ", inspection_method="
				+ inspection_method + ", vendor_code=" + vendor_code
				+ ", vendor_name=" + vendor_name + ", use_yn=" + use_yn
				+ ", creator=" + creator + ", updater=" + updater
				+ ", create_date=" + create_date + ", update_date="
				+ update_date + ", date_created=" + date_created
				+ ", date_updated=" + date_updated + "]";
	}
}
