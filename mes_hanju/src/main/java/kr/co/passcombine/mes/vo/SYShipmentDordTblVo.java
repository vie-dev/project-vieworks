package kr.co.passcombine.mes.vo;

import java.io.Serializable;

public class SYShipmentDordTblVo implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private String delivery_no;
	private String delivery_item;
	private String matnr;
	private String matnr_nm;
	private String item_check_status;
	private String sernp;
	private String delivery_menge;
	private String sedat;
	private String delivery_dt;
	private String posale_dt;
	private String creator;
	private String updater;
	private String date_created;
	private String date_updated;
	
	public String getDelivery_no() {
		return delivery_no;
	}
	public void setDelivery_no(String delivery_no) {
		this.delivery_no = delivery_no;
	}
	public String getDelivery_item() {
		return delivery_item;
	}
	public void setDelivery_item(String delivery_item) {
		this.delivery_item = delivery_item;
	}
	public String getMatnr() {
		return matnr;
	}
	public void setMatnr(String matnr) {
		this.matnr = matnr;
	}
	public String getMatnr_nm() {
		return matnr_nm;
	}
	public void setMatnr_nm(String matnr_nm) {
		this.matnr_nm = matnr_nm;
	}
	public String getItem_check_status() {
		return item_check_status;
	}
	public void setItem_check_status(String item_check_status) {
		this.item_check_status = item_check_status;
	}
	public String getSernp() {
		return sernp;
	}
	public void setSernp(String sernp) {
		this.sernp = sernp;
	}
	public String getDelivery_menge() {
		return delivery_menge;
	}
	public void setDelivery_menge(String delivery_menge) {
		this.delivery_menge = delivery_menge;
	}
	public String getSedat() {
		return sedat;
	}
	public void setSedat(String sedat) {
		this.sedat = sedat;
	}
	public String getDelivery_dt() {
		return delivery_dt;
	}
	public void setDelivery_dt(String delivery_dt) {
		this.delivery_dt = delivery_dt;
	}
	public String getPosale_dt() {
		return posale_dt;
	}
	public void setPosale_dt(String posale_dt) {
		this.posale_dt = posale_dt;
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
}
