package kr.co.passcombine.mes.vo;

import java.io.Serializable;
import java.util.ArrayList;

public class SYShipmentVo implements Serializable{
	 
	private String	vbeln;                  
	private String	posnr;                  
	private String	if_flag;                  
	private String	shipment_status;                  
	private String	shipment_status_nm;                  
	private String	lfart;                  
	private String	vtext_lfart;                  
	private String	vstel;                  
	private String	vtext_vstel;                  
	private String	werks;                  
	private String	name1_werks;                  
	private String	lgort;                  
	private String	lgobe;                  
	private String	matnr;                  
	private String	arktx;                  
	private String	lfimg;                  
	private String	vrkme_do;                  
	private String	lgmng;                  
	private String	meins_do;                  
	private String	umvkz;                  
	private String	umvkn;                  
	private String	uebto;                  
	private String	erdat_do;                  
	private String	ernam_do;
	private String  wadat_ist;
	private String  wadat_ist_from;
	private String  wadat_ist_to;
	private String	wadat;                  
	private String  wadat_from;
	private String  wadat_to;                  
	private String	text_z001;                  
	private String	vkorg;                  
	private String	vtext_vkorg;                  
	private String	vtweg;                  
	private String	vtext_vtweg;                  
	private String	spart;                  
	private String	vtext_spart;                  
	private String	vkbur;                  
	private String	bezei_vkbur;                  
	private String	vkgrp;                  
	private String	bezei_vkgrp;                  
	private String	inco1;                  
	private String	inco2;                  
	private String	vgbel;                  
	private String	vgpos;                  
	private String	kunnr_ag;                  
	private String	name1_kunnr_ag;                  
	private String	name2_kunnr_ag;                  
	private String	land1_kunnr_ag;                  
	private String	city1_kunnr_ag;                  
	private String	street_kunnr_ag;                  
	private String	str_suppl1_kunnr_ag;                  
	private String	str_suppl2_kunnr_ag;                  
	private String	pstlz_kunnr_ag;                  
	private String	j_1kfrepre_kunnr_ag;                  
	private String	j_1kftind_kunnr_ag;                  
	private String	j_1kftbus_kunnr_ag;                  
	private String	stcd1_kunnr_ag;                  
	private String	stcd2_kunnr_ag;                  
	private String	stcd3_kunnr_ag;                  
	private String	telf1_kunnr_ag;                  
	private String	telf2_kunnr_ag;                  
	private String	telfx_kunnr_ag;                  
	private String	smtp_addr_kunnr_ag;                  
	private String	kunnr_we;                  
	private String	name1_kunnr_we;                  
	private String	name2_kunnr_we;                  
	private String	land1_kunnr_we;                  
	private String	city1_kunnr_we;                  
	private String	street_kunnr_we;                  
	private String	str_suppl1_kunnr_we;                  
	private String	str_suppl2_kunnr_we;                  
	private String	pstlz_kunnr_we;                  
	private String	j_1kfrepre_kunnr_we;                  
	private String	j_1kftind_kunnr_we;                  
	private String	j_1kftbus_kunnr_we;                  
	private String	stcd1_kunnr_we;                  
	private String	stcd2_kunnr_we;                  
	private String	stcd3_kunnr_we;                  
	private String	telf1_kunnr_we;                  
	private String	telf2_kunnr_we;                  
	private String	telfx_kunnr_we;                  


	private String	smtp_addr_kunnr_we;                  
	private String	kunnr_z1;                  
	private String  name1_kunnr_z1;    
	private String  name2_kunnr_z1;    
	private String  kunnr_z2;    
	private String  name1_kunnr_z2;    
	private String  telf2_kunnr_z2;    
	

	private String  erdat_so;    
	private String  ernam_so;  
	private String  auart;   
	private String  bezei_auart; 
	private String  augru;    
	private String  bezei_augru;    
	private String  edatu;    
	private String  kwmeng;    
	private String  vrkme_so;    
	private String  origin_vbeln;    
	private String  zzwarranty;    
	private String  bstkd;   
	private String  name_p4;    
	private String  pst_p4;   
	private String  dpt_p4;  
	private String  phone_p4;    
	private String  email_p4;    
	private String  sernp;    
	private String  strgr;  
	private String  funcName;
	
	private String  edatu_from;
	private String  edatu_to;
	
	private String uni_key;
	private String vbeln_gr;
	
	private ArrayList<String> matnrList;
	private String sernr;
	
	private String i_shipment_gubun;
	
	private String zzswoption;
	private String dtatwtb_s;
	private String dtsernr;
	private String dtdmr_no;
	private String dtrn_no;
	
	private String vsatwtb_s;
	private String vssernr;
	private String vsdmr_no;
	private String vsrn_no;
	private String psatwtb_s;
	private String pssernr;
	private String psdmr_no;
	private String psrn_no;
	private String chatwtb_s;
	private String chsernr;
	private String chdmr_no;
	private String chrn_no;
	
