package kr.co.passcombine.mes.vo;

import java.io.Serializable;
import java.util.ArrayList;

public class SYShipmentSernrVo implements Serializable{
	
	private static final long serialVersionUID = 1L;
	
	private String vbeln;
	private String posnr;
	private String matnr;
	private String shipment_seq;
	private String sernr;
	private String mng;
	private String ukey;
	
	public String getUkey() {
		return ukey;
	}
	public void setUkey(String ukey) {
		this.ukey = ukey;
	}
	public String getVbeln() {
		return vbeln;
	}
	public void setVbeln(String vbeln) {
		this.vbeln = vbeln;
	}
	public String getPosnr() {
		return posnr;
	}
	public void setPosnr(String posnr) {
		this.posnr = posnr;
	}
	public String getMatnr() {
		return matnr;
	}
	public void setMatnr(String matnr) {
		this.matnr = matnr;
	}
	public String getShipment_seq() {
		return shipment_seq;
	}
	public void setShipment_seq(String shipment_seq) {
		this.shipment_seq = shipment_seq;
	}
	public String getSernr() {
		return sernr;
	}
	public void setSernr(String sernr) {
		this.sernr = sernr;
	}
	public String getMng() {
		return mng;
	}
	public void setMng(String mng) {
		this.mng = mng;
	}
	@Override
	public String toString() {
		return "SYShipmentSernrVo [vbeln=" + vbeln + ", posnr=" + posnr
				+ ", matnr=" + matnr + ", shipment_seq=" + shipment_seq
				+ ", sernr=" + sernr + ", mng=" + mng + "]";
	}
	
}
