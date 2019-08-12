package kr.co.passcombine.mes.vo;

import java.io.Serializable;
import kr.co.passcombine.mes.util.SessionUtil;

public class SYSelfInspDetailVo implements Serializable{
	private String pordno;	
	private String simaster_gr_no;	//'마스터 gr코드',
	private String sidetail_seq;	//'deatil seq',
	private String sidetail_code;	//0',
	private String dept_cd;	//사업부코드',
	private String display_seq;	//'Display 순번',
	private String routing_code;	//'공정 매핑 코드',
	private String routing_code_sub;	//'공정 매핑 코드',
	private String minsp_name;	//'메인 name',
	private String sinsp_name;	//'sub name',
	private String insp_standard;	//'검사기준',
	private String insp_value;	//'측정값',
	private String insp_state;	//'i2=> ok   i3 =>NG',
	private String member_emp_no;	//'검사작업자사번',
	private String member_nm;	//'검사작업자명',
	private String work_date;	//'작업일시',
	private String use_yn;	//'Y\' 사용 \'N\' 미사용',
	private String remark;	// 비고
	private String creator;	//'생성자',
	private String updater;	//'수정자',
	private String date_created;	//'tabl;e 생성일시',
	private String date_updated;	//'table 수정일시',
	
	public String getPordno() {
		return pordno;
	}
	public void setPordno(String pordno) {
		this.pordno = pordno;
	}
	public String getSimaster_gr_no() {
		return simaster_gr_no;
	}
	public void setSimaster_gr_no(String simaster_gr_no) {
		this.simaster_gr_no = simaster_gr_no;
	}
	public String getSidetail_seq() {
		return sidetail_seq;
	}
	public void setSidetail_seq(String sidetail_seq) {
		this.sidetail_seq = sidetail_seq;
	}
	public String getSidetail_code() {
		return sidetail_code;
	}
	public void setSidetail_code(String sidetail_code) {
		this.sidetail_code = sidetail_code;
	}
	public String getDept_cd() {
		return dept_cd;
	}
	public void setDept_cd(String dept_cd) {
		this.dept_cd = dept_cd;
	}
	public String getDisplay_seq() {
		return display_seq;
	}
	public void setDisplay_seq(String display_seq) {
		this.display_seq = display_seq;
	}
	public String getRouting_code() {
		return routing_code;
	}
	public void setRouting_code(String routing_code) {
		this.routing_code = routing_code;
	}
	public String getRouting_code_sub() {
		return routing_code_sub;
	}
	public void setRouting_code_sub(String routing_code_sub) {
		this.routing_code_sub = routing_code_sub;
	}
	public String getMinsp_name() {
		return minsp_name;
	}
	public void setMinsp_name(String minsp_name) {
		this.minsp_name = minsp_name;
	}
	public String getSinsp_name() {
		return sinsp_name;
	}
	public void setSinsp_name(String sinsp_name) {
		this.sinsp_name = sinsp_name;
	}
	public String getInsp_standard() {
		return insp_standard;
	}
	public void setInsp_standard(String insp_standard) {
		this.insp_standard = insp_standard;
	}
	public String getInsp_value() {
		return insp_value;
	}
	public void setInsp_value(String insp_value) {
		this.insp_value = insp_value;
	}
	public String getInsp_state() {
		return insp_state;
	}
	public void setInsp_state(String insp_state) {
		this.insp_state = insp_state;
	}
	public String getMember_emp_no() {
		return member_emp_no;
	}
	public void setMember_emp_no(String member_emp_no) {
		this.member_emp_no = member_emp_no;
	}
	public String getMember_nm() {
		return member_nm;
	}
	public void setMember_nm(String member_nm) {
		this.member_nm = member_nm;
	}
	public String getWork_date() {
		return work_date;
	}
	public void setWork_date(String work_date) {
		this.work_date = work_date;
	}
	public String getUse_yn() {
		return use_yn;
	}
	public void setUse_yn(String use_yn) {
		this.use_yn = use_yn;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
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
	@Override
	public String toString() {
		return "SYSelfInspDetailVo [simaster_gr_no=" + simaster_gr_no
				+ ", sidetail_seq=" + sidetail_seq + ", sidetail_code="
				+ sidetail_code + ", dept_cd=" + dept_cd + ", display_seq="
				+ display_seq + ", routing_code=" + routing_code
				+ ", minsp_name=" + minsp_name + ", sinsp_name=" + sinsp_name
				+ ", insp_standard=" + insp_standard + ", insp_value="
				+ insp_value + ", insp_state=" + insp_state
				+ ", member_emp_no=" + member_emp_no + ", member_nm="
				+ member_nm + ", work_date=" + work_date + ", use_yn=" + use_yn
				+ ", creator=" + creator + ", updater=" + updater
				+ ", date_created=" + date_created + ", date_updated="
				+ date_updated + "]";
	}
}