	private String rcatwtb_s;
	private String rcsernr;
	private String rcdmr_no;
	private String rcrn_no;
	
	private String rsatwtb_s;
	private String rssernr;
	private String rsdmr_no;
	private String rsrn_no;
	
	private String rwatwtb_s;
	private String rwsernr;
	private String rwdmr_no;
	private String rwrn_no;
	
	
	 
	public String getRcatwtb_s() {
		return rcatwtb_s;
	}

	public void setRcatwtb_s(String rcatwtb_s) {
		this.rcatwtb_s = rcatwtb_s;
	}

	public String getRcsernr() {
		return rcsernr;
	}

	public void setRcsernr(String rcsernr) {
		this.rcsernr = rcsernr;
	}

	public String getRcdmr_no() {
		return rcdmr_no;
	}

	public void setRcdmr_no(String rcdmr_no) {
		this.rcdmr_no = rcdmr_no;
	}

	public String getRcrn_no() {
		return rcrn_no;
	}

	public void setRcrn_no(String rcrn_no) {
		this.rcrn_no = rcrn_no;
	}

	public String getRsatwtb_s() {
		return rsatwtb_s;
	}

	public void setRsatwtb_s(String rsatwtb_s) {
		this.rsatwtb_s = rsatwtb_s;
	}

	public String getRssernr() {
		return rssernr;
	}

	public void setRssernr(String rssernr) {
		this.rssernr = rssernr;
	}

	public String getRsdmr_no() {
		return rsdmr_no;
	}

	public void setRsdmr_no(String rsdmr_no) {
		this.rsdmr_no = rsdmr_no;
	}

	public String getRsrn_no() {
		return rsrn_no;
	}

	public void setRsrn_no(String rsrn_no) {
		this.rsrn_no = rsrn_no;
	}

	public String getRwatwtb_s() {
		return rwatwtb_s;
	}

	public void setRwatwtb_s(String rwatwtb_s) {
		this.rwatwtb_s = rwatwtb_s;
	}

	public String getRwsernr() {
		return rwsernr;
	}

	public void setRwsernr(String rwsernr) {
		this.rwsernr = rwsernr;
	}

	public String getRwdmr_no() {
		return rwdmr_no;
	}

	public void setRwdmr_no(String rwdmr_no) {
		this.rwdmr_no = rwdmr_no;
	}

	public String getRwrn_no() {
		return rwrn_no;
	}

	public void setRwrn_no(String rwrn_no) {
		this.rwrn_no = rwrn_no;
	}

	public String getZzswoption() {
		return zzswoption;
	}

	public void setZzswoption(String zzswoption) {
		this.zzswoption = zzswoption;
	}

	public String getDtatwtb_s() {
		return dtatwtb_s;
	}

	public void setDtatwtb_s(String dtatwtb_s) {
		this.dtatwtb_s = dtatwtb_s;
	}

	public String getDtsernr() {
		return dtsernr;
	}

	public void setDtsernr(String dtsernr) {
		this.dtsernr = dtsernr;
	}

	public String getDtdmr_no() {
		return dtdmr_no;
	}

	public void setDtdmr_no(String dtdmr_no) {
		this.dtdmr_no = dtdmr_no;
	}

	public String getDtrn_no() {
		return dtrn_no;
	}

	public void setDtrn_no(String dtrn_no) {
		this.dtrn_no = dtrn_no;
	}

	public String getVsatwtb_s() {
		return vsatwtb_s;
	}

	public void setVsatwtb_s(String vsatwtb_s) {
		this.vsatwtb_s = vsatwtb_s;
	}

	public String getVssernr() {
		return vssernr;
	}

	public void setVssernr(String vssernr) {
		this.vssernr = vssernr;
	}

	public String getVsdmr_no() {
		return vsdmr_no;
	}

	public void setVsdmr_no(String vsdmr_no) {
		this.vsdmr_no = vsdmr_no;
	}

	public String getVsrn_no() {
		return vsrn_no;
	}

	public void setVsrn_no(String vsrn_no) {
		this.vsrn_no = vsrn_no;
	}

	public String getPsatwtb_s() {
		return psatwtb_s;
	}

	public void setPsatwtb_s(String psatwtb_s) {
		this.psatwtb_s = psatwtb_s;
	}

	public String getPssernr() {
		return pssernr;
	}

	public void setPssernr(String pssernr) {
		this.pssernr = pssernr;
	}

	public String getPsdmr_no() {
		return psdmr_no;
	}

	public void setPsdmr_no(String psdmr_no) {
		this.psdmr_no = psdmr_no;
	}

	public String getPsrn_no() {
		return psrn_no;
	}

	public void setPsrn_no(String psrn_no) {
		this.psrn_no = psrn_no;
	}

	public String getChatwtb_s() {
		return chatwtb_s;
	}

	public void setChatwtb_s(String chatwtb_s) {
		this.chatwtb_s = chatwtb_s;
	}

	public String getChsernr() {
		return chsernr;
	}

