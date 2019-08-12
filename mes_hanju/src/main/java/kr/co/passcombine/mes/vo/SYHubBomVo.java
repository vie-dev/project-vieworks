package kr.co.passcombine.mes.vo;

import java.io.Serializable;
import java.util.HashMap;
import java.util.Map;

public class SYHubBomVo implements Serializable{
	private String matnr;
	private String werks;		//
	private String stlan;		//'
	private String stlal;		//'
	private String stufe;		//
	private String maktx;		//
	private String idnrk;		//
	private String ojtxp;
	private String menge;		//'
	private String meins;		//'
	private String sortf;		//'
	private String potx1;		//
	private String schgt;		//
	private String mschg;		//
	private String sobsl;
	private String sobsk;		//'
	private String sernp;		//'
	private String datuv;		//'
	private String aennr;		//
	private String datub;		//
	private String aenra;		//
	private String jidat;		//
	private String iv_date;		//
	private String return_status;		//
	private String return_count;		//
	private String zmatnr;		//
	private String zmaktx;		//
	 
	
	public String getZmatnr() {
		return zmatnr;
	}
	public void setZmatnr(String zmatnr) {
		this.zmatnr = zmatnr;
	}
	public String getZmaktx() {
		return zmaktx;
	}
	public void setZmaktx(String zmaktx) {
		this.zmaktx = zmaktx;
	}

 
	private int page;
	private int rows;
	public String getMatnr() {
		return matnr;
	}
	public void setMatnr(String matnr) {
		this.matnr = matnr;
	}
	public String getWerks() {
		return werks;
	}
	public void setWerks(String werks) {
		this.werks = werks;
	}
	public String getStlan() {
		return stlan;
	}
	public void setStlan(String stlan) {
		this.stlan = stlan;
	}
	public String getStlal() {
		return stlal;
	}
	public void setStlal(String stlal) {
		this.stlal = stlal;
	}
	public String getStufe() {
		return stufe;
	}
	public void setStufe(String stufe) {
		this.stufe = stufe;
	}
	public String getMaktx() {
		return maktx;
	}
	public void setMaktx(String maktx) {
		this.maktx = maktx;
	}
	public String getIdnrk() {
		return idnrk;
	}
	public void setIdnrk(String idnrk) {
		this.idnrk = idnrk;
	}
	public String getOjtxp() {
		return ojtxp;
	}
	public void setOjtxp(String ojtxp) {
		this.ojtxp = ojtxp;
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
	public String getSortf() {
		return sortf;
	}
	public void setSortf(String sortf) {
		this.sortf = sortf;
	}
	public String getPotx1() {
		return potx1;
	}
	public void setPotx1(String potx1) {
		this.potx1 = potx1;
	}
	public String getSchgt() {
		return schgt;
	}
	public void setSchgt(String schgt) {
		this.schgt = schgt;
	}
	public String getMschg() {
		return mschg;
	}
	public void setMschg(String mschg) {
		this.mschg = mschg;
	}
	public String getSobsl() {
		return sobsl;
	}
	public void setSobsl(String sobsl) {
		this.sobsl = sobsl;
	}
	public String getSobsk() {
		return sobsk;
	}
	public void setSobsk(String sobsk) {
		this.sobsk = sobsk;
	}
	public String getSernp() {
		return sernp;
	}
	public void setSernp(String sernp) {
		this.sernp = sernp;
	}
	public String getDatuv() {
		return datuv;
	}
	public void setDatuv(String datuv) {
		this.datuv = datuv;
	}
	public String getAennr() {
		return aennr;
	}
	public void setAennr(String aennr) {
		this.aennr = aennr;
	}
	public String getDatub() {
		return datub;
	}
	public void setDatub(String datub) {
		this.datub = datub;
	}
	public String getAenra() {
		return aenra;
	}
	public void setAenra(String aenra) {
		this.aenra = aenra;
	}
	public String getJidat() {
		return jidat;
	}
	public void setJidat(String jidat) {
		this.jidat = jidat;
	}
	public String getIv_date() {
		return iv_date;
	}
	public void setIv_date(String iv_date) {
		this.iv_date = iv_date;
	}
	public String getReturn_status() {
		return return_status;
	}
	public void setReturn_status(String return_status) {
		this.return_status = return_status;
	}
	public String getReturn_count() {
		return return_count;
	}
	public void setReturn_count(String return_count) {
		this.return_count = return_count;
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
		return "SYHubBomVo [matnr=" + matnr + ", werks=" + werks + ", stlan="
				+ stlan + ", stlal=" + stlal + ", stufe=" + stufe + ", maktx="
				+ maktx + ", idnrk=" + idnrk + ", ojtxp=" + ojtxp + ", menge="
				+ menge + ", meins=" + meins + ", sortf=" + sortf + ", potx1="
				+ potx1 + ", schgt=" + schgt + ", mschg=" + mschg + ", sobsl="
				+ sobsl + ", sobsk=" + sobsk + ", sernp=" + sernp + ", datuv="
				+ datuv + ", aennr=" + aennr + ", datub=" + datub + ", aenra="
				+ aenra + ", jidat=" + jidat + ", iv_date=" + iv_date
				+ ", return_status=" + return_status + ", return_count="
				+ return_count + ", page=" + page + ", rows=" + rows + "]";
	}
	
 }
    