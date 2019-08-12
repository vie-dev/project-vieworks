package kr.co.passcombine.mes.vo;

import java.io.Serializable;

public class SYMoveTypeVo implements Serializable{
	
	  private String bwart;
	  private String btext;
	  private String kostl;
	  private String aufnr;
	  
	public String getBwart() {
		return bwart;
	}
	public void setBwart(String bwart) {
		this.bwart = bwart;
	}
	public String getBtext() {
		return btext;
	}
	public void setBtext(String btext) {
		this.btext = btext;
	}
	public String getKostl() {
		return kostl;
	}
	public void setKostl(String kostl) {
		this.kostl = kostl;
	}
	public String getAufnr() {
		return aufnr;
	}
	public void setAufnr(String aufnr) {
		this.aufnr = aufnr;
	}
}