	public void setChsernr(String chsernr) {
		this.chsernr = chsernr;
	}

	public String getChdmr_no() {
		return chdmr_no;
	}

	public void setChdmr_no(String chdmr_no) {
		this.chdmr_no = chdmr_no;
	}

	public String getChrn_no() {
		return chrn_no;
	}

	public void setChrn_no(String chrn_no) {
		this.chrn_no = chrn_no;
	}

	public String getI_shipment_gubun() {
		return i_shipment_gubun;
	}

	public void setI_shipment_gubun(String i_shipment_gubun) {
		this.i_shipment_gubun = i_shipment_gubun;
	}

	public String getShipment_status_nm() {
		return shipment_status_nm;
	}

	public void setShipment_status_nm(String shipment_status_nm) {
		this.shipment_status_nm = shipment_status_nm;
	}

	public String getWadat_from() {
		return wadat_from;
	}

	public void setWadat_from(String wadat_from) {
		this.wadat_from = wadat_from;
	}

	public String getWadat_to() {
		return wadat_to;
	}

	public void setWadat_to(String wadat_to) {
		this.wadat_to = wadat_to;
	}

	public String getEdatu_from() {
		return edatu_from;
	}

	public void setEdatu_from(String edatu_from) {
		this.edatu_from = edatu_from;
	}

	public String getEdatu_to() {
		return edatu_to;
	}

	public void setEdatu_to(String edatu_to) {
		this.edatu_to = edatu_to;
	}

	public String getFuncName() {
		return funcName;
	}

