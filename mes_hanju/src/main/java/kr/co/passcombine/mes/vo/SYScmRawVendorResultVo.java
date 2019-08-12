package kr.co.passcombine.mes.vo;

import java.io.Serializable;

public class SYScmRawVendorResultVo implements Serializable{
	private String ebeln;	//구매문서번호',
	private String ebelp;	//'구매문서품목번호',
	private String partial_seq;	//'partial 순번',
	private String matnr;	//
	private String rorder_status;	// 'mes_code_tbl 참조',
	private String rvendor_status;	// 'mes_code_tbl 참조',
	private String rorder_status_nm;	// 'mes_code_tbl 참조',
	private String rvendor_status_nm;	// 'mes_code_tbl 참조',
	private String order_delivery_date;	//
	private String vendor_delivery_date;	//
	private String menge;	//
	private String zdeli_menge;	//
	private String werks;	//'플랜트',
	private String bukrs;	// '회사코드',
	private String lgort;	//'저장위치',
	private String diff_date;	//'일자차이',
	private String ref_doc_no;
	private String sap_doc_no;
	private String mjahr;
	private String mblnr;
	private String labnr;
	private String lifnr;
	private String confirm_date;
	
	private String mesi;	// 검사 : "N", 무검사  : "Y"
	private String mesr;	// 임고 : "Y", 입하 : "N"
	private String mesg;	// 전수 검사 여부
	private String move_type;
	
	private String sernp;
	private String txz01;
	private String meins;
	private String eindt;	//'납품일자',
	private String zdue_menge; //'잔량',
	private String netpr;	// '구매오더문저의 단가(전표통화)',
	private String peinh;	//'가격단위',
	private String netwr;	// '순오더금액(po통화)',
	private String elikz;	//'납품완료지시자',
	private String erekz;	//'최종송장지시자',
	private String pstyp;	//'구매문서의품목범주',
	private String knttp;	//'계정지정범주',
	private String bstyp;	//'구매문서범주',
	private String bsart;	//'구매문서유형',
	private String ernam;	//'오브젝트생성자이름',
	private String aedat;	//'레코드생성일',
	private String name1;	//'공급업체명',
	private String ekgrp;	//'구매그룹',
	private String eknam;	//'구매그룹명',
	private String loekz;	//'구매문서의삭제지시자',
	private String partial_yn; //'분할구분',
	private String use_yn; //'사용유무',
	private String lgobe;	// '저장위치명',
	private String matkl;	//'자재그룹',
	private String wgbez;	// '자재그룹명',
	private String idnlf;	// '공급업체가 사용하는 자재 번호',
	private String zcsreq;	//'csr 번호',
	private String chn_date;	//'partial 작업 후 일자 변경시 \'Y\' update 해준다',
	private String creator;
	private String updater;
	
	// params
	private String jidat_from;
	private String jidat_to;
	private String gridData;
	
	// for get uniqueKey(SAP)
	private String vcode;
	private String rnum1;
	private String unikey;
	private String zflag;
	
	private String confirm_yn; //vendor 일정 확인 유무
	
	
	//사급오더 Subcontract 관련 추가 
	
	private String maktx; //자재명
	private String bdmng; //소요량
	private String z1110_labst; //stock_의료
	private String z1210_labst; //stock_영상
	private String zvendor_sllab; //vendor_stock
	private String rsnum; //예약/종속 소요량의 번호
	private String rspos; //예약/종속 소요량에 대한 품목 번호
	private String xloek; //삭제여부
	private String iloos; //matnr 없는거 처리하려고 생성 
	
	
	
	
	
	public String getIloos() {
		return iloos;
	}
	public void setIloos(String iloos) {
		this.iloos = iloos;
	}
	public String getMaktx() {
		return maktx;
	}
	public void setMaktx(String maktx) {
		this.maktx = maktx;
	}
	public String getBdmng() {
		return bdmng;
	}
	public void setBdmng(String bdmng) {
		this.bdmng = bdmng;
	}
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
	
