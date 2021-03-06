package kr.co.passcombine.mes.vo;

import java.io.Serializable;

public class SYScmRawSernrVo implements Serializable{
	/*
	private String raw_num;			// '발주번호',
	private String raw_seq;	//'발주번호seq',
	private String sernr;	//'시리얼번호',
	private String matnr;				// '자재번호',
	private String matnr_nm;			// '자재명',
	private String spec;				// '규격',
	private String order_qty;	//'실제vendor 수량',
	private String real_qty;	//'실제vendor 수량',
	private String if_status;	//'SAP RFC 전송상태',
	private String if_msg;		// 'SAP RFC 전송메세지 '
	private String use_yn;
	private String creator ;			//
	private String updater ;			//
	private String date_created ;		//
	private String date_updated ;		//
	*/
	private String ebeln;		//'구매문서번호',
	private String ebelp;		//'구매문서품목번호',
	private String equnr;		//'시리얼번호',
	private String matnr;		//'자재번호',
	private String partial_seq;		//'partial일경우 raw_vendor_result parial key',
	private String txz01;		//'내역',
	private String zdeli_menge;		//'실제vendor처리수량',
	private String b_werks;		//'플랜트',
	private String b_lager;		//'저장위치',
	private String if_status;	//'SAP RFC 전송상태',
	private String if_msg;		//'SAP RFC 전송메세지 ',
	private String use_yn;		//DEFAULT 'Y' COMMENT '사용유무',
	private String creator;
	private String updater;
	private String date_created;
	private String date_updated;
	
	private String labnr;
	
	/*
	`pordno_pop` VARCHAR(16) NOT NULL COMMENT 'MES 내부 KEY',
	`sernr_seq` BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT '시리얼관리 seq',
	`pordno` VARCHAR(12) NULL DEFAULT NULL COMMENT 'sap po key',
	`routing_gno` VARCHAR(30) NULL DEFAULT NULL,
	`routing_no` VARCHAR(3) NULL DEFAULT NULL,
	`matnr` CHAR(40) NULL DEFAULT NULL COMMENT '자재번호',
	`menge` DECIMAL(15,3) NULL DEFAULT NULL COMMENT '출고수량',
	`meins` CHAR(50) NULL DEFAULT NULL COMMENT '단위',
	`budat` DATE NULL DEFAULT NULL COMMENT '출고일',
	`sernr` CHAR(18) NULL DEFAULT NULL COMMENT '시리얼번호',
	`use_yn` CHAR(1) NULL DEFAULT 'Y' COMMENT '사용여부',
	`use_memo` VARCHAR(200) NULL DEFAULT 'Y' COMMENT '비사용사유',
	`if_status` CHAR(1) NULL DEFAULT 'N' COMMENT '전송상태(RFC전송완료 \'Y\',오류 E)',
	`if_msg` VARCHAR(200) NULL DEFAULT NULL COMMENT '전송오류 \'E\' 상태 RFC 오류 메시지',
	`creator` VARCHAR(30) NULL DEFAULT NULL,
	`updater` VARCHAR(30) NULL DEFAULT NULL,
	`date_created` DATETIME NOT NULL,
	`date_updated` DATETIME NOT NULL,
	 * */
	// params
	private String jidat_from;
	private String jidat_to;
	private String gridData;
	private String masRow;
	
	private String jsonStr_params_header;
	private String jsonStr_params_data;
	
	
	public String getLabnr() {
		return labnr;
	}
	public void setLabnr(String labnr) {
		this.labnr = labnr;
	}
	public String getMasRow() {
		return masRow;
	}
	public void setMasRow(String masRow) {
		this.masRow = masRow;
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
	public String getEqunr() {
		return equnr;
	}
	public void setEqunr(String equnr) {
		this.equnr = equnr;
	}
	public String getMatnr() {
		return matnr;
	}
	public void setMatnr(String matnr) {
		this.matnr = matnr;
	}
	public String getPartial_seq() {
		return partial_seq;
	}
	public void setPartial_seq(String partial_seq) {
		this.partial_seq = partial_seq;
	}
	public String getTxz01() {
		return txz01;
	}
	public void setTxz01(String txz01) {
		this.txz01 = txz01;
	}
	public String getZdeli_menge() {
		return zdeli_menge;
	}
	public void setZdeli_menge(String zdeli_menge) {
		this.zdeli_menge = zdeli_menge;
	}
	public String getB_werks() {
		return b_werks;
	}
	public void setB_werks(String b_werks) {
		this.b_werks = b_werks;
	}
	public String getB_lager() {
		return b_lager;
	}
	public void setB_lager(String b_lager) {
		this.b_lager = b_lager;
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
	public String getJidat_from() {
		return jidat_from;
	}
	public void setJidat_from(String jidat_from) {
		this.jidat_from = jidat_from;
	}
	public String getJidat_to() {
		return jidat_to;
	}
	public void setJidat_to(String jidat_to) {
		this.jidat_to = jidat_to;
	}
	public String getGridData() {
		return gridData;
	}
	public void setGridData(String gridData) {
		this.gridData = gridData;
	}
	public String getJsonStr_params_header() {
		return jsonStr_params_header;
	}
	public void setJsonStr_params_header(String jsonStr_params_header) {
		this.jsonStr_params_header = jsonStr_params_header;
	}
	public String getJsonStr_params_data() {
		return jsonStr_params_data;
	}
	public void setJsonStr_params_data(String jsonStr_params_data) {
		this.jsonStr_params_data = jsonStr_params_data;
	}
	@Override
	public String toString() {
		return "SYScmRawSernrVo [ebeln=" + ebeln + ", ebelp=" + ebelp
				+ ", equnr=" + equnr + ", matnr=" + matnr + ", partial_seq="
				+ partial_seq + ", txz01=" + txz01 + ", zdeli_menge="
				+ zdeli_menge + ", b_werks=" + b_werks + ", b_lager=" + b_lager
				+ ", if_status=" + if_status + ", if_msg=" + if_msg
				+ ", use_yn=" + use_yn + ", creator=" + creator + ", updater="
				+ updater + ", date_created=" + date_created
				+ ", date_updated=" + date_updated + ", jidat_from="
				+ jidat_from + ", jidat_to=" + jidat_to + ", gridData="
				+ gridData + ", jsonStr_params_header=" + jsonStr_params_header
				+ ", jsonStr_params_data=" + jsonStr_params_data + "]";
	}
}
