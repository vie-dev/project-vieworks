package kr.co.passcombine.mes.vo;

import java.io.Serializable;

public class SYMaterialMasVo implements Serializable{
	
	private static final long serialVersionUID = 5725777751063126307L;
	
	private String matnr;            // 자재코드
	private String mtart;            // 자재유형
	private String meins;            // 기본단위
	private String maktx;            // 자재내역
	private String wrkst;            // Spec&Dimension
	private String lvorm;            // 삭제표시
	private String kzumw;            // 등급관리여부
	private String iloos;            // 검사여부
	private String ihivi;            // 입고후검사
	private String brgew;            // 총중량
	private String ntgew;            // 순중량
	private String gewei;            // 중량단위
	private String wgbez;            // 자재그룹명
	private String price;            // 가격
	private int bdmg;
	private String updater;          // 수정자
	private String creator;          // 
	private String date_created;		// 생성일자
	private String date_updated;     // 수정일자
	
	private int page;
	private int rows;
	
	public String getMatnr() {
		return matnr;
	}
	public void setMatnr(String matnr) {
		this.matnr = matnr;
	}
	public String getMtart() {
		return mtart;
	}
	public void setMtart(String mtart) {
		this.mtart = mtart;
	}
	public String getMeins() {
		return meins;
	}
	public void setMeins(String meins) {
		this.meins = meins;
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
	public String getLvorm() {
		return lvorm;
	}
	public void setLvorm(String lvorm) {
		this.lvorm = lvorm;
	}
	public String getKzumw() {
		return kzumw;
	}
	public void setKzumw(String kzumw) {
		this.kzumw = kzumw;
	}
	public String getIloos() {
		return iloos;
	}
	public void setIloos(String iloos) {
		this.iloos = iloos;
	}
	public String getIhivi() {
		return ihivi;
	}
	public void setIhivi(String ihivi) {
		this.ihivi = ihivi;
	}
	public String getBrgew() {
		return brgew;
	}
	public void setBrgew(String brgew) {
		this.brgew = brgew;
	}
	public String getNtgew() {
		return ntgew;
	}
	public void setNtgew(String ntgew) {
		this.ntgew = ntgew;
	}
	public String getGewei() {
		return gewei;
	}
	public void setGewei(String gewei) {
		this.gewei = gewei;
	}
	public String getWgbez() {
		return wgbez;
	}
	public void setWgbez(String wgbez) {
		this.wgbez = wgbez;
	}
	public String getUpdater() {
		return updater;
	}
	public void setUpdater(String updater) {
		this.updater = updater;
	}
	public String getCreator() {
		return creator;
	}
	public void setCreator(String creator) {
		this.creator = creator;
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
	public String getPrice() {
		return price;
	}
	public void setPrice(String price) {
		this.price = price;
	}
	public int getBdmg() {
		return bdmg;
	}
	public void setBdmg(int bdmg) {
		this.bdmg = bdmg;
	}
}
