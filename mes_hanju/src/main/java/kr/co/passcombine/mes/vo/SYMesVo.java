package kr.co.passcombine.mes.vo;

import java.io.Serializable;

public class SYMesVo implements Serializable{
	
	private String pordno_pop;	// mes key
	private String pordno;		// 'sap key',
	private Integer rsnum;		// '예약번호',
	private String rspos;			// '예약품목번호',
	private String matnr;			// '자재번호',
	private Integer bdmng;		// '소요량',
	private String meins;			// '단위',
	private String xloek;			// '삭제표시 X-삭제',
	private String schgt;			// '벌크 X-벌크자재',
	private String werks;			// '플랜트',
	private String lgort;			// '저장위치',
	private String dept_cd;		// '사업부코드(의료1110,광1120)',
	private String dept_nm;		// '사업부코드명(의료1110,광1120)',
	private String requester_status;		// '요청상태(요청완료\'Y\')',
	private String requester_if_status;	// '요청상태(RFC전송완료 \'Y\',오류 E)',
	private String request_if_msg;		// '전송오류 \'E\' 상태 RFC 오류 메시지',
	private String grantor_status;		// '예약승인확인상태(확인완료\'Y\')',
	private String grantor_if_status;		// 'SAP RFC 확인 전송상태(RFC전송완료 \'Y\',오류 E)',
	private String grantor_if_msg;		// 'SAP RFC 확인 전송오류 \'E\' 상태 RFC 오류 메시지',
	private String creator;			// '작성자',
	private String grantor;			// '승인확인자',
	private String creator_date;		// '요청일자',
	private String grantor_date;		// '확인일자',
	private String date_created;		// '생성일자',
	private String date_updated;		// '수정일자',
	
	private String jidat_from;
	private String jidat_to;
	private String functionName;
  
  	private Integer page;
	private Integer rows;
	private Integer rnum;
	private String sidx;
	private String sord;
  
	public void setPordno_pop(String pordno_pop) {
		this.pordno_pop = pordno_pop;
	}
	public void setPordno(String pordno) {
		this.pordno = pordno;
	}
	public void setRsnum(Integer rsnum) {
		this.rsnum = rsnum;
	}
	public void setRspos(String rspos) {
		this.rspos = rspos;
	}
	public void setMatnr(String matnr) {
		this.matnr = matnr;
	}
	public void setBdmng(Integer bdmng) {
		this.bdmng = bdmng;
	}
	public void setMeins(String meins) {
		this.meins = meins;
	}
	public void setXloek(String xloek) {
		this.xloek = xloek;
	}
	public void setSchgt(String schgt) {
		this.schgt = schgt;
	}
	public void setWerks(String werks) {
		this.werks = werks;
	}
	public void setLgort(String lgort) {
		this.lgort = lgort;
	}
	public void setDept_cd(String dept_cd) {
		this.dept_cd = dept_cd;
	}
	public void setDept_nm(String dept_nm) {
		this.dept_nm = dept_nm;
	}
	public void setRequester_status(String requester_status) {
		this.requester_status = requester_status;
	}
	public void setRequester_if_status(String requester_if_status) {
		this.requester_if_status = requester_if_status;
	}
	public void setRequest_if_msg(String request_if_msg) {
		this.request_if_msg = request_if_msg;
	}
	public void setGrantor_status(String grantor_status) {
		this.grantor_status = grantor_status;
	}
	public void setGrantor_if_status(String grantor_if_status) {
		this.grantor_if_status = grantor_if_status;
	}
	public void setGrantor_if_msg(String grantor_if_msg) {
		this.grantor_if_msg = grantor_if_msg;
	}
	public void setCreator(String creator) {
		this.creator = creator;
	}
	public void setGrantor(String grantor) {
		this.grantor = grantor;
	}
	public void setCreator_date(String creator_date) {
		this.creator_date = creator_date;
	}
	public void setGrantor_date(String grantor_date) {
		this.grantor_date = grantor_date;
	}
	public void setDate_created(String date_created) {
		this.date_created = date_created;
	}
	public void setDate_updated(String date_updated) {
		this.date_updated = date_updated;
	}
	public void setJidat_from(String jidat_from) {
		this.jidat_from = jidat_from;
	}
	public void setJidat_to(String jidat_to) {
		this.jidat_to = jidat_to;
	}
	public void setFunctionName(String functionName) {
		this.functionName = functionName;
	}
	public void setPage(Integer page) {
		this.page = page;
	}
	public void setRows(Integer rows) {
		this.rows = rows;
	}
	public void setRnum(Integer rnum) {
		this.rnum = rnum;
	}
	public void setSidx(String sidx) {
		this.sidx = sidx;
	}
	public void setSord(String sord) {
		this.sord = sord;
	}
	public String getFunctionName() {
		return functionName;
	}
	public String getPordno_pop() {
		return pordno_pop;
	}
	public String getPordno() {
		return pordno;
	}
	public Integer getRsnum() {
		return rsnum;
	}
	public String getRspos() {
		return rspos;
	}
	public String getMatnr() {
		return matnr;
	}
	public Integer getBdmng() {
		return bdmng;
	}
	public String getMeins() {
		return meins;
	}
	public String getXloek() {
		return xloek;
	}
	public String getSchgt() {
		return schgt;
	}
	public String getWerks() {
		return werks;
	}
	public String getLgort() {
		return lgort;
	}
	public String getDept_cd() {
		return dept_cd;
	}
	public String getDept_nm() {
		return dept_nm;
	}
	public String getRequester_status() {
		return requester_status;
	}
	public String getRequester_if_status() {
		return requester_if_status;
	}
	public String getRequest_if_msg() {
		return request_if_msg;
	}
	public String getGrantor_status() {
		return grantor_status;
	}
	public String getGrantor_if_status() {
		return grantor_if_status;
	}
	public String getGrantor_if_msg() {
		return grantor_if_msg;
	}
	public String getCreator() {
		return creator;
	}
	public String getGrantor() {
		return grantor;
	}
	public String getCreator_date() {
		return creator_date;
	}
	public String getGrantor_date() {
		return grantor_date;
	}
	public String getDate_created() {
		return date_created;
	}
	public String getDate_updated() {
		return date_updated;
	}
	public String getJidat_from() {
		return jidat_from;
	}
	public String getJidat_to() {
		return jidat_to;
	}
	public Integer getPage() {
		return page;
	}
	public Integer getRows() {
		return rows;
	}
	public Integer getRnum() {
		return rnum;
	}
	public String getSidx() {
		return sidx;
	}
	public String getSord() {
		return sord;
	}
	@Override
	public String toString() {
		return "SYMesVo [pordno_pop=" + pordno_pop + ", pordno=" + pordno
				+ ", rsnum=" + rsnum + ", rspos=" + rspos + ", matnr=" + matnr
				+ ", bdmng=" + bdmng + ", meins=" + meins + ", xloek=" + xloek
				+ ", schgt=" + schgt + ", werks=" + werks + ", lgort=" + lgort
				+ ", dept_cd=" + dept_cd + ", requester_status="
				+ requester_status + ", requester_if_status="
				+ requester_if_status + ", request_if_msg=" + request_if_msg
				+ ", grantor_status=" + grantor_status + ", grantor_if_status="
				+ grantor_if_status + ", grantor_if_msg=" + grantor_if_msg
				+ ", creator=" + creator + ", grantor=" + grantor
				+ ", creator_date=" + creator_date + ", grantor_date="
				+ grantor_date + ", date_created=" + date_created
				+ ", date_updated=" + date_updated + "]";
	}
  
}
