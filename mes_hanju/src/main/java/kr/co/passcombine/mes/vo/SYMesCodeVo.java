package kr.co.passcombine.mes.vo;

import java.io.Serializable;

public class SYMesCodeVo implements Serializable{
	private String code_cat;	//'코드분류',
	private String code;		//'코드',
	private String code_nm;		//'코드명',
	private int dis_seq;		//'표시순서',
	private String use_yn;		//'사용여부',
	private String ref1;		//'참조1',
	private String ref2;		//'참조2',
	private String ref3;		//'참조3',
	private String ref4;		//'참조4',
	private String ref5;		//'참조5',
	private String rmk;			//'비고',	
	
	public String getCode_cat() {
		return code_cat;
	}
	public void setCode_cat(String code_cat) {
		this.code_cat = code_cat;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getCode_nm() {
		return code_nm;
	}
	public void setCode_nm(String code_nm) {
		this.code_nm = code_nm;
	}
	public int getDis_seq() {
		return dis_seq;
	}
	public void setDis_seq(int dis_seq) {
		this.dis_seq = dis_seq;
	}
	public String getUse_yn() {
		return use_yn;
	}
	public void setUse_yn(String use_yn) {
		this.use_yn = use_yn;
	}
	public String getRef1() {
		return ref1;
	}
	public void setRef1(String ref1) {
		this.ref1 = ref1;
	}
	public String getRef2() {
		return ref2;
	}
	public void setRef2(String ref2) {
		this.ref2 = ref2;
	}
	public String getRef3() {
		return ref3;
	}
	public void setRef3(String ref3) {
		this.ref3 = ref3;
	}
	public String getRef4() {
		return ref4;
	}
	public void setRef4(String ref4) {
		this.ref4 = ref4;
	}
	public String getRef5() {
		return ref5;
	}
	public void setRef5(String ref5) {
		this.ref5 = ref5;
	}
	public String getRmk() {
		return rmk;
	}
	public void setRmk(String rmk) {
		this.rmk = rmk;
	}
	
	@Override
	public String toString() {
		return "SYMesCodeVo [code_cat=" + code_cat + ", code=" + code
				+ ", code_nm=" + code_nm + ", dis_seq=" + dis_seq + ", use_yn="
				+ use_yn + ", ref1=" + ref1 + ", ref2=" + ref2 + ", ref3="
				+ ref3 + ", ref4=" + ref4 + ", ref5=" + ref5 + ", rmk=" + rmk
				+ "]";
	}
}
