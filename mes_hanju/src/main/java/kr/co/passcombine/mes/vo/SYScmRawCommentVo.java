package kr.co.passcombine.mes.vo;

import java.io.Serializable;

public class SYScmRawCommentVo implements Serializable{
	private String ebeln;	//구매문서번호',
	private String ebelp;	//'구매문서품목번호',
	private String partial_seq;	//'partial 순번',
	private String comment_seq;	
	private String order_delivery_date;	//
	private String vendor_delivery_date;	//
	private String comment;
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
	public String getPartial_seq() {
		return partial_seq;
	}
	public void setPartial_seq(String partial_seq) {
		this.partial_seq = partial_seq;
	}
	public String getComment_seq() {
		return comment_seq;
	}
	public void setComment_seq(String comment_seq) {
		this.comment_seq = comment_seq;
	}
	public String getOrder_delivery_date() {
		return order_delivery_date;
	}
	public void setOrder_delivery_date(String order_delivery_date) {
		this.order_delivery_date = order_delivery_date;
	}
	public String getVendor_delivery_date() {
		return vendor_delivery_date;
	}
	public void setVendor_delivery_date(String vendor_delivery_date) {
		this.vendor_delivery_date = vendor_delivery_date;
	}
	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}
	@Override
	public String toString() {
		return "SYScmRawCommentVo [ebeln=" + ebeln + ", ebelp=" + ebelp
				+ ", partial_seq=" + partial_seq + ", comment_seq="
				+ comment_seq + ", order_delivery_date=" + order_delivery_date
				+ ", vendor_delivery_date=" + vendor_delivery_date
				+ ", comment=" + comment + "]";
	}
}
