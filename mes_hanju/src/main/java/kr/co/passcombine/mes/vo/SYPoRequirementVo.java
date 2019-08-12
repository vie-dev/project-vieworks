package kr.co.passcombine.mes.vo;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class SYPoRequirementVo implements Serializable{
	
  private static final long serialVersionUID = 1L;
  
  private String aufnr;
//  private String zgubun;
  private String rspos;
  private String matnr;
  private String bdmng;
  private String meins;
  private String sernp;
  private String xloek;
  private String lgort;
  private String schgt;
  private String sortf;
  private String potx1;
  private String dumps;
  private String use_yn;
  private String creator;
  private String updater;
  private String date_created;
  private String date_updated;
  
  private String werks;
  private String dispo;
  private String zdispo;
  private String aennr;
  private String maktx;
  private String kzumw;
  
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
public String getDispo() {
	return dispo;
}
public void setDispo(String dispo) {
	this.dispo = dispo;
}
public String getZdispo() {
	return zdispo;
}
public void setZdispo(String zdispo) {
	this.zdispo = zdispo;
}
public String getAennr() {
	return aennr;
}
public void setAennr(String aennr) {
	this.aennr = aennr;
}
public static long getSerialversionuid() {
	return serialVersionUID;
}
	public String getLgort() {
	return lgort;
}
public void setLgort(String lgort) {
	this.lgort = lgort;
}
	public String getAufnr() {
		return aufnr;
	}
	public void setAufnr(String aufnr) {
		this.aufnr = aufnr;
	}
//	public String getZgubun() {
//		return zgubun;
//	}
//	public void setZgubun(String zgubun) {
//		this.zgubun = zgubun;
//	}
	public String getRspos() {
		return rspos;
	}
	public void setRspos(String rspos) {
		this.rspos = rspos;
	}
	public String getMatnr() {
		return matnr;
	}
	public void setMatnr(String matnr) {
		this.matnr = matnr;
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
	public String getSernp() {
		return sernp;
	}
	public void setSernp(String sernp) {
		this.sernp = sernp;
	}
	public String getXloek() {
		return xloek;
	}
	public void setXloek(String xloek) {
		this.xloek = xloek;
	}
	public String getSchgt() {
		return schgt;
	}
	public void setSchgt(String schgt) {
		this.schgt = schgt;
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
	public String getDumps() {
		return dumps;
	}
	public void setDumps(String dumps) {
		this.dumps = dumps;
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
	public String getKzumw() {
		return kzumw;
	}
	public void setKzumw(String kzumw) {
		this.kzumw = kzumw;
	}
	@Override
	public String toString() {
		return "SYPoRequirementVo [aufnr=" + aufnr + ", rspos=" + rspos
				+ ", matnr=" + matnr + ", bdmng=" + bdmng + ", meins=" + meins
				+ ", sernp=" + sernp + ", xloek=" + xloek + ", lgort=" + lgort
				+ ", schgt=" + schgt + ", sortf=" + sortf + ", potx1=" + potx1
				+ ", dumps=" + dumps + ", use_yn=" + use_yn + ", creator="
				+ creator + ", updater=" + updater + ", date_created="
				+ date_created + ", date_updated=" + date_updated + ", werks="
				+ werks + ", dispo=" + dispo + ", zdispo=" + zdispo
				+ ", aennr=" + aennr + ", maktx=" + maktx + "]";
	}
	
	
}
