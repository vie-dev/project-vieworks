package kr.co.passcombine.mes.vo;

import java.io.Serializable;
import java.util.ArrayList;

public class SYScmRawProcVo implements Serializable{
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
	private String loekz_i;	// 삭제
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
	
	private String waers;	//'통화키',
	private String wkurs;	//'환율',
 
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
	private String labnr_1;
	private String zcsreq;
	private String confirm_yn;
	
	private String maktx;	//'자재명',
//	private String bdmng;	//'소요량',
	private String z1110_labst;	//'stock_의료',
	private String z1210_labst;	//'stock_영상',
	private String zvendor_sllab;	//'vendor_stock',
	private String rsnum;	// '예약/종속 소요량의 번호',
	private String rspos;	//'예약/종속 소요량에 대한 품목 번호',
	private String xloek;	//'삭제여부',
	
	private String confirm_date;	//'최종납품일자',
	private String mblnr;	//'자재문서번호(rfc return 시 해당 값 value 저장)',
	private String mjahr;	//'자재문서연도(rfc return 시 해당 값 value 저장)',
	private String c_mblnr;	// cancel '자재문서번호(rfc return 시 해당 값 value 저장)',
	private String c_mjahr;	// cancel '자재문서연도(rfc return 시 해당 값 value 저장)',
	private String sap_doc_no;	//'납품문서번호(#po+0001)    ex)4500000-0001',
	private String chn_date;	//'partial 작업 후 일자 변경시 \'Y\' update 해준다',
	private String cs_use_yn;	//'0',
 
	// for fipeupload
	private String no;

	// for get uniqueKey(SAP)
	private String vcode;
	private String rnum1;
	private String unikey;
	private String zflag;
	
	// for rfc
	private String mesi;	// 검사 : "N", 무검사  : "Y"
	private String mesr;	// 임고 : "Y", 입하 : "N"
	private String mesg;	// 전수 검사 여부
	private String move_type;
	private String gubun;
	private String rownum;	// seq
	private String rnum;	// child relate mother seq
	
	private String key_cnt;
	
	public String getMaktx() {
		return maktx;
	}
	public void setMaktx(String maktx) {
		this.maktx = maktx;
	}
//	public String getBdmng() {
//		return bdmng;
//	}
//	public void setBdmng(String bdmng) {
//		this.bdmng = bdmng;
//	}
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
	public String getGubun() {
		return gubun;
	}
	public void setGubun(String gubun) {
		this.gubun = gubun;
	}
	public String getRownum() {
		return rownum;
	}
	public void setRownum(String rownum) {
		this.rownum = rownum;
	}
	public String getRnum() {
		return rnum;
	}
	public void setRnum(String rnum) {
		this.rnum = rnum;
	}
	public String getVcode() {
		return vcode;
	}
	public void setVcode(String vcode) {
		this.vcode = vcode;
	}
	public String getRnum1() {
		return rnum1;
	}
	public void setRnum1(String rnum1) {
		this.rnum1 = rnum1;
	}
	public String getUnikey() {
		return unikey;
	}
	public void setUnikey(String unikey) {
		this.unikey = unikey;
	}
	public String getZflag() {
		return zflag;
	}
	public void setZflag(String zflag) {
		this.zflag = zflag;
	}
	public String getConfirm_yn() {
		return confirm_yn;
	}
	public void setConfirm_yn(String confirm_yn) {
		this.confirm_yn = confirm_yn;
	}
	public String getConfirm_date() {
		return confirm_date;
	}
	public void setConfirm_date(String confirm_date) {
		this.confirm_date = confirm_date;
	}
	public String getMblnr() {
		return mblnr;
	}
	public void setMblnr(String mblnr) {
		this.mblnr = mblnr;
	}
	public String getMjahr() {
		return mjahr;
	}
	public void setMjahr(String mjahr) {
		this.mjahr = mjahr;
	}
	public String getSap_doc_no() {
		return sap_doc_no;
	}
	public void setSap_doc_no(String sap_doc_no) {
		this.sap_doc_no = sap_doc_no;
	}
	public String getChn_date() {
		return chn_date;
	}
	public void setChn_date(String chn_date) {
		this.chn_date = chn_date;
	}
	public String getCs_use_yn() {
		return cs_use_yn;
	}
	public void setCs_use_yn(String cs_use_yn) {
		this.cs_use_yn = cs_use_yn;
	}
	public String getNo() {
		return no;
	}
	public void setNo(String no) {
		this.no = no;
	}
	public String getZcsreq() {
		return zcsreq;
	}
	public void setZcsreq(String zcsreq) {
		this.zcsreq = zcsreq;
	}
	
