package kr.co.passcombine.mes.vo;

import java.io.Serializable;
import java.util.ArrayList;

public class SYScmRawDeliveryVo implements Serializable{
	/*
	private String matnr;				// '자재번호',
	private String matnr_nm;			// '자재명',
	private String spec;				// '규격',
	private String raw_num;			// '발주번호',
	private String order_qty;			// '발주수량',
	private String unit_price;			// '단가',
	private String provided_value ;		// '공급가액',
	private String tax_amout ;			// '세액',
	private String sum_money ;			// '합계금액',
	private String temp1 ;				//
	private String rorder_status ;		// '납품관리/입하 상태	1.   VENDOR 미확인 		2.VENDOR 확인 		3.입하전	4.입하완료/미입고	4.입고완료',
	private String rorder_status_nm;
	private String rvendor_status ;		// '"납품관리VENDOR 상태\\\\n"	1.입하전	2.입하완료 	3.수입검사합격 		4.   검사 불합격',
	private String rvendor_status_nm ;		// '"납품관리VENDOR 상태\\\\n"	1.입하전	2.입하완료 	3.수입검사합격 		4.   검사 불합격',
	private String delivery_date ;		//	'출고예정일',
	private String vendor_delivery_date ;	// 'vendor확정일',
	private String creator ;			//
	private String updater ;			//
	private String date_created ;		//
	private String date_updated ;		//
	private String raw_seq;	//'발주번호seq',
	private String sernr_yn;	//'시리얼관리대상여부 관리 Y ELSE N',
	private String real_qty;	//'실제vendor 수량',
	private String use_yn;
	private String diff_date;
	private String transation_num;
	private ArrayList<String> itnbrList;
	*/
	// params
	private String jidat_from;
	private String jidat_to;
	
	private int page;
	private int rows;
	
	private String sidx;
	private String sord;
	
	// new
	private String ukey;
	private String ebeln;	// '구매문서번호',
	private String ebelp;	// '구매문서품목번호',
	private String matnr;	// '자재번호',
	private String rorder_status;	// DEFAULT 'r1' COMMENT 'mes_code_tbl 참조',
	private String rorder_status_nm;	// DEFAULT 'r1' COMMENT 'mes_code_tbl 참조',
	private String rvendor_status;	// 'v1' COMMENT 'mes_code_tbl 참조',
	private String rvendor_status_nm;	// 'v1' COMMENT 'mes_code_tbl 참조',
	private String eindt;	//'납품일자',
	private String order_delivery_date;	//'요청일자예정일',
	private String vendor_delivery_date;	//'vendor예정일',
	private String txz01;	// '납품내역',
	private String sernp;	// '시리얼관리대상여부 관리 Y ELSE N',
	private String bukrs;	// '회사코드',
	private String loekz;	// 삭제
	private String werks;	//'플랜트',
	private String lgort;	//'저장위치',
	private String lgobe;	// '저장위치명',
	private String matkl;	//'자재그릅',
	private String wgbez;	// '자재그룹명',
	private String idnlf;	// '공급업체가사용하는 자재번호',
	private String menge;	// '구매오더수량',
	private String zdeli_menge;	//'납품수량',
	private String zdue_menge;	//'잔량',
	private String meins;	//'구매오더단위',
	private String netpr;	//'구매문서의단가(전표통화)',
	private String peinh;	//'가격단위',
	private String netwr;	//'순오더금액(po통화)',
	private String elikz;	//'납품완료지시자',
	private String erekz;	//'최종송장지시자',
	private String pstyp;	//'구매문서의품목범주',
	private String knttp;	//'계정지정범주',
	private String bstyp;	//'구매문서범주',
	private String bsart;	//'구매문서유형',
	private String aedat;	//'레코드생성일',
	private String ernam;	// '오브젝트생성자이름',
	private String lifnr;	// '공급업체계정번호',
	private String name1;	// '공급업체명',
	private String ekgrp;	//'구매구룹',
	private String eknam;	//'구매그룹명',
	private String use_yn;	//DEFAULT 'Y',
	private String creator;	
	private String updater;
	private String diff_date;	//DEFAULT 'N' COMMENT '요청일자수정일자다른경우 \'Y\' ELSE \'N\'',
	private String date_created;
	private String date_updated;
	private String partial_seq;
	private String partial_yn;
	private String item_seq;
	private String ref_doc_no;
	private String labnr;
	private String zcsreq;
	