	public void setFuncName(String funcName) {
		this.funcName = funcName;
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

	public String getIf_flag() {
		return if_flag;
	}

	public void setIf_flag(String if_flag) {
		this.if_flag = if_flag;
	}

	public String getShipment_status() {
		return shipment_status;
	}

	public void setShipment_status(String shipment_status) {
		this.shipment_status = shipment_status;
	}

	public String getLfart() {
		return lfart;
	}

	public void setLfart(String lfart) {
		this.lfart = lfart;
	}

	public String getVtext_lfart() {
		return vtext_lfart;
	}

	public void setVtext_lfart(String vtext_lfart) {
		this.vtext_lfart = vtext_lfart;
	}

	public String getVstel() {
		return vstel;
	}

	public void setVstel(String vstel) {
		this.vstel = vstel;
	}

	public String getVtext_vstel() {
		return vtext_vstel;
	}

	public void setVtext_vstel(String vtext_vstel) {
		this.vtext_vstel = vtext_vstel;
	}

	public String getWerks() {
		return werks;
	}

	public void setWerks(String werks) {
		this.werks = werks;
	}

	public String getName1_werks() {
		return name1_werks;
	}

	public void setName1_werks(String name1_werks) {
		this.name1_werks = name1_werks;
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

	public String getMatnr() {
		return matnr;
	}

	public void setMatnr(String matnr) {
		this.matnr = matnr;
	}

	public String getArktx() {
		return arktx;
	}

	public void setArktx(String arktx) {
		this.arktx = arktx;
	}

	public String getLfimg() {
		return lfimg;
	}

	public void setLfimg(String lfimg) {
		this.lfimg = lfimg;
	}

	public String getVrkme_do() {
		return vrkme_do;
	}

	public void setVrkme_do(String vrkme_do) {
		this.vrkme_do = vrkme_do;
	}

	public String getLgmng() {
		return lgmng;
	}

	public void setLgmng(String lgmng) {
		this.lgmng = lgmng;
	}


	public String getMeins_do() {
		return meins_do;
	}

	public void setMeins_do(String meins_do) {
		this.meins_do = meins_do;
	}

	public String getUmvkz() {
		return umvkz;
	}

	public void setUmvkz(String umvkz) {
		this.umvkz = umvkz;
	}

	public String getUmvkn() {
		return umvkn;
	}

	public void setUmvkn(String umvkn) {
		this.umvkn = umvkn;
	}

	public String getUebto() {
		return uebto;
	}

	public void setUebto(String uebto) {
		this.uebto = uebto;
	}

	public String getErdat_do() {
		return erdat_do;
	}

	public void setErdat_do(String erdat_do) {
		this.erdat_do = erdat_do;
	}


	public String getErnam_do() {
		return ernam_do;
	}

	public void setErnam_do(String ernam_do) {
		this.ernam_do = ernam_do;
	}

	public String getWadat_ist() {
		return wadat_ist;
	}

	public void setWadat_ist(String wadat_ist) {
		this.wadat_ist = wadat_ist;
	}

	public String getWadat_ist_from() {
		return wadat_ist_from;
	}

	public void setWadat_ist_from(String wadat_ist_from) {
		this.wadat_ist_from = wadat_ist_from;
	}

	public String getWadat_ist_to() {
		return wadat_ist_to;
	}

	public void setWadat_ist_to(String wadat_ist_to) {
		this.wadat_ist_to = wadat_ist_to;
	}

	public String getWadat() {
		return wadat;
	}

	public void setWadat(String wadat) {
		this.wadat = wadat;
	}

	public String getText_z001() {
		return text_z001;
	}

	public void setText_z001(String text_z001) {
		this.text_z001 = text_z001;
	}

	public String getVkorg() {
		return vkorg;
	}

	public void setVkorg(String vkorg) {
		this.vkorg = vkorg;
	}

	public String getVtext_vkorg() {
		return vtext_vkorg;
	}

	public void setVtext_vkorg(String vtext_vkorg) {
		this.vtext_vkorg = vtext_vkorg;
	}

	public String getVtweg() {
		return vtweg;
	}

	public void setVtweg(String vtweg) {
		this.vtweg = vtweg;
	}

	public String getVtext_vtweg() {
		return vtext_vtweg;
	}

	public void setVtext_vtweg(String vtext_vtweg) {
		this.vtext_vtweg = vtext_vtweg;
	}

	public String getSpart() {
		return spart;
	}


	public void setSpart(String spart) {
		this.spart = spart;
	}

	public String getVtext_spart() {
		return vtext_spart;
	}

	public void setVtext_spart(String vtext_spart) {
		this.vtext_spart = vtext_spart;
	}

	public String getVkbur() {
		return vkbur;
	}

	public void setVkbur(String vkbur) {
		this.vkbur = vkbur;
	}

	public String getBezei_vkbur() {
		return bezei_vkbur;
	}

	public void setBezei_vkbur(String bezei_vkbur) {
		this.bezei_vkbur = bezei_vkbur;
	}

	public String getVkgrp() {
		return vkgrp;
	}

	public void setVkgrp(String vkgrp) {
		this.vkgrp = vkgrp;
	}

	public String getBezei_vkgrp() {
		return bezei_vkgrp;
	}

	public void setBezei_vkgrp(String bezei_vkgrp) {
		this.bezei_vkgrp = bezei_vkgrp;
	}


	public String getInco1() {
		return inco1;
	}


	public void setInco1(String inco1) {
		this.inco1 = inco1;
	}

	public String getInco2() {
		return inco2;
	}

	public void setInco2(String inco2) {
		this.inco2 = inco2;
	}

	public String getVgbel() {
		return vgbel;
	}

	public void setVgbel(String vgbel) {
		this.vgbel = vgbel;
	}

	public String getVgpos() {
		return vgpos;
	}

	public void setVgpos(String vgpos) {
		this.vgpos = vgpos;
	}

	public String getKunnr_ag() {
		return kunnr_ag;
	}


	public void setKunnr_ag(String kunnr_ag) {
		this.kunnr_ag = kunnr_ag;
	}

	public String getName1_kunnr_ag() {
		return name1_kunnr_ag;
	}

	public void setName1_kunnr_ag(String name1_kunnr_ag) {
		this.name1_kunnr_ag = name1_kunnr_ag;
	}

	public String getName2_kunnr_ag() {
		return name2_kunnr_ag;
	}

	public void setName2_kunnr_ag(String name2_kunnr_ag) {
		this.name2_kunnr_ag = name2_kunnr_ag;
	}

	public String getLand1_kunnr_ag() {
		return land1_kunnr_ag;
	}

	public void setLand1_kunnr_ag(String land1_kunnr_ag) {
		this.land1_kunnr_ag = land1_kunnr_ag;
	}

	public String getCity1_kunnr_ag() {
		return city1_kunnr_ag;
	}


	public void setCity1_kunnr_ag(String city1_kunnr_ag) {
		this.city1_kunnr_ag = city1_kunnr_ag;
	}


	public String getStreet_kunnr_ag() {
		return street_kunnr_ag;
	}


	public void setStreet_kunnr_ag(String street_kunnr_ag) {
		this.street_kunnr_ag = street_kunnr_ag;
	}


	public String getStr_suppl1_kunnr_ag() {
		return str_suppl1_kunnr_ag;
	}


	public void setStr_suppl1_kunnr_ag(String str_suppl1_kunnr_ag) {
		this.str_suppl1_kunnr_ag = str_suppl1_kunnr_ag;
	}


	public String getStr_suppl2_kunnr_ag() {
		return str_suppl2_kunnr_ag;
	}

	public void setStr_suppl2_kunnr_ag(String str_suppl2_kunnr_ag) {
		this.str_suppl2_kunnr_ag = str_suppl2_kunnr_ag;
	}

	public String getPstlz_kunnr_ag() {
		return pstlz_kunnr_ag;
	}

	public void setPstlz_kunnr_ag(String pstlz_kunnr_ag) {
		this.pstlz_kunnr_ag = pstlz_kunnr_ag;
	}


	public String getJ_1kfrepre_kunnr_ag() {
		return j_1kfrepre_kunnr_ag;
	}

	public void setJ_1kfrepre_kunnr_ag(String j_1kfrepre_kunnr_ag) {
		this.j_1kfrepre_kunnr_ag = j_1kfrepre_kunnr_ag;
	}

	public String getJ_1kftind_kunnr_ag() {
		return j_1kftind_kunnr_ag;
	}


	public void setJ_1kftind_kunnr_ag(String j_1kftind_kunnr_ag) {
		this.j_1kftind_kunnr_ag = j_1kftind_kunnr_ag;
	}

 
	public String getJ_1kftbus_kunnr_ag() {
		return j_1kftbus_kunnr_ag;
	}

 
	public void setJ_1kftbus_kunnr_ag(String j_1kftbus_kunnr_ag) {
		this.j_1kftbus_kunnr_ag = j_1kftbus_kunnr_ag;
	}
 

	public String getStcd1_kunnr_ag() {
		return stcd1_kunnr_ag;
	}


	public void setStcd1_kunnr_ag(String stcd1_kunnr_ag) {
		this.stcd1_kunnr_ag = stcd1_kunnr_ag;
	}

	public String getStcd2_kunnr_ag() {
		return stcd2_kunnr_ag;
	}


	public void setStcd2_kunnr_ag(String stcd2_kunnr_ag) {
		this.stcd2_kunnr_ag = stcd2_kunnr_ag;
	}


	public String getStcd3_kunnr_ag() {
		return stcd3_kunnr_ag;
	}

	public void setStcd3_kunnr_ag(String stcd3_kunnr_ag) {
		this.stcd3_kunnr_ag = stcd3_kunnr_ag;
	}


	public String getTelf1_kunnr_ag() {
		return telf1_kunnr_ag;
	}

	public void setTelf1_kunnr_ag(String telf1_kunnr_ag) {
		this.telf1_kunnr_ag = telf1_kunnr_ag;
	}


	public String getTelf2_kunnr_ag() {
		return telf2_kunnr_ag;
	}

	public void setTelf2_kunnr_ag(String telf2_kunnr_ag) {
		this.telf2_kunnr_ag = telf2_kunnr_ag;
	}

	public String getTelfx_kunnr_ag() {
		return telfx_kunnr_ag;
	}

	public void setTelfx_kunnr_ag(String telfx_kunnr_ag) {
		this.telfx_kunnr_ag = telfx_kunnr_ag;
	}

	public String getSmtp_addr_kunnr_ag() {
		return smtp_addr_kunnr_ag;
	}

	public void setSmtp_addr_kunnr_ag(String smtp_addr_kunnr_ag) {
		this.smtp_addr_kunnr_ag = smtp_addr_kunnr_ag;
	}

	public String getKunnr_we() {
		return kunnr_we;
	}

	public void setKunnr_we(String kunnr_we) {
		this.kunnr_we = kunnr_we;
	}


	public String getName1_kunnr_we() {
		return name1_kunnr_we;
	}


	public void setName1_kunnr_we(String name1_kunnr_we) {
		this.name1_kunnr_we = name1_kunnr_we;
	}


	public String getName2_kunnr_we() {
		return name2_kunnr_we;
	}

	public void setName2_kunnr_we(String name2_kunnr_we) {
		this.name2_kunnr_we = name2_kunnr_we;
	}

	public String getLand1_kunnr_we() {
		return land1_kunnr_we;
	}

	public void setLand1_kunnr_we(String land1_kunnr_we) {
		this.land1_kunnr_we = land1_kunnr_we;
	}

	public String getCity1_kunnr_we() {
		return city1_kunnr_we;
	}


	public void setCity1_kunnr_we(String city1_kunnr_we) {
		this.city1_kunnr_we = city1_kunnr_we;
	}


	public String getStreet_kunnr_we() {
		return street_kunnr_we;
	}


	public void setStreet_kunnr_we(String street_kunnr_we) {
		this.street_kunnr_we = street_kunnr_we;
	}


	public String getStr_suppl1_kunnr_we() {
		return str_suppl1_kunnr_we;
	}


	public void setStr_suppl1_kunnr_we(String str_suppl1_kunnr_we) {
		this.str_suppl1_kunnr_we = str_suppl1_kunnr_we;
	}

	public String getStr_suppl2_kunnr_we() {
		return str_suppl2_kunnr_we;
	}

	public void setStr_suppl2_kunnr_we(String str_suppl2_kunnr_we) {
		this.str_suppl2_kunnr_we = str_suppl2_kunnr_we;
	}

	public String getPstlz_kunnr_we() {
		return pstlz_kunnr_we;
	}


	public void setPstlz_kunnr_we(String pstlz_kunnr_we) {
		this.pstlz_kunnr_we = pstlz_kunnr_we;
	}






	public String getJ_1kfrepre_kunnr_we() {
		return j_1kfrepre_kunnr_we;
	}






	public void setJ_1kfrepre_kunnr_we(String j_1kfrepre_kunnr_we) {
		this.j_1kfrepre_kunnr_we = j_1kfrepre_kunnr_we;
	}






	public String getJ_1kftind_kunnr_we() {
		return j_1kftind_kunnr_we;
	}






	public void setJ_1kftind_kunnr_we(String j_1kftind_kunnr_we) {
		this.j_1kftind_kunnr_we = j_1kftind_kunnr_we;
	}






	public String getJ_1kftbus_kunnr_we() {
		return j_1kftbus_kunnr_we;
	}






	public void setJ_1kftbus_kunnr_we(String j_1kftbus_kunnr_we) {
		this.j_1kftbus_kunnr_we = j_1kftbus_kunnr_we;
	}






	public String getStcd1_kunnr_we() {
		return stcd1_kunnr_we;
	}






	public void setStcd1_kunnr_we(String stcd1_kunnr_we) {
		this.stcd1_kunnr_we = stcd1_kunnr_we;
	}






	public String getStcd2_kunnr_we() {
		return stcd2_kunnr_we;
	}






	public void setStcd2_kunnr_we(String stcd2_kunnr_we) {
		this.stcd2_kunnr_we = stcd2_kunnr_we;
	}






	public String getStcd3_kunnr_we() {
		return stcd3_kunnr_we;
	}






	public void setStcd3_kunnr_we(String stcd3_kunnr_we) {
		this.stcd3_kunnr_we = stcd3_kunnr_we;
	}






	public String getTelf1_kunnr_we() {
		return telf1_kunnr_we;
	}






	public void setTelf1_kunnr_we(String telf1_kunnr_we) {
		this.telf1_kunnr_we = telf1_kunnr_we;
	}






	public String getTelf2_kunnr_we() {
		return telf2_kunnr_we;
	}






	public void setTelf2_kunnr_we(String telf2_kunnr_we) {
		this.telf2_kunnr_we = telf2_kunnr_we;
	}




	public String getTelfx_kunnr_we() {
		return telfx_kunnr_we;
	}

	public void setTelfx_kunnr_we(String telfx_kunnr_we) {
		this.telfx_kunnr_we = telfx_kunnr_we;
	}




	public String getSmtp_addr_kunnr_we() {
		return smtp_addr_kunnr_we;
	}






	public void setSmtp_addr_kunnr_we(String smtp_addr_kunnr_we) {
		this.smtp_addr_kunnr_we = smtp_addr_kunnr_we;
	}






	public String getKunnr_z1() {
		return kunnr_z1;
	}






	public void setKunnr_z1(String kunnr_z1) {
		this.kunnr_z1 = kunnr_z1;
	}






	public String getName1_kunnr_z1() {
		return name1_kunnr_z1;
	}






	public void setName1_kunnr_z1(String name1_kunnr_z1) {
		this.name1_kunnr_z1 = name1_kunnr_z1;
	}






	public String getName2_kunnr_z1() {
		return name2_kunnr_z1;
	}






	public void setName2_kunnr_z1(String name2_kunnr_z1) {
		this.name2_kunnr_z1 = name2_kunnr_z1;
	}






	public String getKunnr_z2() {
		return kunnr_z2;
	}






	public void setKunnr_z2(String kunnr_z2) {
		this.kunnr_z2 = kunnr_z2;
	}






	public String getName1_kunnr_z2() {
		return name1_kunnr_z2;
	}






	public void setName1_kunnr_z2(String name1_kunnr_z2) {
		this.name1_kunnr_z2 = name1_kunnr_z2;
	}






	public String getTelf2_kunnr_z2() {
		return telf2_kunnr_z2;
	}

	public void setTelf2_kunnr_z2(String telf2_kunnr_z2) {
		this.telf2_kunnr_z2 = telf2_kunnr_z2;
	}






	public String getErdat_so() {
		return erdat_so;
	}






	public void setErdat_so(String erdat_so) {
		this.erdat_so = erdat_so;
	}






	public String getErnam_so() {
		return ernam_so;
	}






	public void setErnam_so(String ernam_so) {
		this.ernam_so = ernam_so;
	}






	public String getAuart() {
		return auart;
	}






	public void setAuart(String auart) {
		this.auart = auart;
	}






	public String getBezei_auart() {
		return bezei_auart;
	}






	public void setBezei_auart(String bezei_auart) {
		this.bezei_auart = bezei_auart;
	}






	public String getAugru() {
		return augru;
	}






	public void setAugru(String augru) {
		this.augru = augru;
	}






	public String getBezei_augru() {
		return bezei_augru;
	}






	public void setBezei_augru(String bezei_augru) {
		this.bezei_augru = bezei_augru;
	}






	public String getEdatu() {
		return edatu;
	}






	public void setEdatu(String edatu) {
		this.edatu = edatu;
	}






	public String getKwmeng() {
		return kwmeng;
	}






	public void setKwmeng(String kwmeng) {
		this.kwmeng = kwmeng;
	}






	public String getVrkme_so() {
		return vrkme_so;
	}






	public void setVrkme_so(String vrkme_so) {
		this.vrkme_so = vrkme_so;
	}






	public String getOrigin_vbeln() {
		return origin_vbeln;
	}






	public void setOrigin_vbeln(String origin_vbeln) {
		this.origin_vbeln = origin_vbeln;
	}






	public String getZzwarranty() {
		return zzwarranty;
	}






	public void setZzwarranty(String zzwarranty) {
		this.zzwarranty = zzwarranty;
	}






	public String getBstkd() {
		return bstkd;
	}






	public void setBstkd(String bstkd) {
		this.bstkd = bstkd;
	}






	public String getName_p4() {
		return name_p4;
	}






	public void setName_p4(String name_p4) {
		this.name_p4 = name_p4;
	}






	public String getPst_p4() {
		return pst_p4;
	}






	public void setPst_p4(String pst_p4) {
		this.pst_p4 = pst_p4;
	}






	public String getDpt_p4() {
		return dpt_p4;
	}






	public void setDpt_p4(String dpt_p4) {
		this.dpt_p4 = dpt_p4;
	}






	public String getPhone_p4() {
		return phone_p4;
	}






	public void setPhone_p4(String phone_p4) {
		this.phone_p4 = phone_p4;
	}






	public String getEmail_p4() {
		return email_p4;
	}






	public void setEmail_p4(String email_p4) {
		this.email_p4 = email_p4;
	}






	public String getSernp() {
		return sernp;
	}






	public void setSernp(String sernp) {
		this.sernp = sernp;
	}




 

	public String getStrgr() {
		return strgr;
	}

	public void setStrgr(String strgr) {
		this.strgr = strgr;
	}

	public ArrayList<String> getMatnrList() {
		return matnrList;
	}

	public void setMatnrList(ArrayList<String> matnrList) {
		this.matnrList = matnrList;
	}

	public String getSernr() {
		return sernr;
	}

	public void setSernr(String sernr) {
		this.sernr = sernr;
	}

	public String getUni_key() {
		return uni_key;
	}

	public void setUni_key(String uni_key) {
		this.uni_key = uni_key;
	}

	public String getVbeln_gr() {
		return vbeln_gr;
	}

	public void setVbeln_gr(String vbeln_gr) {
		this.vbeln_gr = vbeln_gr;
	}

	@Override
	public String toString() {
		return "SYShipmentVo [vbeln=" + vbeln + ", posnr=" + posnr
				+ ", if_flag=" + if_flag + ", shipment_status="
				+ shipment_status + ", shipment_status_nm="
				+ shipment_status_nm + ", lfart=" + lfart + ", vtext_lfart="
				+ vtext_lfart + ", vstel=" + vstel + ", vtext_vstel="
				+ vtext_vstel + ", werks=" + werks + ", name1_werks="
				+ name1_werks + ", lgort=" + lgort + ", lgobe=" + lgobe
				+ ", matnr=" + matnr + ", arktx=" + arktx + ", lfimg=" + lfimg
				+ ", vrkme_do=" + vrkme_do + ", lgmng=" + lgmng + ", meins_do="
				+ meins_do + ", umvkz=" + umvkz + ", umvkn=" + umvkn
				+ ", uebto=" + uebto + ", erdat_do=" + erdat_do + ", ernam_do="
				+ ernam_do + ", wadat_ist=" + wadat_ist + ", wadat_ist_from="
				+ wadat_ist_from + ", wadat_ist_to=" + wadat_ist_to
				+ ", wadat=" + wadat + ", wadat_from=" + wadat_from
				+ ", wadat_to=" + wadat_to + ", text_z001=" + text_z001
				+ ", vkorg=" + vkorg + ", vtext_vkorg=" + vtext_vkorg
				+ ", vtweg=" + vtweg + ", vtext_vtweg=" + vtext_vtweg
				+ ", spart=" + spart + ", vtext_spart=" + vtext_spart
				+ ", vkbur=" + vkbur + ", bezei_vkbur=" + bezei_vkbur
				+ ", vkgrp=" + vkgrp + ", bezei_vkgrp=" + bezei_vkgrp
				+ ", inco1=" + inco1 + ", inco2=" + inco2 + ", vgbel=" + vgbel
				+ ", vgpos=" + vgpos + ", kunnr_ag=" + kunnr_ag
				+ ", name1_kunnr_ag=" + name1_kunnr_ag + ", name2_kunnr_ag="
				+ name2_kunnr_ag + ", land1_kunnr_ag=" + land1_kunnr_ag
				+ ", city1_kunnr_ag=" + city1_kunnr_ag + ", street_kunnr_ag="
				+ street_kunnr_ag + ", str_suppl1_kunnr_ag="
				+ str_suppl1_kunnr_ag + ", str_suppl2_kunnr_ag="
				+ str_suppl2_kunnr_ag + ", pstlz_kunnr_ag=" + pstlz_kunnr_ag
				+ ", j_1kfrepre_kunnr_ag=" + j_1kfrepre_kunnr_ag
				+ ", j_1kftind_kunnr_ag=" + j_1kftind_kunnr_ag
				+ ", j_1kftbus_kunnr_ag=" + j_1kftbus_kunnr_ag
				+ ", stcd1_kunnr_ag=" + stcd1_kunnr_ag + ", stcd2_kunnr_ag="
				+ stcd2_kunnr_ag + ", stcd3_kunnr_ag=" + stcd3_kunnr_ag
				+ ", telf1_kunnr_ag=" + telf1_kunnr_ag + ", telf2_kunnr_ag="
				+ telf2_kunnr_ag + ", telfx_kunnr_ag=" + telfx_kunnr_ag
				+ ", smtp_addr_kunnr_ag=" + smtp_addr_kunnr_ag + ", kunnr_we="
				+ kunnr_we + ", name1_kunnr_we=" + name1_kunnr_we
				+ ", name2_kunnr_we=" + name2_kunnr_we + ", land1_kunnr_we="
				+ land1_kunnr_we + ", city1_kunnr_we=" + city1_kunnr_we
				+ ", street_kunnr_we=" + street_kunnr_we
				+ ", str_suppl1_kunnr_we=" + str_suppl1_kunnr_we
				+ ", str_suppl2_kunnr_we=" + str_suppl2_kunnr_we
				+ ", pstlz_kunnr_we=" + pstlz_kunnr_we
				+ ", j_1kfrepre_kunnr_we=" + j_1kfrepre_kunnr_we
				+ ", j_1kftind_kunnr_we=" + j_1kftind_kunnr_we
				+ ", j_1kftbus_kunnr_we=" + j_1kftbus_kunnr_we
				+ ", stcd1_kunnr_we=" + stcd1_kunnr_we + ", stcd2_kunnr_we="
				+ stcd2_kunnr_we + ", stcd3_kunnr_we=" + stcd3_kunnr_we
				+ ", telf1_kunnr_we=" + telf1_kunnr_we + ", telf2_kunnr_we="
				+ telf2_kunnr_we + ", telfx_kunnr_we=" + telfx_kunnr_we
				+ ", smtp_addr_kunnr_we=" + smtp_addr_kunnr_we + ", kunnr_z1="
				+ kunnr_z1 + ", name1_kunnr_z1=" + name1_kunnr_z1
				+ ", name2_kunnr_z1=" + name2_kunnr_z1 + ", kunnr_z2="
				+ kunnr_z2 + ", name1_kunnr_z2=" + name1_kunnr_z2
				+ ", telf2_kunnr_z2=" + telf2_kunnr_z2 + ", erdat_so="
				+ erdat_so + ", ernam_so=" + ernam_so + ", auart=" + auart
				+ ", bezei_auart=" + bezei_auart + ", augru=" + augru
				+ ", bezei_augru=" + bezei_augru + ", edatu=" + edatu
				+ ", kwmeng=" + kwmeng + ", vrkme_so=" + vrkme_so
				+ ", origin_vbeln=" + origin_vbeln + ", zzwarranty="
				+ zzwarranty + ", bstkd=" + bstkd + ", name_p4=" + name_p4
				+ ", pst_p4=" + pst_p4 + ", dpt_p4=" + dpt_p4 + ", phone_p4="
				+ phone_p4 + ", email_p4=" + email_p4 + ", sernp=" + sernp
				+ ", strgr=" + strgr + ", funcName=" + funcName
				+ ", edatu_from=" + edatu_from + ", edatu_to=" + edatu_to
				+ ", uni_key=" + uni_key + ", vbeln_gr=" + vbeln_gr
				+ ", matnrList=" + matnrList + ", sernr=" + sernr
				+ ", i_shipment_gubun=" + i_shipment_gubun + ", zzswoption="
				+ zzswoption + ", dtatwtb_s=" + dtatwtb_s + ", dtsernr="
				+ dtsernr + ", dtdmr_no=" + dtdmr_no + ", dtrn_no=" + dtrn_no
				+ ", vsatwtb_s=" + vsatwtb_s + ", vssernr=" + vssernr
				+ ", vsdmr_no=" + vsdmr_no + ", vsrn_no=" + vsrn_no
				+ ", psatwtb_s=" + psatwtb_s + ", pssernr=" + pssernr
				+ ", psdmr_no=" + psdmr_no + ", psrn_no=" + psrn_no
				+ ", chatwtb_s=" + chatwtb_s + ", chsernr=" + chsernr
				+ ", chdmr_no=" + chdmr_no + ", chrn_no=" + chrn_no
				+ ", rcatwtb_s=" + rcatwtb_s + ", rcsernr=" + rcsernr
				+ ", rcdmr_no=" + rcdmr_no + ", rcrn_no=" + rcrn_no
				+ ", rsatwtb_s=" + rsatwtb_s + ", rssernr=" + rssernr
				+ ", rsdmr_no=" + rsdmr_no + ", rsrn_no=" + rsrn_no
				+ ", rwatwtb_s=" + rwatwtb_s + ", rwsernr=" + rwsernr
				+ ", rwdmr_no=" + rwdmr_no + ", rwrn_no=" + rwrn_no + "]";
	}

 
}