	public String getLabnr_1() {
		return labnr_1;
	}
	public void setLabnr_1(String labnr_1) {
		this.labnr_1 = labnr_1;
	}
	public String getLabnr() {
		return labnr;
	}
	public void setLabnr(String labnr) {
		this.labnr = labnr;
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
	public String getLoekz_i() {
		return loekz_i;
	}
	public void setLoekz_i(String loekz_i) {
		this.loekz_i = loekz_i;
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
	public String getMesi() {
		return mesi;
	}
	public void setMesi(String mesi) {
		this.mesi = mesi;
	}
	public String getMesr() {
		return mesr;
	}
	public void setMesr(String mesr) {
		this.mesr = mesr;
	}
	public String getMesg() {
		return mesg;
	}
	public void setMesg(String mesg) {
		this.mesg = mesg;
	}
	public String getMove_type() {
		return move_type;
	}
	public void setMove_type(String move_type) {
		this.move_type = move_type;
	}
	public String getWaers() {
		return waers;
	}
	public void setWaers(String waers) {
		this.waers = waers;
	}
	public String getWkurs() {
		return wkurs;
	}
	public void setWkurs(String wkurs) {
		this.wkurs = wkurs;
	}
	public String getC_mblnr() {
		return c_mblnr;
	}
	public void setC_mblnr(String c_mblnr) {
		this.c_mblnr = c_mblnr;
	}
	public String getC_mjahr() {
		return c_mjahr;
	}
	public void setC_mjahr(String c_mjahr) {
		this.c_mjahr = c_mjahr;
	}
	public String getKey_cnt() {
		return key_cnt;
	}
	public void setKey_cnt(String key_cnt) {
		this.key_cnt = key_cnt;
	}
	@Override
	public String toString() {
		return "SYScmRawProcVo [jidat_from=" + jidat_from + ", jidat_to="
				+ jidat_to + ", page=" + page + ", rows=" + rows + ", sidx="
				+ sidx + ", sord=" + sord + ", ukey=" + ukey + ", ebeln="
				+ ebeln + ", ebelp=" + ebelp + ", matnr=" + matnr
				+ ", rorder_status=" + rorder_status + ", rorder_status_nm="
				+ rorder_status_nm + ", rvendor_status=" + rvendor_status
				+ ", rvendor_status_nm=" + rvendor_status_nm + ", eindt="
				+ eindt + ", order_delivery_date=" + order_delivery_date
				+ ", vendor_delivery_date=" + vendor_delivery_date + ", txz01="
				+ txz01 + ", sernp=" + sernp + ", bukrs=" + bukrs + ", loekz="
				+ loekz + ", loekz_i=" + loekz_i + ", werks=" + werks
				+ ", lgort=" + lgort + ", lgobe=" + lgobe + ", matkl=" + matkl
				+ ", wgbez=" + wgbez + ", idnlf=" + idnlf + ", menge=" + menge
				+ ", zdeli_menge=" + zdeli_menge + ", zdue_menge=" + zdue_menge
				+ ", meins=" + meins + ", netpr=" + netpr + ", peinh=" + peinh
				+ ", netwr=" + netwr + ", elikz=" + elikz + ", erekz=" + erekz
				+ ", pstyp=" + pstyp + ", knttp=" + knttp + ", bstyp=" + bstyp
				+ ", bsart=" + bsart + ", aedat=" + aedat + ", ernam=" + ernam
				+ ", lifnr=" + lifnr + ", name1=" + name1 + ", ekgrp=" + ekgrp
				+ ", eknam=" + eknam + ", waers=" + waers + ", wkurs=" + wkurs
				+ ", use_yn=" + use_yn + ", creator=" + creator + ", updater="
				+ updater + ", diff_date=" + diff_date + ", date_created="
				+ date_created + ", date_updated=" + date_updated
				+ ", partial_seq=" + partial_seq + ", partial_yn=" + partial_yn
				+ ", item_seq=" + item_seq + ", ref_doc_no=" + ref_doc_no
				+ ", labnr=" + labnr + ", labnr_1=" + labnr_1 + ", zcsreq="
				+ zcsreq + ", confirm_yn=" + confirm_yn + ", maktx=" + maktx
				+ ", z1110_labst=" + z1110_labst + ", z1210_labst="
				+ z1210_labst + ", zvendor_sllab=" + zvendor_sllab + ", rsnum="
				+ rsnum + ", rspos=" + rspos + ", xloek=" + xloek
				+ ", confirm_date=" + confirm_date + ", mblnr=" + mblnr
				+ ", mjahr=" + mjahr + ", c_mblnr=" + c_mblnr + ", c_mjahr="
				+ c_mjahr + ", sap_doc_no=" + sap_doc_no + ", chn_date="
				+ chn_date + ", cs_use_yn=" + cs_use_yn + ", no=" + no
				+ ", vcode=" + vcode + ", rnum1=" + rnum1 + ", unikey="
				+ unikey + ", zflag=" + zflag + ", mesi=" + mesi + ", mesr="
				+ mesr + ", mesg=" + mesg + ", move_type=" + move_type
				+ ", gubun=" + gubun + ", rownum=" + rownum + ", rnum=" + rnum
				+ ", key_cnt=" + key_cnt + "]";
	}
	
}
