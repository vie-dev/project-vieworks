package kr.co.passcombine.mes.vo;

import java.io.Serializable;
import java.util.ArrayList;

public class SYCodeVo implements Serializable{
	
  private static final long serialVersionUID = 1L;
	
  private String cmd;
  private String master_code;
  private String detail_code;
  private String code_nm;
  private String code_nm_en;
  private String code_dscr;
  private String code_order;
  private String code_use_yn;
  private String filter1_val;
  private String filter2_val;
  private String filter3_val;
  private String date_created;
  private String date_updated;
  private String creator;
  private String updater;
  
  private ArrayList<String> grpCodeList;
  private String grp_code;
  
  	private String mcode_nm; 
  	private String mcode_nm_en; 
  	private String mref_1;
	private String mref_2;
	private String mref_3;
	private String dcode_nm;
	private String dcode_nm_en;
	private String dref_1;
	private String dref_2;
	private String dref_3;
  
	public String getCmd() {
		return cmd;
	}
	public void setCmd(String cmd) {
		this.cmd = cmd;
	}
	public String getMaster_code() {
		return master_code;
	}
	public void setMaster_code(String master_code) {
		this.master_code = master_code;
	}
	public String getDetail_code() {
		return detail_code;
	}
	public void setDetail_code(String detail_code) {
		this.detail_code = detail_code;
	}
	public String getCode_nm() {
		return code_nm;
	}
	public void setCode_nm(String code_nm) {
		this.code_nm = code_nm;
	}
	public String getCode_nm_en() {
		return code_nm_en;
	}
	public void setCode_nm_en(String code_nm_en) {
		this.code_nm_en = code_nm_en;
	}
	public String getCode_dscr() {
		return code_dscr;
	}
	public void setCode_dscr(String code_dscr) {
		this.code_dscr = code_dscr;
	}
	public String getCode_order() {
		return code_order;
	}
	public void setCode_order(String code_order) {
		this.code_order = code_order;
	}
	public String getCode_use_yn() {
		return code_use_yn;
	}
	public void setCode_use_yn(String code_use_yn) {
		this.code_use_yn = code_use_yn;
	}
	public String getFilter1_val() {
		return filter1_val;
	}
	public void setFilter1_val(String filter1_val) {
		this.filter1_val = filter1_val;
	}
	public String getFilter2_val() {
		return filter2_val;
	}
	public void setFilter2_val(String filter2_val) {
		this.filter2_val = filter2_val;
	}
	public String getFilter3_val() {
		return filter3_val;
	}
	public void setFilter3_val(String filter3_val) {
		this.filter3_val = filter3_val;
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
	public ArrayList<String> getGrpCodeList() {
		return grpCodeList;
	}
	public void setGrpCodeList(ArrayList<String> grpCodeList) {
		this.grpCodeList = grpCodeList;
	}
	public String getGrp_code() {
		return grp_code;
	}
	public void setGrp_code(String grp_code) {
		this.grp_code = grp_code;
	}
	public String getMcode_nm() {
		return mcode_nm;
	}
	public void setMcode_nm(String mcode_nm) {
		this.mcode_nm = mcode_nm;
	}
	public String getMcode_nm_en() {
		return mcode_nm_en;
	}
	public void setMcode_nm_en(String mcode_nm_en) {
		this.mcode_nm_en = mcode_nm_en;
	}
	public String getMref_1() {
		return mref_1;
	}
	public void setMref_1(String mref_1) {
		this.mref_1 = mref_1;
	}
	public String getMref_2() {
		return mref_2;
	}
	public void setMref_2(String mref_2) {
		this.mref_2 = mref_2;
	}
	public String getMref_3() {
		return mref_3;
	}
	public void setMref_3(String mref_3) {
		this.mref_3 = mref_3;
	}
	public String getDcode_nm() {
		return dcode_nm;
	}
	public void setDcode_nm(String dcode_nm) {
		this.dcode_nm = dcode_nm;
	}
	public String getDcode_nm_en() {
		return dcode_nm_en;
	}
	public void setDcode_nm_en(String dcode_nm_en) {
		this.dcode_nm_en = dcode_nm_en;
	}
	public String getDref_1() {
		return dref_1;
	}
	public void setDref_1(String dref_1) {
		this.dref_1 = dref_1;
	}
	public String getDref_2() {
		return dref_2;
	}
	public void setDref_2(String dref_2) {
		this.dref_2 = dref_2;
	}
	public String getDref_3() {
		return dref_3;
	}
	public void setDref_3(String dref_3) {
		this.dref_3 = dref_3;
	}
}