	public String getConfirm_yn() {
		return confirm_yn;
	}
	public void setConfirm_yn(String confirm_yn) {
		this.confirm_yn = confirm_yn;
	}
	public String getMesg() {
		return mesg;
	}
	public void setMesg(String mesg) {
		this.mesg = mesg;
	}
	public String getSap_doc_no() {
		return sap_doc_no;
	}
	public void setSap_doc_no(String sap_doc_no) {
		this.sap_doc_no = sap_doc_no;
	}
	public String getConfirm_date() {
		return confirm_date;
	}
	public void setConfirm_date(String confirm_date) {
		this.confirm_date = confirm_date;
	}
	public String getMove_type() {
		return move_type;
	}
	public void setMove_type(String move_type) {
		this.move_type = move_type;
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
	public String getRorder_status_nm() {
		return rorder_status_nm;
	}
	public void setRorder_status_nm(String rorder_status_nm) {
		this.rorder_status_nm = rorder_status_nm;
	}
	public String getRvendor_status_nm() {
		return rvendor_status_nm;
	}
	public void setRvendor_status_nm(String rvendor_status_nm) {
		this.rvendor_status_nm = rvendor_status_nm;
	}
	public String getMeins() {
		return meins;
	}
	public void setMeins(String meins) {
		this.meins = meins;
	}
	public String getEindt() {
		return eindt;
	}
	public void setEindt(String eindt) {
		this.eindt = eindt;
	}
	public String getZdue_menge() {
		return zdue_menge;
	}
	public void setZdue_menge(String zdue_menge) {
		this.zdue_menge = zdue_menge;
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
	public String getErnam() {
		return ernam;
	}
	public void setErnam(String ernam) {
		this.ernam = ernam;
	}
	public String getAedat() {
		return aedat;
	}
	public void setAedat(String aedat) {
		this.aedat = aedat;
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
	public String getLoekz() {
		return loekz;
	}
	public void setLoekz(String loekz) {
		this.loekz = loekz;
	}
	public String getPartial_yn() {
		return partial_yn;
	}
	public void setPartial_yn(String partial_yn) {
		this.partial_yn = partial_yn;
	}
	public String getUse_yn() {
		return use_yn;
	}
	public void setUse_yn(String use_yn) {
		this.use_yn = use_yn;
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
	public String getZcsreq() {
		return zcsreq;
	}
	public void setZcsreq(String zcsreq) {
		this.zcsreq = zcsreq;
	}
	public String getChn_date() {
		return chn_date;
	}
	public void setChn_date(String chn_date) {
		this.chn_date = chn_date;
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
	public String getLifnr() {
		return lifnr;
	}
	public void setLifnr(String lifnr) {
		this.lifnr = lifnr;
	}
	public String getZflag() {
		return zflag;
	}
	public void setZflag(String zflag) {
		this.zflag = zflag;
	}
	public String getLabnr() {
		return labnr;
	}
	public void setLabnr(String labnr) {
		this.labnr = labnr;
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
	public String getMjahr() {
		return mjahr;
	}
	public void setMjahr(String mjahr) {
		this.mjahr = mjahr;
	}
	public String getMblnr() {
		return mblnr;
	}
	public void setMblnr(String mblnr) {
		this.mblnr = mblnr;
	}
	public String getRef_doc_no() {
		return ref_doc_no;
	}
	public void setRef_doc_no(String ref_doc_no) {
		this.ref_doc_no = ref_doc_no;
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
	public String getPartial_seq() {
		return partial_seq;
	}
	public void setPartial_seq(String partial_seq) {
		this.partial_seq = partial_seq;
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
	public String getRvendor_status() {
		return rvendor_status;
	}
	public void setRvendor_status(String rvendor_status) {
		this.rvendor_status = rvendor_status;
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
	public String getWerks() {
		return werks;
	}
	public void setWerks(String werks) {
		this.werks = werks;
	}
	public String getBukrs() {
		return bukrs;
	}
	public void setBukrs(String bukrs) {
		this.bukrs = bukrs;
	}
	public String getLgort() {
		return lgort;
	}
	public void setLgort(String lgort) {
		this.lgort = lgort;
	}
	public String getDiff_date() {
		return diff_date;
	}
	public void setDiff_date(String diff_date) {
		this.diff_date = diff_date;
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
	@Override
	public String toString() {
		return "SYScmRawVendorResultVo [ebeln=" + ebeln + ", ebelp=" + ebelp
				+ ", partial_seq=" + partial_seq + ", matnr=" + matnr
				+ ", rorder_status=" + rorder_status + ", rvendor_status="
				+ rvendor_status + ", rorder_status_nm=" + rorder_status_nm
				+ ", rvendor_status_nm=" + rvendor_status_nm
				+ ", order_delivery_date=" + order_delivery_date
				+ ", vendor_delivery_date=" + vendor_delivery_date + ", menge="
				+ menge + ", zdeli_menge=" + zdeli_menge + ", werks=" + werks
				+ ", bukrs=" + bukrs + ", lgort=" + lgort + ", diff_date="
				+ diff_date + ", ref_doc_no=" + ref_doc_no + ", sap_doc_no="
				+ sap_doc_no + ", mjahr=" + mjahr + ", mblnr=" + mblnr
				+ ", labnr=" + labnr + ", lifnr=" + lifnr + ", confirm_date="
				+ confirm_date + ", mesi=" + mesi + ", mesr=" + mesr
				+ ", mesg=" + mesg + ", move_type=" + move_type + ", sernp="
				+ sernp + ", txz01=" + txz01 + ", meins=" + meins + ", eindt="
				+ eindt + ", zdue_menge=" + zdue_menge + ", netpr=" + netpr
				+ ", peinh=" + peinh + ", netwr=" + netwr + ", elikz=" + elikz
				+ ", erekz=" + erekz + ", pstyp=" + pstyp + ", knttp=" + knttp
				+ ", bstyp=" + bstyp + ", bsart=" + bsart + ", ernam=" + ernam
				+ ", aedat=" + aedat + ", name1=" + name1 + ", ekgrp=" + ekgrp
				+ ", eknam=" + eknam + ", loekz=" + loekz + ", partial_yn="
				+ partial_yn + ", use_yn=" + use_yn + ", lgobe=" + lgobe
				+ ", matkl=" + matkl + ", wgbez=" + wgbez + ", idnlf=" + idnlf
				+ ", zcsreq=" + zcsreq + ", chn_date=" + chn_date
				+ ", creator=" + creator + ", updater=" + updater
				+ ", jidat_from=" + jidat_from + ", jidat_to=" + jidat_to
				+ ", gridData=" + gridData + ", vcode=" + vcode + ", rnum1="
				+ rnum1 + ", unikey=" + unikey + ", zflag=" + zflag
				+ ", confirm_yn=" + confirm_yn + ", maktx=" + maktx
				+ ", bdmng=" + bdmng + ", z1110_labst=" + z1110_labst
				+ ", z1210_labst=" + z1210_labst + ", zvendor_sllab="
				+ zvendor_sllab + ", rsnum=" + rsnum + ", rspos=" + rspos
				+ ", xloek=" + xloek + ", iloos=" + iloos + "]";
	}
}
