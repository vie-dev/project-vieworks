package kr.co.passcombine.mes.vo;

import java.io.Serializable;
import java.util.ArrayList;

public class SYScmRawProcSubVo implements Serializable{

	private String ebeln;	//'구매문서번호',
	private String ebelp;	//'구매품목번호',
	private String matnr;	//'자재번호',
	private String maktx;	//'자재명',
	private String werks;	//'플랜트',
	private String werks_nm;	//'플랜트',
	private String lgort;	//'저장위치',
	private String bdmng;	//'소요량',
	private String meins;	//'기본단위',
	private String z1110_labst;	//'stock_의료',
	private String z1210_labst;	//'stock_영상',
	private String zvendor_sllab;	//'vendor_stock',
	private String rsnum;	// '예약/종속 소요량의 번호',
	private String rspos;	//'예약/종속 소요량에 대한 품목 번호',
	private String xloek;	//'삭제여부',
	private String sernp;	//시리얼 여부
	private String date_created;
	private String date_updated;
	
	
	public String getSernp() {
		return sernp;
	}
	public void setSernp(String sernp) {
		this.sernp = sernp;
	}
	public String getWerks_nm() {
		return werks_nm;
	}
	public void setWerks_nm(String werks_nm) {
		this.werks_nm = werks_nm;
	}
	public String getEbeln() {
		return ebeln;
	}
	public void setEbeln(String ebeln) {
		this.ebeln = ebeln;
	}
	public String getEbelp() {
		return ebelp;
	}
	public void setEbelp(String ebelp) {
		this.ebelp = ebelp;
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
	public String getWerks() {
		return werks;
	}
	public void setWerks(String werks) {
		this.werks = werks;
	}
	public String getLgort() {
		return lgort;
	}
	public void setLgort(String lgort) {
		this.lgort = lgort;
	}
	public String getBdmng() {
		return bdmng;
	}
	public void setBdmng(String bdmng) {
		this.bdmng = bdmng;
	}
	public String getMeins() {
		return meins;
	}
	public void setMeins(String meins) {
		this.meins = meins;
	}
	public String getZ1110_labst() {
		return z1110_labst;
	}
	public void setZ1110_labst(String z1110_labst) {
		this.z1110_labst = z1110_labst;
	}
	public String getZ1210_labst() {
		return z1210_labst;
	}
	public void setZ1210_labst(String z1210_labst) {
		this.z1210_labst = z1210_labst;
	}
	public String getZvendor_sllab() {
		return zvendor_sllab;
	}
	public void setZvendor_sllab(String zvendor_sllab) {
		this.zvendor_sllab = zvendor_sllab;
	}
	public String getRsnum() {
		return rsnum;
	}
	public void setRsnum(String rsnum) {
		this.rsnum = rsnum;
	}
	public String getRspos() {
		return rspos;
	}
	public void setRspos(String rspos) {
		this.rspos = rspos;
	}
	public String getXloek() {
		return xloek;
	}
	public void setXloek(String xloek) {
		this.xloek = xloek;
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
		return "SYScmRawProcSubVo [ebeln=" + ebeln + ", ebelp=" + ebelp
				+ ", matnr=" + matnr + ", maktx=" + maktx + ", werks=" + werks
				+ ", lgort=" + lgort + ", bdmng=" + bdmng + ", meins=" + meins
				+ ", z1110_labst=" + z1110_labst + ", z1210_labst="
				+ z1210_labst + ", zvendor_sllab=" + zvendor_sllab + ", rsnum="
				+ rsnum + ", rspos=" + rspos + ", xloek=" + xloek
				+ ", date_created=" + date_created + ", date_updated="
				+ date_updated + "]";
	}
}