	// for tree grid---
	private String level;
	private boolean isLeaf;
	private boolean expanded;
	private boolean loaded;
	private String parent;
	
	// for tree grid---
	
	
	public String getZcsreq() {
		return zcsreq;
	}
	public void setZcsreq(String zcsreq) {
		this.zcsreq = zcsreq;
	}
	
	public String getLevel() {
		return level;
	}
	public String getLabnr() {
		return labnr;
	}
	public void setLabnr(String labnr) {
		this.labnr = labnr;
	}
	public void setLevel(String level) {
		this.level = level;
	}
	public boolean isLeaf() {
		return isLeaf;
	}
	public void setLeaf(boolean isLeaf) {
		this.isLeaf = isLeaf;
	}
	public boolean isExpanded() {
		return expanded;
	}
	public void setExpanded(boolean expanded) {
		this.expanded = expanded;
	}
	public boolean isLoaded() {
		return loaded;
	}
	public void setLoaded(boolean loaded) {
		this.loaded = loaded;
	}
	public String getParent() {
		return parent;
	}
	public void setParent(String parent) {
		this.parent = parent;
	}
	public String getRef_doc_no() {
		return ref_doc_no;
	}
	public void setRef_doc_no(String ref_doc_no) {
		this.ref_doc_no = ref_doc_no;
	}
	public String getItem_seq() {
		return item_seq;
	}
	public void setItem_seq(String item_seq) {
		this.item_seq = item_seq;
	}
	public String getUkey() {
		return ukey;
	}
	public void setUkey(String ukey) {
		this.ukey = ukey;
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
	public String getLoekz() {
		return loekz;
	}
	public void setLoekz(String loekz) {
		this.loekz = loekz;
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
	public String getRorder_status() {
		return rorder_status;
	}
	public void setRorder_status(String rorder_status) {
		this.rorder_status = rorder_status;
	}
	public String getRorder_status_nm() {
		return rorder_status_nm;
	}
	public void setRorder_status_nm(String rorder_status_nm) {
		this.rorder_status_nm = rorder_status_nm;
	}
	public String getRvendor_status() {
		return rvendor_status;
	}
	public void setRvendor_status(String rvendor_status) {
		this.rvendor_status = rvendor_status;
	}
	
	public String getRvendor_status_nm() {
		return rvendor_status_nm;
	}
	public void setRvendor_status_nm(String rvendor_status_nm) {
		this.rvendor_status_nm = rvendor_status_nm;
	}
	public String getEindt() {
		return eindt;
	}
	public void setEindt(String eindt) {
		this.eindt = eindt;
	}
	public String getTxz01() {
		return txz01;
	}
	public void setTxz01(String txz01) {
		this.txz01 = txz01;
	}
	public String getSernp() {
		return sernp;
	}
	public void setSernp(String sernp) {
		this.sernp = sernp;
	}
	public String getBukrs() {
		return bukrs;
	}
	public void setBukrs(String bukrs) {
		this.bukrs = bukrs;
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
	public String getLgobe() {
		return lgobe;
	}
	public void setLgobe(String lgobe) {
		this.lgobe = lgobe;
	}
	public String getMatkl() {
		return matkl;
	}
	public void setMatkl(String matkl) {
		this.matkl = matkl;
	}
	public String getWgbez() {
		return wgbez;
	}
	public void setWgbez(String wgbez) {
		this.wgbez = wgbez;
	}
	public String getIdnlf() {
		return idnlf;
	}
	public void setIdnlf(String idnlf) {
		this.idnlf = idnlf;
	}
	public String getMenge() {
		return menge;
	}
	public void setMenge(String menge) {
		this.menge = menge;
	}
	public String getZdeli_menge() {
		return zdeli_menge;
	}
	public void setZdeli_menge(String zdeli_menge) {
		this.zdeli_menge = zdeli_menge;
	}
	public String getZdue_menge() {
		return zdue_menge;
	}
	public void setZdue_menge(String zdue_menge) {
		this.zdue_menge = zdue_menge;
	}
	public String getMeins() {
		return meins;
	}
	public void setMeins(String meins) {
		this.meins = meins;
	}
	public String getNetpr() {
		return netpr;
	}
	public void setNetpr(String netpr) {
		this.netpr = netpr;
	}
	public String getPeinh() {
		return peinh;
	}
	public void setPeinh(String peinh) {
		this.peinh = peinh;
	}
	public String getNetwr() {
		return netwr;
	}
	public void setNetwr(String netwr) {
		this.netwr = netwr;
	}
	public String getElikz() {
		return elikz;
	}
	public void setElikz(String elikz) {
		this.elikz = elikz;
	}
	public String getErekz() {
		return erekz;
	}
	public void setErekz(String erekz) {
		this.erekz = erekz;
	}
	public String getPstyp() {
		return pstyp;
	}
	public void setPstyp(String pstyp) {
		this.pstyp = pstyp;
	}
	public String getKnttp() {
		return knttp;
	}
	public void setKnttp(String knttp) {
		this.knttp = knttp;
	}
	public String getBstyp() {
		return bstyp;
	}
	public void setBstyp(String bstyp) {
		this.bstyp = bstyp;
	}
	public String getBsart() {
		return bsart;
	}
	public void setBsart(String bsart) {
		this.bsart = bsart;
	}
	public String getAedat() {
		return aedat;
	}
	public void setAedat(String aedat) {
		this.aedat = aedat;
	}
	public String getErnam() {
		return ernam;
	}
	public void setErnam(String ernam) {
		this.ernam = ernam;
	}
	public String getLifnr() {
		return lifnr;
	}
	public void setLifnr(String lifnr) {
		this.lifnr = lifnr;
	}
	public String getName1() {
		return name1;
	}
	public void setName1(String name1) {
		this.name1 = name1;
	}
	public String getEkgrp() {
		return ekgrp;
	}
	public void setEkgrp(String ekgrp) {
		this.ekgrp = ekgrp;
	}
	public String getEknam() {
		return eknam;
	}
	public void setEknam(String eknam) {
		this.eknam = eknam;
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
	public String getDiff_date() {
		return diff_date;
	}
	public void setDiff_date(String diff_date) {
		this.diff_date = diff_date;
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
	public String getSidx() {
		return sidx;
	}
	public void setSidx(String sidx) {
		this.sidx = sidx;
	}
	public String getSord() {
		return sord;
	}
	public void setSord(String sord) {
		this.sord = sord;
	}
	
	public String getPartial_seq() {
		return partial_seq;
	}
	public void setPartial_seq(String partial_seq) {
		this.partial_seq = partial_seq;
	}
	
	public String getPartial_yn() {
		return partial_yn;
	}
	public void setPartial_yn(String partial_yn) {
		this.partial_yn = partial_yn;
	}
	@Override
	public String toString() {
		return "SYScmRawDeliveryVo [jidat_from=" + jidat_from + ", jidat_to="
				+ jidat_to + ", page=" + page + ", rows=" + rows + ", sidx="
				+ sidx + ", sord=" + sord + ", ebeln=" + ebeln + ", ebelp="
				+ ebelp + ", matnr=" + matnr + ", rorder_status="
				+ rorder_status + ", rvendor_status=" + rvendor_status
				+ ", eindt=" + eindt + ", order_delivery_date="
				+ order_delivery_date + ", vendor_delivery_date="
				+ vendor_delivery_date + ", txz01=" + txz01 + ", sernp="
				+ sernp + ", bukrs=" + bukrs + ", loekz=" + loekz + ", werks="
				+ werks + ", lgort=" + lgort + ", lgobe=" + lgobe + ", matkl="
				+ matkl + ", wgbez=" + wgbez + ", idnlf=" + idnlf + ", menge="
				+ menge + ", zdeli_menge=" + zdeli_menge + ", zdue_menge="
				+ zdue_menge + ", meins=" + meins + ", netpr=" + netpr
				+ ", peinh=" + peinh + ", netwr=" + netwr + ", elikz=" + elikz
				+ ", erekz=" + erekz + ", pstyp=" + pstyp + ", knttp=" + knttp
				+ ", bstyp=" + bstyp + ", bsart=" + bsart + ", aedat=" + aedat
				+ ", ernam=" + ernam + ", lifnr=" + lifnr + ", name1=" + name1
				+ ", ekgrp=" + ekgrp + ", eknam=" + eknam + ", use_yn="
				+ use_yn + ", creator=" + creator + ", updater=" + updater
				+ ", diff_date=" + diff_date + ", date_created=" + date_created
				+ ", date_updated=" + date_updated + "]";
	}
	
}
