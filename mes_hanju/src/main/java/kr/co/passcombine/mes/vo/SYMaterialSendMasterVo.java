package kr.co.passcombine.mes.vo;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class SYMaterialSendMasterVo implements Serializable{
	
  private static final long serialVersionUID = 1L;
  
  private String zrequest_no;
  private String zseq;
  private String matnr;
  private String maktx;
  private String wrkst;
  private String meins;
  private String create_date;
  private String change_date;
  private String if_status;
  private String if_msg;
  
public String getZrequest_no() {
	return zrequest_no;
}
public void setZrequest_no(String zrequest_no) {
	this.zrequest_no = zrequest_no;
}
public String getZseq() {
	return zseq;
}
public void setZseq(String zseq) {
	this.zseq = zseq;
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
public String getWrkst() {
	return wrkst;
}
public void setWrkst(String wrkst) {
	this.wrkst = wrkst;
}
public String getMeins() {
	return meins;
}
public void setMeins(String meins) {
	this.meins = meins;
}
public String getCreate_date() {
	return create_date;
}
public void setCreate_date(String create_date) {
	this.create_date = create_date;
}
public String getChange_date() {
	return change_date;
}
public void setChange_date(String change_date) {
	this.change_date = change_date;
}
public String getIf_status() {
	return if_status;
}
public void setIf_status(String if_status) {
	this.if_status = if_status;
}
public String getIf_msg() {
	return if_msg;
}
public void setIf_msg(String if_msg) {
	this.if_msg = if_msg;
}
@Override
public String toString() {
	return "SYMaterialSendMasterVo [zrequest_no=" + zrequest_no + ", zseq="
			+ zseq + ", matnr=" + matnr + ", maktx=" + maktx + ", wrkst="
			+ wrkst + ", meins=" + meins + ", create_date=" + create_date
			+ ", change_date=" + change_date + ", if_status=" + if_status
			+ ", if_msg=" + if_msg + "]";
}
}
